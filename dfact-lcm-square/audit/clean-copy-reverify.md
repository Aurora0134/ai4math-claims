# Clean-copy reverification record

Record of the re-verification of the export-clean copies that ship in `proofs/`
of this package. The clean copies are produced by a script that blanks comment
spans only (Chinese text and pre-publication workflow narrative), never touching
code, with a per-file assertion that the comment-free code view of the original
and of the copy are byte-for-byte equal (see `comment-elision-record.md`).

## Final proof (`final-dfact-lcm-square.lean`)

- Source sha256 `1107cad44affa0bc84bb4a285c0381d6e6a0afd15c08d935cbda0cee7a256d8e`
  (333 lines).
- Clean copy sha256 `91c008ad992121fd70618925ef669d3f25207b3093373fa713212afda633d6f8`.
- Strict compilation of the clean copy (strict mode: errors rejected, plus a
  textual scan for `sorry`/`admit`): **EXIT = 0**, single diagnostic =
  `:257:4: warning: push_neg has been deprecated` (style-level; the original
  file carries the same single warning).
- Axiom probe on the clean copy (probe file = clean copy plus four trailing
  `#print axioms` lines), EXIT = 0:

```
'DFactLcmSquare.isSquare_dfact_mul_lcmUpto_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
'DFactLcmSquare.dfact_lcm_witnesses' depends on axioms: [propext, Classical.choice, Quot.sound]
'DFactLcmSquare.dfact_lcm_square_solution_set' depends on axioms: [propext, Classical.choice, Quot.sound]
'DFactLcmSquare.exists_sq_dfact_lcm_iff' depends on axioms: [propext, Classical.choice, Quot.sound]
```

  Identical to the whitelist recorded for the original in `axioms.out`
  (12/12 theorems).

## Frozen statement (`dfact-lcm-square.statement.lean`)

- Source sha256 `9baa672fa40e74626369e4803d66bedd9b808860975a832447f89a2021f0dca0`
  (59 lines).
- Clean copy sha256 `ba18d47e4a6e907d6bfa3587d8c5846ad6cd8394e7df544c80a92e2469f5bddf`.
- Not re-compiled standalone: the file is a statement-only scaffold
  (`:= by sorry` placeholders) whose kernel well-definedness was established at
  freeze time on the original (`scripts/lean-verify --allow-sorry` EXIT = 0 on
  the three frozen statements). The clean copy differs from the original only in
  blanked comment regions; the code-view equality asserted by the generating
  script covers the statements themselves.
