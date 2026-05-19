# Nuclear / Tier 0 Pull Request

**This PR touches Layer 0 or hooks.** It requires maximum rigor.

## Mandatory Requirements

1. Full harness execution (`/first-questions` + research + `/universe` + verifier PASS)
2. `./scripts/simulate-contribution.sh --tier0 --verify-injection` must PASS
3. `universe-doctor --verbose` from a **clean Local Marketplace install**
4. At least two human stewards must explicitly approve in the PR
5. 72-hour observation window after merge (with defined rollback plan)

## Evidence Checklist

- [ ] Harness artifacts attached (first-questions, research, verifier verdict)
- [ ] Simulation evidence file linked (from `contrib-evidence/`)
- [ ] Doctor report from clean environment
- [ ] Reasoning Ledger commits with proper ancestry
- [ ] Rollback plan documented

**Failure to meet these requirements will result in the PR being closed without merge.**

See `GOVERNANCE.md` → Tier 0 process for full details.