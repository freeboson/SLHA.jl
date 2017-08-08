abstract type SLHAData end
abstract type SLHABlock end
abstract type SLHANumericalBlock <: SLHABlock end
abstract type SLHAArrayBlock <: SLHANumericalBlock end
abstract type SLHAScalarBlock <: SLHANumericalBlock end

struct SLHASimpleBlock{label, dim} <: SLHAArrayBlock
    scale::Nullable{Float64}
    block::Array{Float64,dim}
end
SLHASimpleBlock(l::Symbol, q, x::Array) = SLHASimpleBlock{l, ndims(x)}(q, x)

struct SLHADescBlock{label} <: SLHABlock
    block::Dict{Int64, String}
end

struct SLHAParameterBlock{label} <: SLHABlock
    scale::Nullable{Float64}
    block::Dict{Int64, Float64}
end

struct SLHASparseBlock{label} <: SLHAArrayBlock
    scale::Nullable{Float64}
    block::SparseMatrixCSC{Float64, Int64}
end

# I really hate that this exists
struct SLHASingletonBlock{label} <: SLHAScalarBlock
    scale::Nullable{Float64}
    entry::Float64
end

struct SLHAArbitraryBlock{label} <: SLHABlock
    scale::Nullable{Float64}
    block::Dict{Array{Int64,1},String}
end

const SLHASpInfoBlock           = SLHADescBlock{:SPINFO}
const SLHAModSelBlock           = SLHADescBlock{:MODSEL}
const SLHASMInputsBlock         = SLHAParameterBlock{:SMINPUTS}
const SLHAMinParBlock           = SLHAParameterBlock{:MINPAR}
const SLHAExtParBlock           = SLHAParameterBlock{:EXTPAR}
const SLHAMassBlock             = SLHAParameterBlock{:MASS}
const SLHAMSoftBlock            = SLHAParameterBlock{:MSOFT}
const SLHANMixBlock             = SLHASimpleBlock{:NMIX, 2}
const SLHAUMixBlock             = SLHASimpleBlock{:UMIX, 2}
const SLHAVMixBlock             = SLHASimpleBlock{:VMIX, 2}
const SLHAStopMixBlock          = SLHASimpleBlock{:STOPMIX, 2}
const SLHASbotMixBlock          = SLHASimpleBlock{:SBOTMIX, 2}
const SLHAStauMixBlock          = SLHASimpleBlock{:STAUMIX, 2}
const SLHAAlphaBlock            = SLHASingletonBlock{:ALPHA}
const SLHAHMixBlock             = SLHAParameterBlock{:HMIX}
const SLHAGaugeBlock            = SLHAParameterBlock{:GAUGE}
const SLHAAUBlock               = SLHASparseBlock{:AU}
const SLHAADBlock               = SLHASparseBlock{:AD}
const SLHAAEBlock               = SLHASparseBlock{:AE}
const SLHAYUBlock               = SLHASparseBlock{:YU}
const SLHAYDBlock               = SLHASparseBlock{:YD}
const SLHAYEBlock               = SLHASparseBlock{:YE}

const SLHANMSSMRunBlock         = SLHAParameterBlock{:NMSSMRUN}

function SLHASimpleBlock{label, dim}(scale::Nullable{Float64},
                                     indvals::Tuple{Vector{Int64},
                                                    Vector{<:AbstractString}})
    lengths = zeros(Int64, dim)
    for iv in indvals
        for (i,m) in zip(iv[1], lengths)
            if i > m
                m = i
            end
        end
    end
    block = zeros(Float64, lengths...)
    for iv in indvals
        ind = iv[1]
        val = parse(Float64, iv[2])
        block[ind...] = val
    end
    SLHASimpleBlock{label, dim}(scale, block)
end


