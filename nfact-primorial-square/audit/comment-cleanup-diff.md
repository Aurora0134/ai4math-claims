# Comment-layer cleanup record (2026-10-07)

The package copies of the Lean sources (and of the frozen statement
snapshot) had their comments and docstrings cleaned to English for
publication. **No code bytes were changed**: statements, proofs, imports, and
all non-comment tokens are byte-identical to the frozen development of
record.

## Method

For each file, the frozen/original copy was diffed against the package copy;
then both sides were stripped of Lean comments (block comments `/- ... -/`,
module docstrings `/-! ... -/`, docstrings `/-- ... -/`, line comments `--`)
and the stripped code regions were diffed again. Result: empty diff on both
`.lean` files (code regions byte-identical). For the snapshot
`nfact-primorial-square.statement.txt` the same strip-and-diff was applied to
its ```lean fence block (the statement texts): empty diff.

## sha256 correspondence (frozen/original → package copy)

- `final-nfact-primorial-square.lean`: `276cb2e698f6d201752eed3cb1104254d976f1a392ba3860a194eaa66986070a` → `4ef5e12d5da258fbf5bf036a548886e657cde0fc26eda8d985529849b3b7907f`
- `nfact-primorial-square.lean`: `638064201e96a3bdb42e75b00020c16e2fb27c2738c58fa3d4923cde2a451a8f` → `a89b75a91ecafea1b83fc7e01ae6a453760cde5c3cb0f8e1d3fee013be3bb5c7`
- `nfact-primorial-square.statement.txt`: `0b13d08d6d915c2ebb25a070461a9d2a7d0364b12b3627c1b1efba5cc9f8ea48` → `66188fac6d2adfa24e0db6fa733bb401f7ddbcc1d08feda7e617510b3f760952`

## What changed (comment layer only)

- Module header comments: provenance notes, internal path references, and
  generation annotations removed; replaced by a short English mathematical
  summary of the file's content.
- Theorem docstrings: Chinese text translated to English; mathematical
  meaning preserved.
- The final file's cleanup preserved every line number, so the note's
  line-range references (96–168 / 735–767 / 771–1094) hold for both the
  frozen development and the shipped copy.
- Kernel verification was re-run after cleanup (see `kernel-rerun.txt`).
