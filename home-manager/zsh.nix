{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    autocd = true;
    dotDir = ".config/zsh";

    history = {
      path = "${config.xdg.configHome}/zsh/zsh_history";
      save = 10000;
      size = 10000;
      extended = true;
      ignoreAllDups = true;
      
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    historySubstringSearch.enable = true;

    shellAliases = {
      ls = "eza --icons --color=always --git";
      r = "ranger";
    };

    # Disabled beacause I'm using plugins for these
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # this is how you add plugins from oh-my-zsh
    # zinit snippet OMZP::git
    initExtraBeforeCompInit = ''

    '';

    # zinit cdreplay -q
    initExtra = ''
      source "${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh"
      source "${pkgs.zinit}/share/zinit/zinit.zsh"

      autoload -Uz _zinit

      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-autosuggestions
      zinit light zdharma-continuum/fast-syntax-highlighting
      zinit light Aloxaf/fzf-tab

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion*:' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza $realpath --color=always'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza $realpath --color=always'

      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
    '';

    # If you get a compinit error for missing _zinit run > zinit cclear
  };

  home.packages = with pkgs; [
    fzf
    zinit
    zoxide
    zsh-nix-shell
  ];
}
