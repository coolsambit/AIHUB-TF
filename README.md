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

### Agents
Agent definitions (model, instructions, tools, guardrails) must be exported via the Azure AI Projects SDK and saved as JSON files in source control.

**Export:** Run the export script to pull all agent definitions from each project and save to `/scripts/agents/`

**Restore:** Run the restore script to recreate agents from the saved JSON files after Terraform has restored the Foundry infrastructure.

### Knowledge Indexes
Indexes are backed by the `aisearch-2024` Azure AI Search service in resource group `AI-102`.
- Export index schema via the Azure AI Search REST API
- Re-index from the original data source

### Custom Guardrails
Export guardrail configurations via the Azure AI Foundry REST API and store as JSON in `/scripts/guardrails/`

### Data Stores (assistant-xxx)
These contain conversation threads and vector data. Treat as **ephemeral** — they cannot be meaningfully restored. Back up source documents instead.

### Microsoft.Default / Microsoft.DefaultV2 Guardrails
Built-in — always available, no backup needed.

---

## AI Gateway

The AI Gateway (`aigatewayaids`) is in resource group `AI-102` and is referenced as a data source only. It is **not managed** by this Terraform project.

## Reference

- Subscription: `74beb7e5-9547-4a02-a2c2-68d4b3804ebf`
- Resource Group: `AI-100`
- AI Foundry Portal: [ai.azure.com](https://ai.azure.com)
- Connections are found under: **Project → Tools** in the Foundry portal
