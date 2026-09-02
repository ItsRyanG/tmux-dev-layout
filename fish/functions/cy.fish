function cy --description "alias cy='codex -s danger-full-access -a never'" --wraps=codex
    codex -s danger-full-access -a never $argv
end
