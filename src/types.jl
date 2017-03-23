abstract type SLHAData end
abstract type SLHABlock end
abstract type SLHANumericalBlock <: SLHABlock end
abstract type SLHAArrayBlock <: SLHANumericalBlock end
abstract type SLHAScalarBlock <: SLHANumericalBlock end

struct SLHASimpleBlock{label, dim} <: SLHAArrayBlock
    scale::Float64
    block::Array{Float64,dim}
end
SLHASimpleBlock(l::Symbol, q, x::Array) = SLHASimpleBlock{l, ndims(x)}(q, x)

struct SLHADescBlock{label} <: SLHABlock
    block::Dict{Int64, String}
end

struct SLHANoScaleParameterBlock{label} <: SLHABlock
    block::Dict{Int64, Float64}
end

struct SLHAParameterBlock{label} <: SLHABlock
    scale::Float64
    block::Dict{Int64, Float64}
end

struct SLHASparseBlock{label} <: SLHAArrayBlock
    scale::Float64
    block::SparseMatrixCSC{Float64, Int64}
end

# I really hate that this exists
struct SLHASingletonBlock{label} <: SLHAScalarBlock
    entry::Float64
end

struct SLHAArbitraryBlock{label} <: SLHABlock
    scale::Nullable{Float64}
    block::Dict{Array{Int64,1},String}
end

const SLHASpInfoBlock           = SLHADescBlock{:SPINFO}
const SLHAModSelBlock           = SLHADescBlock{:MODSEL}
const SLHASMInputsBlock         = SLHANoScaleParameterBlock{:SMINPUTS}
const SLHAMinParBlock           = SLHANoScaleParameterBlock{:MINPAR}
const SLHAExtParBlock           = SLHANoScaleParameterBlock{:EXTPAR}
const SLHAMassBlock             = SLHANoScaleParameterBlock{:MASS}
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

