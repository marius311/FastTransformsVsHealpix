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
│  128.0 │ 0.015295451 │ 0.001539761 │ 0.012585886 │  0.001226488 │
│  256.0 │ 0.041718186 │ 0.006532568 │ 0.036491527 │  0.005481217 │
│  512.0 │ 0.196179165 │ 0.032642855 │ 0.171171874 │  0.027228133 │
│ 1024.0 │ 0.830667638 │ 0.268468898 │ 0.806321855 │  0.200633882 │
│ 2048.0 │ 8.413862029 │ 1.461851389 │ 4.627316565 │   1.23139583 │
└────────┴─────────────┴─────────────┴─────────────┴──────────────┘
```