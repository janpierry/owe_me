---
name: issue-description
description: Draft a concise GitHub issue description for the owe_me repo into issue-description.md. Use when the user wants to create or write an issue, draft an issue description, or prepare an issue to open on GitHub.
---

# Issue Description

Draft a GitHub issue description and write it to `issue-description.md` at the repo
root. The file is a reusable scratch file — **overwrite it fully** each run.

## Guiding principle: brief and specific

Short, high-signal text a reader grasps in seconds. No filler, no restating the
obvious, no padding. **Omit any section that has nothing real to say** rather than
filling it. A good issue here is a few sentences, not an essay.

## Steps

1. Read `.github/ISSUE_TEMPLATE/issue_template.md` to mirror its sections.
2. Decide **bug vs task** from the user's note and context. Ask only if genuinely
   unclear.
3. Write a **Title**: short and specific, no Conventional-Commit type prefix (an
   issue is not a commit). E.g. `Integrate Claude Code (CLAUDE.md + issue/PR skills)`.
4. Draft the body, in **English**, using these sections as a base:
   - **Description** — 1–2 sentences: what and why.
   - **Expected behavior** — what "done" looks like.
   - **Steps to reproduce** — bugs only; omit entirely for tasks.
   - **Checklist** — keep the template's items; drop any that don't apply.

   Add **Acceptance criteria** or **Scope / non-goals** only when it carries
   information the reader couldn't already infer. Otherwise leave it out.
5. Ask clarifying questions **only** if intent or a key detail is genuinely missing —
   don't interrogate when context already answers it.
6. Overwrite `issue-description.md` with the result, then show it to the user.

## Output layout

Put the title on its own labelled line at the top, separated from the body by `---`,
so the user can copy each GitHub field independently:

```
**Title:** <the issue title>

---

### Description
...
```

Do **not** create the issue on GitHub — the user opens it themselves by copy-pasting.
