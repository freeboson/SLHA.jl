
strip_comments = r"\s+(?:#\N*)?$"m
block_match = r"
    \bBlock\s+                      # Start with Block token
    ([A-Z]+)                        # Block name in capture 1
    (?:                             # Possibly a scale is given
        \s+ Q= \s*                  # There *should* be ws after Q=
        (                           # capture the number
            [+-]?                   # Might have leading sign
            \d*
            (?:\.\d*)?              # Might have decimal places
            (?:E[+-]?\d+)?          # Might have exponent, with or w/o sign
        )                           # Scale in capture 2 (might be nothing)
    )?
    \N* \n                          # Ignore rest of line
    (.*?)                           # Lazy capture data (3) ...
    (?=Block|Decay|\Z)              # until you hit another block, decay, or EOF
"isx

function get_indices_values(block_data::AbstractString)
    map(map(split,split(strip(block_data), "\n"))) do nums
       if length(nums) > 1
         inds = map(n -> parse(Int64, n), nums[1:end-1])
       else
         inds = Vector{Int64}()
       end
       (inds, nums[end])
   end
end

function readslha(slha::AbstractString)
    clean = replace(slha, strip_comments, "")
    blocks = eachmatch(block_match, clean)
    map(blocks) do block
        block_type = slha_block_type(uppercase(block.capture[1]))
        scale = Nullable{Float64}(block.capture[2])
        indvals = get_indices_values(block.capture[3])

        block_type(scale, indvals)
    end
end

function slha_block_type(name::AbstractString)
    if name == "SPINFO"
        return SLHASpInfoBlock
    elseif name == "MODSEL"
        return SLHAModSelBlock
    elseif name == "SMINPUTS"
        return SLHASMInputsBlock
    elseif name == "MINPAR"
        return SLHAMinParBlock
    elseif name == "EXTPAR"
        return SLHAExtParBlock
    elseif name == "MASS"
        return SLHAMassBlock
    elseif name == "MSOFT"
        return SLHAMSoftBlock
    elseif name == "NMIX"
        return SLHANMixBlock
    elseif name == "UMIX"
        return SLHAUMixBlock
    elseif name == "VMIX"
        return SLHAVMixBlock
    elseif name == "STOPMIX"
        return SLHAStopMixBlock
    elseif name == "SBOTMIX"
        return SLHASbotMixBlock
    elseif name == "STAUMIX"
        return SLHAStauMixBlock
    elseif name == "ALPHA"
        return SLHAAlphaBlock
    elseif name == "HMIX"
        return SLHAHMixBlock
    elseif name == "GAUGE"
        return SLHAGaugeBlock
    elseif name == "AU"
        return SLHAAUBlock
    elseif name == "AD"
        return SLHAADBlock
    elseif name == "AE"
        return SLHAAEBlock
    elseif name == "YU"
        return SLHAYUBlock
    elseif name == "YD"
        return SLHAYDBlock
    elseif name == "YE"
        return SLHAYEBlock
    elseif name == "NMSSMRUN"
        return SLHANMSSMRunBlock
    else
        return SLHAArbitraryBlock{symbol(name)}
end


