using Pkg
pkg"activate ."
using FastTransforms
using BenchmarkTools
using PrettyTables
include("healpix.jl")

FastTransforms.set_num_threads(Sys.CPU_THREADS)

T = Float64

timings = map([128,256,512,1024,2048]) do healpix_nside

    nθ = 4*healpix_nside
    nφ = 4*healpix_nside - 1

    # prep FastTransforms
    x2k  = plan_sph_analysis(T, nθ, nφ)
    k2x  = plan_sph_synthesis(T, nθ, nφ)
    lm2k = plan_sph2fourier(T, nθ)

    # run FastTransforms
    ft_forward = @belapsed $k2x * ($lm2k * $(sphrandn(T, nθ, nφ)))
    ft_backward = @belapsed $lm2k \ ($x2k * $(randn(T, nθ, nφ))) 

    # run Healpix
    hpx_forward = @belapsed map2alm($(rand(12*healpix_nside^2)), ℓmax=4*$healpix_nside)
    hpx_backward = @belapsed alm2map!(Array{T}(undef,12*$healpix_nside^2), $(randn(Complex{T}, 1, 4*healpix_nside+1, 4*healpix_nside+1)))

    [healpix_nside, ft_forward, hpx_forward, ft_backward, hpx_backward]
end

pretty_table(
    hcat(timings...)',
    ["Nside" "FT Forward" "Hpx Forward" "FT Backward" "Hpx Backward";
     ""      "[seconds]"  "[seconds]"   "[seconds]"   "[seconds]"]
)
