abstract SLHAData
abstract SLHABlock
abstract SLHANumericalBlock <: SLHABlock

type SLHASimpleBlock{label, dim} <: SLHANumericalBlock
    scale::Float64
    block::Array{Float64,dim}
end
SLHASimpleBlock(l::Symbol, q, x::Array) = SLHASimpleBlock{l, ndims(x)}(q, x)

type SLHADescBlock{label} <: SLHABlock
    block::Dict{Int64, String}
end

type SLHANoScaleParameterBlock{label} <: SLHABlock
    block::Dict{Int64, Float64}
end

type SLHAParameterBlock{label} <: SLHABlock
    scale::Float64
    block::Dict{Int64, Float64}
end

type SLHASparseBlock{label} <: SLHANumericalBlock
    scale::Float64
    block::SparseMatrixCSC{Float64, Int64}
end

# I really hate that this exists
type SLHASingletonBlock{label} <: SLHABlock
    entry::Float64
end

type SLHAArbitraryBlock{label} <: SLHABlock
    scale::Nullable{Float64}
    block::Dict{Array{Int64,1},String}
end

typealias SLHASpInfoBlock       SLHADescBlock{:SPINFO}
typealias SLHAModSelBlock       SLHADescBlock{:MODSEL}
typealias SLHASMInputsBlock     SLHANoScaleParameterBlock{:SMINPUTS}
typealias SLHAMinParBlock       SLHANoScaleParameterBlock{:MINPAR}
typealias SLHAExtParBlock       SLHANoScaleParameterBlock{:EXTPAR}
typealias SLHAMassBlock         SLHANoScaleParameterBlock{:MASS}
typealias SLHAMSoftBlock        SLHAParameterBlock{:MSOFT}
typealias SLHANMixBlock         SLHASimpleBlock{:NMIX, 2}
typealias SLHAUMixBlock         SLHASimpleBlock{:UMIX, 2}
typealias SLHAVMixBlock         SLHASimpleBlock{:VMIX, 2}
typealias SLHAStopMixBlock      SLHASimpleBlock{:STOPMIX, 2}
typealias SLHASbotMixBlock      SLHASimpleBlock{:SBOTMIX, 2}
typealias SLHAStauMixBlock      SLHASimpleBlock{:STAUMIX, 2}
typealias SLHAAlphaBlock        SLHASingletonBlock{:ALPHA}
typealias SLHAHMixBlock         SLHAParameterBlock{:HMIX}
typealias SLHAGaugeBlock        SLHAParameterBlock{:GAUGE}
typealias SLHAAUBlock           SLHASparseBlock{:AU}
typealias SLHAADBlock           SLHASparseBlock{:AD}
typealias SLHAAEBlock           SLHASparseBlock{:AE}
typealias SLHAYUBlock           SLHASparseBlock{:YU}
typealias SLHAYDBlock           SLHASparseBlock{:YD}
typealias SLHAYEBlock           SLHASparseBlock{:YE}

