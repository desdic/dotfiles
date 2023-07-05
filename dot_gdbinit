set disassembly-flavor intel
set follow-fork-mode child
set history save on
set history filename ~/.gdb_history
set history size 32768
set history expansion on
set pagination off

define xall32
 i r eip esp ebp eax
 x/5i $eip
 x/32xw $esp
end
document xall32
 Stack and disas helper
end
define xall64
 i r rip rsp rbp rax
 x/5i $rip
 x/32xg $rsp
end
document xall64
 Stack and disas helper
end


define xenv
 x/20s *environ
end
document xenv
 Print the environment variables
from the stack
end

source /usr/share/peda/peda.py
