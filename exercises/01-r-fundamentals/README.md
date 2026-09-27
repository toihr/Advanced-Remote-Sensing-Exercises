# 01 – R fundamentals

Warm-up exercise: variables, functions, vectors, matrices, data frames, control flow – and a first
real-data task with long-term climate normals of the German Weather Service (DWD).

**What the script does** ([`r_fundamentals.R`](r_fundamentals.R))
- Blocks I–V: R basics (functions, indexing, `data.frame` manipulation, loops).
- Block VI: reads the DWD mean temperatures 1961–1990 and 1981–2010, joins them with the station list
  (downloaded directly from the DWD open-data server), computes the per-station warming and tests
  it with a two-sided t-test.

**Data:** `data/Temperatur_*.txt` (included in the repository).
