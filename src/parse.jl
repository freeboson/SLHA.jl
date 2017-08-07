
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

function readslha(slha::AbstractString)
    clean = replace(slha, strip_comments, "")
    blocks = eachmatch(block_match, clean)
    for block in blocks
        name = uppercase(block.capture[1])
        scale_cap = block.capture[2]
        data = block.capture[3]
    end
end

