# Some references:
# https://gist.github.com/chrislongo/3351197

######################
# GDB options
######################
set prompt \033[31mgdb$ \033[0m

set input-radix 0x10
set output-radix 0x10

set history filename ~/.gdb_history
set history save on
set history size 10000

######################
# Breakpoint aliases
######################
define bpl
    info breakpoints
end
document bpl
List all breakpoints.
end

define bpt
    if $argc != 1
        help bpt
    else
        tbreak $arg0
    end
end
document bpt
Set a temporary breakpoint.
Will be deleted when hit!
Usage: bpt LOCATION
LOCATION may be a line number, function name, or "*" and an address.
end

######################
# Process information
######################
define frame
    info frame
    info args
    info locals
end
document frame
Print stack frame.
end

######################
# Process Control
######################
define stepo
    tbreak +1
    jump +1
end
document stepo
Steps over a single source code line
end
