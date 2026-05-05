# Azure AI Foundry — Terraform Infrastructure

Manages the `Aids-Foundry-Dev` AI Services account and its projects in the `AI-100` resource group.

## Resources Managed by Terraform

| Resource | Type |
|---|---|
| AIManagedIdentity | User Assigned Identity |
| Aids-Foundry-Dev | Azure AI Services account |
| proj-BU1 | AI Foundry Project |
| proj-BU2 | AI Foundry Project |
| o4-mini-1 | Model Deployment (GlobalStandard, 500k TPM) |
| gpt-4o-1 | Model Deployment (GlobalStandard, 225k TPM) |
| text-embedding-3-small | Model Deployment (Standard, 120k TPM) |
| aisearch2024h299w2 | AI Search Connection (proj-BU1) |
| aisearch2024qpuevj | AI Search Connection (proj-BU2) |
| GitHub | MCP Tool Connection (proj-BU2) |
| FoundryMCPServerpreview | MCP Tool Connection (proj-BU2) |

## Usage

```bash
# First time setup
terraform init
terraform plan -out=tfplan
terraform apply tfplan

# Restore after deletion (remove imports.tf blocks first)
terraform apply
```

> **Note:** Remove all `import {}` blocks from `imports.tf` before running `terraform apply` to restore — they are one-time import operations and will error if the resources no longer exist.

---

## Resources NOT Managed by Terraform (Data Plane)

The following resources live inside the Foundry projects and are **not managed by Terraform**. They must be backed up and restored separately.

| Resource | Project | Notes |
|---|---|---|
| MyStoryTeller, FoundryAgent, SearchAgent, sad-docs | proj-BU1 | Agents |
| BestPartyHost | proj-BU2 | Agent |
| alaska-documents, index_funny_cow_sh1c5qm04v | proj-BU1 | Knowledge Indexes |
| alaska-documents | proj-BU2 | Knowledge Index |
| GuardRail-Sam, Guardrails96 | Both | Custom Guardrails |
| assistant-Xh7dJhzuBC2aLcxtgdHzdU, assistant-BeC17zufmQtupeheGQ4hdR | Both | Data Stores |

### Why Terraform Cannot Manage These

These are **data plane** objects — they live inside the Foundry runtime (not Azure Resource Manager) and have no ARM resource ID. Terraform only manages ARM resources.

---

## Backup & Restore Strategy for Data Plane Resources

### Full Restore Order

After `terraform apply` has recreated the Foundry infrastructure, restore data plane resources in this order:

1. Restore Custom Guardrails (agents depend on them)
2. Restore Knowledge Indexes (agents reference them as tools)
3. Restore Agents (depend on guardrails, indexes, and model deployments)
4. Reconnect Agents to Tools (AI Search, GitHub, MCP)

---

### 1. Custom Guardrails (GuardRail-Sam, Guardrails96)

**Backup:**
```bash
az rest --method GET \
  --url "https://management.azure.com/subscriptions/&lt;subscription-id&gt;/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/raiPolicies?api-version=2025-04-01-preview" \
  --output json > scripts/guardrails/guardrails-backup.json
```

**Restore:**
```bash
# For each guardrail in the backup JSON
az rest --method PUT \
  --url "https://management.azure.com/subscriptions/&lt;subscription-id&gt;/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/raiPolicies/{guardrail-name}?api-version=2025-04-01-preview" \
  --body @scripts/guardrails/{guardrail-name}.json
```

`Microsoft.Default` and `Microsoft.DefaultV2` are built-in — no restore needed.

---

### 2. Knowledge Indexes (alaska-documents, index_funny_cow_sh1c5qm04v)

Indexes are stored in the `aisearch-2024` AI Search service (resource group `AI-102`).

**Backup index schema:**
```bash
az rest --method GET \
  --url "https://aisearch-2024.search.windows.net/indexes?api-version=2024-05-01-preview" \
  --headers "api-key=<your-search-admin-key>" \
  --output json > scripts/indexes/indexes-backup.json
```

**Restore:**
1. Recreate the index schema from the backup JSON via the AI Search REST API
2. Re-run the original data ingestion pipeline to re-index documents into the restored index
3. Reconnect the index to the Foundry project via **Project → Tools → Add connection**

---

### 3. Agents

Agent definitions (name, model, instructions, tools, guardrail assignment) must be exported before any deletion occurs and saved to `scripts/agents/`.

**Backup (proj-BU1):**
```bash
az rest --method GET \
  --url "https://aids-foundry-dev.services.ai.azure.com/agents/v1.0/subscriptions/&lt;subscription-id&gt;/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/proj-BU1/assistants?api-version=v1" \
  --output json > scripts/agents/proj-bu1-agents-backup.json
```

**Backup (proj-BU2):**
```bash
az rest --method GET \
  --url "https://aids-foundry-dev.services.ai.azure.com/agents/v1.0/subscriptions/&lt;subscription-id&gt;/resourceGroups/AI-100/providers/Microsoft.CognitiveServices/accounts/Aids-Foundry-Dev/projects/Proj-BU2/assistants?api-version=v1" \
  --output json > scripts/agents/proj-bu2-agents-backup.json
```

**Restore:**
1. Ensure Terraform apply is complete (Foundry + projects + model deployments + connections all restored)
2. Ensure guardrails and indexes are restored first
3. Recreate each agent via the Foundry portal or the restore script using the backup JSON:

```bash
az rest --method POST \
  --url "https://aids-foundry-dev.services.ai.azure.com/agents/v1.0/.../proj-BU1/assistants?api-version=v1" \
  --body @scripts/agents/{agent-definition}.json
```

| Agent | Project | Model | Guardrail |
|---|---|---|---|
| MyStoryTeller | proj-BU1 | o4-mini-1 | GuardRail-Sam |
| FoundryAgent | proj-BU1 | gpt-4o-1 | GuardRail-Sam |
| SearchAgent | proj-BU1 | gpt-4o-1 | GuardRail-Sam |
| sad-docs | proj-BU1 | gpt-4o-1 | GuardRail-Sam |
| BestPartyHost | proj-BU2 | o4-mini-1 | GuardRail-Sam |

---

### 4. Data Stores (assistant-Xh7dJhzuBC2aLcxtgdHzdU, assistant-BeC17zufmQtupeheGQ4hdR)

These contain conversation thread history and vector data. They **cannot be meaningfully restored** — treat as ephemeral. Ensure original source documents are preserved so vector stores can be rebuilt by re-running the ingestion pipeline.

---

### Summary Restore Checklist

- [ ] Run `terraform apply` to restore infrastructure
- [ ] Restore custom guardrails from `scripts/guardrails/`
- [ ] Restore AI Search index schemas from `scripts/indexes/`
- [ ] Re-run data ingestion pipeline to repopulate indexes
- [ ] Restore agents from `scripts/agents/` backup JSONs
- [ ] Verify agent tool connections (AI Search, GitHub, MCP) in Foundry portal
- [ ] Test each agent in the Foundry playground

---

## AI Gateway

The AI Gateway (`aigatewayaids`) is in resource group `AI-102` and is referenced as a data source only. It is **not managed** by this Terraform project.

## Reference

- Subscription: `&lt;subscription-id&gt;`
- Resource Group: `AI-100`
- AI Foundry Portal: [ai.azure.com](https://ai.azure.com)
- Connections are found under: **Project → Tools** in the Foundry portal
