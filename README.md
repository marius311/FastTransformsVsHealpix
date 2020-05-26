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
│  128.0 │ 0.007874481 │ 0.000700065 │ 0.009851254 │  0.000870253 │
│  256.0 │ 0.018368028 │ 0.002683774 │ 0.019917609 │  0.003181975 │
│  512.0 │ 0.081958735 │ 0.010487756 │ 0.090262198 │   0.01275066 │
│ 1024.0 │ 0.366482924 │ 0.075066388 │ 0.707635708 │  0.094923816 │
│ 2048.0 │ 1.759555976 │  0.40535831 │ 4.334770403 │  0.499140478 │
└────────┴─────────────┴─────────────┴─────────────┴──────────────┘
```