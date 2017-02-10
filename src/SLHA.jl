module SLHA
    import Base.show
    using Base.Cartesian

    export SLHASimpleBlock, SLHADescBlock, SLHAParameterBlock, SLHASparseBlock

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

    function show(io::IO, m::MIME"text/plain", block::SLHASimpleBlock{1})
        @printf(io, "BLOCK SIMPLE Q=%+0.10e\n",block.scale)
        for n = 1:length(block.block)
            @printf(io, "%6d    % 0.10e \n",n, block.block[n])
        end
    end

    function show(io::IO, m::MIME"text/plain", block::SLHASimpleBlock{2})
        @printf(io, "BLOCK SIMPLE Q=%+0.10e\n",block.scale)
        for c = 1:size(block.block,2)
            for r = 1:size(block.block, 1)
                @printf(io, "%3d %2d    % 0.10e \n",r, c, block.block[r,c])
            end
        end
    end

    function show(io::IO, m::MIME"text/plain", block::SLHASimpleBlock{3})
        @printf(io, "BLOCK SIMPLE Q=%+0.10e\n",block.scale)
        A = block.block
        @nloops 3 ind A begin
            @printf(io, "%3d %2d %2d % 0.10e \n", (@ntuple 3 ind)...,
                    (@nref 3 A ind))
        end
    end

# Why not... display arbitrary rank blocks. Only used for rank > 3
    @generated function show{rank}(io::IO, m::MIME"text/plain",
                                   block::SLHASimpleBlock{rank})
        quote
            A = block.block
            @printf(io, "BLOCK WHOAAA Q=%+0.10e\n",block.scale)
            @nloops $rank ind A begin
                @printf(io, "%s % 0.10e \n", 
                        string(map((n) -> @sprintf(" %2d", n),
                                   (@ntuple $rank ind))...),
                        (@nref $rank A ind))
            end
        end
    end

end

