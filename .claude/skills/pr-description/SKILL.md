---
name: pr-description
description: Draft a concise GitHub pull request description for the owe_me repo into pr-description.md. Use when the user wants to create or write a PR, draft a PR description, or prepare a pull request to open on GitHub.
---

# PR Description

Draft a pull request description and write it to `pr-description.md` at the repo root.
The file is a reusable scratch file — **overwrite it fully** each run.

## Guiding principle: brief and specific

Short, high-signal text a reader grasps in seconds. No filler, no restating every
commit. **Omit empty sections** rather than padding them. Summarize the change, not
the commit log.

## Steps

1. Gather context from git:
   - `git diff main...HEAD` — the actual change.
   - `git log main..HEAD --pretty=format:'%s'` — commit subjects on the branch.
   - `git rev-parse --abbrev-ref HEAD` — branch name; **infer the issue number** from
     the `type/<issue>-desc` pattern (e.g. `feat/14-error-handling` → `#14`).
2. Read `.github/PULL_REQUEST_TEMPLATE/pull_request_template.md` to mirror its sections.
3. Write a **Title** following the commit convention: `type(#issue): subject`
   (lowercase imperative, issue number from the branch). It should read like the
   change's main commit. E.g. `feat(#14): map sqflite exceptions to domain failures`.
4. Draft the body, in **English**:
   - **Description** — what the PR does and why, briefly.
   - **Related Issues** — `Closes #<n>` using the issue number inferred from the
     branch.

   Add a short **Testing** note only if there is something non-obvious to verify.
5. Ask **only** if the issue number or the change's intent is ambiguous.
6. Overwrite `pr-description.md` with the result, then show it to the user.

## Output layout

Put the title on its own labelled line at the top, separated from the body by `---`,
so the user can copy each GitHub field independently:

```
**Title:** <type(#issue): subject>

---

### Description
...
```

Do **not** create the PR on GitHub — the user opens it themselves.
