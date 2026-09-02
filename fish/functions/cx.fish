function cx --description "alias cx='claude --permission-mode bypassPermissions'" --wraps=claude
    printf '\033[2J\033[3J\033[H'
    claude --permission-mode bypassPermissions $argv
end
