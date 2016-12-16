
abstract SLHA
abstract SLHABlock

type SLHASimpleBlock{Rank} <: SLHABlock
  scale::Float64
  block::Array{Float64,Rank}
end

type SLHAOptionsBlock <: SLHABlock
  block::Dict{Int64, String}
end

type SLHASparseBlock <: SLHABlock
  block::Sparse
