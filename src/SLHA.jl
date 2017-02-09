module slha

import Base.show

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
  block::SparseVector{Float64,Int64}
end

type SLHASparseBlock <: SLHABlock
  scale::Float64
  block::SparseMatrixCSC{Float64, Int64}
end

function show(io::IO, m::MIME"text/plain", block::SLHABlock)
  println(io,"BLOCK LOLOLOL Q=$(block.scale)\n")
end

