module SLHA
    import Base.show
    using Base.Cartesian

    export  SLHASimpleBlock,
            SLHADescBlock,
            SLHAParameterBlock,
            SLHANoScaleParameterBlock,
            SLHASparseBlock,
            SLHASingletonBlock

    abstract SLHAData
    abstract SLHABlock

    type SLHASimpleBlock{label, dim} <: SLHABlock
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

    type SLHASparseBlock{label} <: SLHABlock
        scale::Float64
        block::SparseMatrixCSC{Float64, Int64}
    end

    # I really hate that this exists
    type SLHASingletonBlock{label} <: SLHABlock
        entry::Float64
    end

    typealias SpInfoBlock       SLHADescBlock{:SPINFO}
    typealias ModSelBlock       SLHADescBlock{:MODSEL}
    typealias SMInputsBlock     SLHANoScaleParameterBlock{:SMINPUTS}
    typealias MinParBlock       SLHANoScaleParameterBlock{:MINPAR}
    typealias ExtParBlock       SLHANoScaleParameterBlock{:EXTPAR}
    typealias MassBlock         SLHANoScaleParameterBlock{:MASS}
    typealias MSoftBlock        SLHAParameterBlock{:MSOFT}
    typealias NMixBlock         SLHASimpleBlock{:NMIX, 2}
    typealias UMixBlock         SLHASimpleBlock{:UMIX, 2}
    typealias StopMixBlock      SLHASimpleBlock{:STOPMIX, 2}
    typealias SbotMixBlock      SLHASimpleBlock{:SBOTMIX, 2}
    typealias StauMixBlock      SLHASimpleBlock{:STAUMIX, 2}
    typealias AlphaBlock        SLHASingletonBlock{:ALPHA}
    typealias HMixBlock         SLHAParameterBlock{:HMIX}
    typealias GaugeBlock        SLHAParameterBlock{:GAUGE}
    typealias AUBlock           SLHASparseBlock{:AU}
    typealias ADBlock           SLHASparseBlock{:AD}
    typealias AEBlock           SLHASparseBlock{:AE}
    typealias YUBlock           SLHASparseBlock{:YU}
    typealias YDBlock           SLHASparseBlock{:YD}
    typealias YEBlock           SLHASparseBlock{:YE}

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 1})
        @printf(io, "BLOCK %s Q= %+0.10E \n", label, block.scale)
        for n = 1:length(block.block)
            @printf(io, "%6d    % 0.10E \n",n, block.block[n])
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 2})
        @printf(io, "BLOCK %s Q= %+0.10E \n", label, block.scale)
        (nr,nc) = size(block.block)
        for c = 1:nc
            for r = 1:nr
                @printf(io, "%3d %2d    % 0.10E \n",r, c, block.block[r,c])
            end
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHASimpleBlock{label, 3})
        @printf(io, "BLOCK %s Q= %+0.10E \n", label, block.scale)
        A = block.block
        @nloops 3 ind A begin
            @printf(io, "%3d %2d %2d % 0.10E \n", (@ntuple 3 ind)...,
                    (@nref 3 A ind))
        end
    end

# Why not... display arbitrary dim blocks. Only used for dim > 3
    @generated function show{label, dim}(io::IO, m::MIME"text/plain",
                                   block::SLHASimpleBlock{label, dim})
        quote
            A = block.block
            @printf(io, "BLOCK %s Q=%+0.10E \n",label, block.scale)
            @nloops $dim ind A begin
                @printf(io, "%s % 0.10E \n",
                        string(map((n) -> @sprintf(" %2d", n),
                                   (@ntuple $dim ind))...),
                        (@nref $dim A ind))
            end
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHADescBlock{label})
        println(io, "BLOCK $(label)")
        for (index, param) in block.block
            @printf(io, "%6d    %s\n", index, param)
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHAParameterBlock{label})
        @printf(io, "BLOCK %s Q=%+0.10E \n",label, block.scale)
        for (index, param) in block.block
            @printf(io, "%6d    %s\n", index, param)
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                             block::SLHANoScaleParameterBlock{label})
        println(io, "BLOCK $(label)")
        for (index, param) in block.block
            @printf(io, "%6d    %s\n", index, param)
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                                 block::SLHASparseBlock{label})
        @printf(io, "BLOCK %s Q=%+0.10E \n",label, block.scale)
        rows = rowvals(block.block)
        vals = nonzeros(block.block)
        for col = 1:size(block.block, 2)
            for sparseind in nzrange(block.block, c)
                row = rows[sparseind]
                val = vals[sparseind]
                @printf(io, "%3d %2d    % 0.10E \n", row, col, val)
            end
        end
    end

    function show{label}(io::IO, m::MIME"text/plain",
                             block::SLHASingletonBlock{label})
        println(io, "BLOCK $(label)")
        @printf(io, "          % 0.10E \n", block.entry)
    end

end

