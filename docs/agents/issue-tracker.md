# Issue tracker: github

The engineering skills use `gh` (GitHub CLI) to read and write issues in this repo. Configure the host and the issue prefix.

## GitHub host
- **Default**: `https://github.com`
- **This project**: `https://github.com/eleloi/nvim-config`
- **Auth**: `gh auth login` (interactive). To verify: `gh auth status`.
- **Repo visibility**: if the repo is private, `gh` will use your authenticated user; ensure you have access.

## Conventions

1. **List issues by label**:
   ```bash
   gh issue list --label "ready-for-agent" --state open
   ```
2. **View an issue**:
   ```bash
   gh issue view <N> --comments
   ```
3. **Create an issue** (returns the issue number on stdout):
   ```bash
   gh issue create --title "..." --body "..." --label "needs-triage"
   ```
4. **Add a label** (use `--add-label`, NOT `--label`):
   ```bash
   gh issue edit <N> --add-label "ready-for-agent"
   ```
5. **Remove a label**:
   ```bash
   gh issue edit <N> --remove-label "needs-triage"
   ```
6. **Add a comment** (use `comment`, not `note`):
   ```bash
   gh issue comment <N> --body "..."
   ```
7. **Close**:
   ```bash
   gh issue close <N>
   ```

## `gh` quirks

1. **`--add-label` adds, not replaces.** Unlike `glab issue update --label` (which also adds, not replaces — they're consistent here), `gh issue edit --label` REPLACES the labels. To add without removing others, use `--add-label`. To remove a single label, use `--remove-label`.
2. **Labels must exist before being added.** Unlike `glab` (which auto-creates labels on first use), `gh` requires the label to be pre-created. If you get "label not found", create it with: `gh label create "needs-triage" --color "#cccccc" --description "..."`.
3. **Comments are `comment`, not `note`.** `gh issue note` doesn't exist; use `gh issue comment`.
4. **`gh issue create` does NOT return a parseable issue number on stdout by default.** It opens the browser for confirmation unless you pass `--editor` or pipe the body. The recommended pattern is to parse the issue URL from the output. For automation, the `--json number,title` flags can be combined with `--jq '.number'` for structured output (requires `gh` ≥2.0).
5. **No `/work_items/` URLs in GitHub.** Always `https://github.com/<org>/<repo>/issues/<N>`. The `gh` CLI always accepts the issue number for `gh issue ...` commands.

## Inferring repo

`gh` infers the repo from `git remote -v` when run inside a clone. To override (e.g. for cross-repo operations): `gh issue ... --repo <org>/<repo>`.

## When a skill says "publish to the issue tracker"

Create a GitHub issue with `gh issue create`. Apply the appropriate triage label from `docs/agents/triage-labels.md` using `--add-label`.

## When a skill says "fetch the relevant ticket"

Run `gh issue view <N> --comments`. If you need machine-readable output for parsing, add `--json number,title,body,labels,comments`.
