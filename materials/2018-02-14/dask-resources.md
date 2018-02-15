# Resources on Dask: A parallel computing library for scientific computing

## Some links

[Dask documentation](https://dask.pydata.org/en/latest/#)

[Dask tutorial](https://github.com/dask/dask-tutorial)

[One of the most recent video's on Dask](https://www.youtube.com/watch?v=rZlshXJydgQ)

## Overview (from the documentation)

Dask use cases can be roughly divided in the following two categories:

1. Large NumPy/Pandas/Lists with dask.array, dask.dataframe, dask.bag to analyze large datasets with familiar techniques. This is similar to Databases, Spark, or big array libraries.
2. Custom task scheduling. You submit a graph of functions that depend on each other for custom workloads. This is similar to Luigi, Airflow, Celery, or Makefiles.
Most people today approach Dask assuming it is a framework like Spark, designed for the first use case around large collections of uniformly shaped data. However, many of the more productive and novel use cases fall into the second category, using Dask to parallelize custom workflows.

Dask compute environments can be divided into the following two categories:

1. Single machine parallelism with threads or processes: The Dask single-machine scheduler leverages the full CPU power of a laptop or a large workstation and changes the space limitation from “fits in memory” to “fits on disk”. This scheduler is simple to use and doesn’t have the computational or conceptual overhead of most “big data” systems.
2. Distributed cluster parallelism on multiple nodes: The Dask distributed scheduler coordinates the actions of multiple machines on a cluster. It scales anywhere from a single machine to a thousand machines, but not significantly beyond.

The single machine scheduler is useful to more individuals (more people have personal laptops than have access to clusters) and probably accounts for 80+% of the use of Dask today. The distributed machine scheduler is useful to larger organizations like universities, research labs, or private companies.