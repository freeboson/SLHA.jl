
abstract SLHA
abstract SLHABlock

type SLHASimpleBlock{Rank} <: SLHABlock
  scale::Float64
  block::Array{Float64,Rank}
end

type SLHADescBlock <: SLHABlock
  block::Dict{Int64, String}
end

type SLHAParameterBlock <: SLHABlock
  scale::Float64
  block::Dict{Int64, Float64}
end

type SLHASparseBlock <: SLHABlock
  scale::Float64
  block::SparseMatrixCSC{Float64, Int64}
end

