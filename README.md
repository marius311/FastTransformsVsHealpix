# FastTransforms.jl vs. Healpix

## Install

Install [Healpix](https://sourceforge.net/projects/healpix/), selecting "Fortran utilities" including building a shared (not static) library during the installer, and make sure `libhealpix.so` is on your `LD_LIBRARY_PATH`. 

## Usage

```
julia runbenchmarks.jl
```

## Results

### NERSC Cori with 64 threads

```
┌────────┬─────────────┬─────────────┬─────────────┬──────────────┐
│  Nside │  FT Forward │ Hpx Forward │ FT Backward │ Hpx Backward │
│        │   [seconds] │   [seconds] │   [seconds] │    [seconds] │
├────────┼─────────────┼─────────────┼─────────────┼──────────────┤
│  128.0 │ 0.012567752 │ 0.001430471 │ 0.014305213 │   0.00112119 │
│  256.0 │ 0.035638898 │ 0.006540887 │ 0.043488621 │  0.005426179 │
│  512.0 │ 0.174797603 │  0.03280995 │ 0.174139999 │  0.027216247 │
│ 1024.0 │ 0.844520785 │   0.2623817 │ 0.931947038 │  0.199792918 │
│ 2048.0 │ 4.621614987 │ 1.462439921 │ 8.222509584 │  1.227513756 │
└────────┴─────────────┴─────────────┴─────────────┴──────────────┘
```