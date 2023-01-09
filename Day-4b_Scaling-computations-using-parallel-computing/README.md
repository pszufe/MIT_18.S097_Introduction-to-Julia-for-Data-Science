This module discusses parallel computing options for Julia.

Before launching Jupyter Notebook you will need to set the number of threads.

This can be done in Julia REPL by setting a specific variable:

```
ENV["JULIA_NUM_THREADS"]=8
using IJulia
notebook(dir=".")
```

Note that the variable needs to be set before launching the notebook (it is not possible to update the thread number in a running Julia process)