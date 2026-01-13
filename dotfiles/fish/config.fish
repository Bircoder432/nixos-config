if status is-interactive
    alias rm rmtrash
    alias cd z
    alias cat bat
    alias reswitch "sudo nixos-rebuild switch"

    zoxide init fish | source
end
