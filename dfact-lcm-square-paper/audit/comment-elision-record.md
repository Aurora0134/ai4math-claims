# Export-clean copy of the Lean sources

The deposited `.lean` files are copies of the frozen statement and of the
final proof file in which every comment containing Chinese text, or
referring to the pre-publication workflow (task-directory paths, toolchain
narrative), has been blanked out.
The blanking preserves line numbering, keeps already-English comments, and
never touches code: for each file the source and the copy have the same
comment-free code view, byte for byte (checked by the generating script,
which is not part of the deposit and is available from the author).
The theorem statements and proof terms are therefore exactly the frozen
artefacts; the accompanying compile and axiom records in `audit/` were
produced from the sources in their original, unblanked form.

| deposited file | lines | comments blanked at | sha256 of source | sha256 of copy |
|---|---|---|---|---|
| `dfact-lcm-square.statement.lean` | 59 | 1,35,45,52 | `9baa672fa40e74626369e4803d66bedd9b808860975a832447f89a2021f0dca0` | `ba18d47e4a6e907d6bfa3587d8c5846ad6cd8394e7df544c80a92e2469f5bddf` |
| `final-dfact-lcm-square.lean` | 333 | 1,31,33,46,48,55,57,67,77,87,98,112,126,128,203,205,242,244,317,319 | `1107cad44affa0bc84bb4a285c0381d6e6a0afd15c08d935cbda0cee7a256d8e` | `91c008ad992121fd70618925ef669d3f25207b3093373fa713212afda633d6f8` |

Files: 2. Comment regions blanked: 24. Code-view equality: verified for every file.
