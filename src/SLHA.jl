module SLHA
    import Base.show
    using Base.Cartesian

    export SLHASimpleBlock, SLHADescBlock, SLHAParameterBlock, SLHASparseBlock

    abstract SLHABlock

    type SLHASimpleBlock{label, dim} <: SLHABlock
        scale::Float64
        block::Array{Float64,dim}
    end
    SLHASimpleBlock(l::Symbol, q, x::Array) = SLHASimpleBlock{l, ndims(x)}(q, x)

    type SLHADescBlock{label} <: SLHABlock
        block::Dict{Int64, String}
    end

    type SLHAParameterBlock{label} <: SLHABlock
        scale::Float64
        block::SparseVector{Float64,Int64}
    end

    type SLHASparseBlock{label} <: SLHABlock
        scale::Float64
        block::SparseMatrixCSC{Float64, Int64}
    end

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 1})
        @printf(io, "BLOCK %s Q=%+0.10e\n", label, block.scale)
        for n = 1:length(block.block)
            @printf(io, "%6d    % 0.10e \n",n, block.block[n])
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 2})
        @printf(io, "BLOCK %s Q=%+0.10e\n", label, block.scale)
        for c = 1:size(block.block,2)
            for r = 1:size(block.block, 1)
                @printf(io, "%3d %2d    % 0.10e \n",r, c, block.block[r,c])
            end
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 3})
        @printf(io, "BLOCK %s Q=%+0.10e\n", label, block.scale)
        A = block.block
        @nloops 3 ind A begin
            @printf(io, "%3d %2d %2d % 0.10e \n", (@ntuple 3 ind)...,
                    (@nref 3 A ind))
        end
    end

# Why not... display arbitrary dim blocks. Only used for dim > 3
    @generated function show{label, dim}(io::IO, m::MIME"text/plain",
                                   block::SLHASimpleBlock{label, dim})
        quote
            A = block.block
            @printf(io, "BLOCK %s Q=%+0.10e\n",label, block.scale)
            @nloops $dim ind A begin
                @printf(io, "%s % 0.10e \n",
                        string(map((n) -> @sprintf(" %2d", n),
                                   (@ntuple $dim ind))...),
                        (@nref $dim A ind))
            end
        end
    end

end

