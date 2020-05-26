# needing to manually dlopen this is probably a bug in Healpix or gfortan, not
# sure which...

using Libdl
Libdl.dlopen("libgomp",Libdl.RTLD_GLOBAL)

npix2nside(n) = Int(sqrt(n/12))

@generated function map2alm(maps::Array{T,N}; Nside=npix2nside(size(maps,1)), ℓmax=2Nside, mmax=ℓmax, zbounds=[-1,1]) where {N,T<:Union{Float32,Float64}}
    (spin, Tspin) = if (N==1)
        (), () 
    elseif (N==2)
        (2,), (Ref{Int32},)
    else
        error("maps should be Npix-×-1 or Npix-×-2")
    end
    fn_name = "__alm_tools_MOD_map2alm_$(N==1 ? "sc" : "spin")_$((T==Float32) ? "s" : "d")"
    quote
        aℓms = Array{Complex{T}}(undef, ($N,ℓmax+1,mmax+1))
        aℓms .= NaN
        ccall(
            ($fn_name, "libhealpix"), Nothing,
            (Ref{Int32}, Ref{Int32}, Ref{Int32}, $(Tspin...), Ref{T}, Ref{Complex{T}}, Ref{Float64}, Ref{Nothing}),
            Nside, ℓmax, mmax, $(spin...), maps, aℓms, Float64.(zbounds), C_NULL
        )
        aℓms
    end
end

@generated function alm2map!(maps::Array{T,N}, aℓms::Array{Complex{T},3}; Nside=npix2nside(size(maps,1)), ℓmax=(size(aℓms,2)-1), mmax=(size(aℓms,3)-1), zbounds=[-1,1]) where {N,T<:Union{Float32,Float64}}
    (spin, Tspin) = if (N==1)
        (), () 
    elseif (N==2)
        (2,), (Ref{Int32},)
    else
        error("maps should be Npix-×-1 or Npix-×-2")
    end
    fn_name = "__alm_tools_MOD_alm2map_$(N==1 ? "sc_wrapper" : "spin")_$((T==Float32) ? "s" : "d")"
    quote
        ccall(
           ($fn_name, "libhealpix"), Nothing,
           (Ref{Int32}, Ref{Int32}, Ref{Int32}, $(Tspin...), Ref{Complex{T}}, Ref{T}, Ref{Float64}, Ref{Nothing}),
           Nside, ℓmax, mmax, $(spin...), aℓms, maps, Float64.(zbounds), C_NULL
        )
        maps
    end
end
