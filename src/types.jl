abstract type SLHAData end
abstract type SLHABlock end
abstract type SLHANumericalBlock <: SLHABlock end
abstract type SLHAArrayBlock <: SLHANumericalBlock end
abstract type SLHAScalarBlock <: SLHANumericalBlock end

const IndVals = Vector{Tuple{Vector{Int64}, String}}

struct SLHASimpleBlock{label, dim} <: SLHAArrayBlock
    scale::Nullable{Float64}
    block::Array{Float64,dim}

    SLHASimpleBlock{label, dim}(q::Nullable{Float64}, block::Array) where
        {label, dim} = new(q,block)

    SLHASimpleBlock{label, dim}(q::Float64, block::Array) where
        {label, dim} = new(Nullable{Float64}(q), block)

    function SLHASimpleBlock{label, dim}(
            scale::Nullable{Float64},
            indvals::Vector{Tuple{Vector{Int64}, String}}
        ) where {label, dim}
        lengths = zeros(Int64, dim)
        for iv in indvals
            for k = 1:length(iv[1])
                if iv[1][k] > lengths[k]
                    lengths[k] = iv[1][k]
                end
            end
        end
        block = zeros(Float64, lengths...)
        for iv in indvals
            ind = iv[1]
            val = parse(Float64, iv[2])
            block[ind...] = val
        end
        new(scale, block)
    end
end
SLHASimpleBlock(l::Symbol, q::Nullable{Float64}, x::Array) =
        SLHASimpleBlock{l, ndims(x)}(q, x)

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
