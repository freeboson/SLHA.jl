
abstract SLHA
abstract SLHABlock

type SLHASimpleBlock{Rank} <: SLHABlock
  block::Array{Float64,Rank}
