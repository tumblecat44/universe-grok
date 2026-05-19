# Pull Request

**Please run the risk classifier first:**

```bash
./scripts/classify-risk.sh --auto
```

Copy the `TIER:` output and paste it at the top of this PR description.

---

## Risk Tier

**TIER:** (paste result from classify-risk.sh here)

---

## Required Evidence (depends on tier)

- **All tiers**: `./scripts/universe-doctor.sh --verbose` output (paste key sections)
- **Tier 1+**: Link to first-questions / research artifacts produced under the harness
- **Tier 0 (Nuclear)**: Output from `bash scripts/simulate-contribution.sh --tier0 --verify-injection`

---

## Installation Method Used for Testing

- [ ] LOCAL_MARKETPLACE (recommended)
- [ ] RAW_SYMLINK (only for rapid iteration, not for final PR evidence)
- [ ] Other: ________

**Doctor must confirm the method above.**

---

## Summary of Changes

(Describe what was changed and why. For Tier 0/1, explain the blast radius.)

---

## Checklist

- [ ] I have read `GOVERNANCE.md`
- [ ] I followed the Local Marketplace golden path (or have a very good reason not to)
- [ ] `universe-doctor` was run and its output is attached
- [ ] Commits follow the Reasoning Ledger convention
- [ ] For Tier 0: simulation evidence artifact is attached or linked

---

**Thank you.** Strong contributions make the truth-seeking harness stronger.