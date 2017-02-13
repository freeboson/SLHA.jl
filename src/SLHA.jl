module SLHA
    import Base.show
    using Base.Cartesian

    export SLHASimpleBlock, SLHADescBlock, SLHAParameterBlock, SLHASparseBlock

    abstract SLHABlock

    type SLHASimpleBlock{label::Symbol, Rank} <: SLHABlock
        scale::Float64
        block::Array{Float64,Rank}
    end

    type SLHADescBlock{label::Symbol} <: SLHABlock
        block::Dict{Int64, String}
    end

    type SLHAParameterBlock{label::Symbol} <: SLHABlock
        scale::Float64
        block::SparseVector{Float64,Int64}
    end

    type SLHASparseBlock{label::Symbol} <: SLHABlock
        scale::Float64
        block::SparseMatrixCSC{Float64, Int64}
    end

    function show{label::Symbol}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 1})
        @printf(io, "BLOCK %s Q=%+0.10e\n", label, block.scale)
        for n = 1:length(block.block)
            @printf(io, "%6d    % 0.10e \n",n, block.block[n])
        end
    end

    function show{label::Symbol}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 2})
        @printf(io, "BLOCK %s Q=%+0.10e\n", label, block.scale)
        for c = 1:size(block.block,2)
            for r = 1:size(block.block, 1)
                @printf(io, "%3d %2d    % 0.10e \n",r, c, block.block[r,c])
            end
        end
    end

    function show{label::Symbol}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 3})
        @printf(io, "BLOCK %s Q=%+0.10e\n", label, block.scale)
        A = block.block
        @nloops 3 ind A begin
            @printf(io, "%3d %2d %2d % 0.10e \n", (@ntuple 3 ind)...,
                    (@nref 3 A ind))
        end
    end

# Why not... display arbitrary rank blocks. Only used for rank > 3
    @generated function show{label::Symbol, rank}(io::IO, m::MIME"text/plain",
                                   block::SLHASimpleBlock{label, rank})
        quote
            A = block.block
            @printf(io, "BLOCK %s Q=%+0.10e\n",label, block.scale)
            @nloops $rank ind A begin
                @printf(io, "%s % 0.10e \n", 
                        string(map((n) -> @sprintf(" %2d", n),
                                   (@ntuple $rank ind))...),
                        (@nref $rank A ind))
            end
        end
    end

    function show{label::Symbol}(io::IO, m::MIME"text/plain",
                                 block::SLHADescBlock{label::Symbol})
        println(io, "BLOCK $(label)")
        for (index, param) in block.block
            @printf("%6d    %s\n", index, param)
        end
    end

    function show{label::Symbol}(io::IO, m::MIME"text/plain",
                                 block::SLHAParameterBlock{label::Symbol})
        @printf(io, "BLOCK %s Q=%+0.10e\n", label, block.scale)

end

