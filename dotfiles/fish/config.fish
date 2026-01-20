if status is-interactive
    alias c clear
    alias rm rmtrash
    alias cd z
    alias cdi zi
    alias cat bat
    alias reswitch "sudo nixos-rebuild switch"
    alias ls "eza --icons"
    alias ll "eza --long --git --icons"
    alias tree "eza --tree --icons"
    zoxide init fish | source
end
