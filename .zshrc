# Sets the default locale to US English with UTF-8 encoding
export LANG="en_US.UTF-8"
# Sets compiler flags for ARM64 architecture (Apple Silicon)
export ARCHFLAGS="-arch arm64"
# Sets Neovim as the default terminal editor
export EDITOR='nvim'
# Sets Neovim as the editor for Kubernetes CLI tools
export KUBE_EDITOR='nvim'
# Sets Neovim as the default full-screen editor
export VISUAL='nvim'
# Sets the installation path for Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
# Sets the installation path for NVM (Node.js)
export NVM_DIR="$HOME/.nvm"
# Sets the root path for Pyenv (Python)
export PYENV_ROOT="$HOME/.pyenv"
# Sets the root path for Rbenv (Ruby)
export RBENV_ROOT="$HOME/.rbenv"
# Sets the root path for .NET
export DOTNET_ROOT="$HOME/.dotnet"
# Sets the root path for Cargo
export CARGO_HOME="$HOME/.cargo"
# Sets the root path for Rustup
export RUSTUP_HOME="$HOME/.rustup"
# Sets the root path for Colima
export COLIMA_HOME="$HOME/.colima"
# Sets the root path for SDKMAN! (Java, Scala, etc.)
export SDKMAN_DIR="$HOME/.sdkman"
# Sets the root path for Go
export GOPATH="$HOME/.go"
# Sets the config file path for kubectl
export KUBECONFIG=$HOME/.kube/config
# Sets the default file search command for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
# Sets the Docker host socket to Colima
export DOCKER_HOST="unix://${COLIMA_HOME}/default/docker.sock"
# Sets the host address for Testcontainers to Colima's IP
export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
# Sets the variable to hide Homebrew’s hints.
export HOMEBREW_NO_ENV_HINTS=1
# Sets the root path for K9s
export K9S_CONFIG_DIR="$HOME/.k9s"

# Load Rust environment via rustup
. "$HOME/.cargo/env"

# Prepends user scripts directory to PATH
export PATH="$HOME/bin:$PATH"
# Prepends Homebrew binaries (Apple Silicon) to PATH
export PATH="/opt/homebrew/bin:$PATH"
# Prepends Pyenv shims to PATH
export PATH="$PYENV_ROOT/bin:$PATH"
# Prepends Rbenv binaries to PATH
export PATH="$RBENV_ROOT/bin:$PATH"
# Prepends Cargo binaries (Rust) to PATH
export PATH="$HOME/.cargo/bin:$PATH"
# Prepends .NET global tools to PATH
export PATH="$HOME/.dotnet/tools:$PATH"
# Prepends SQLcl CLI binaries to PATH
export PATH="$(brew --prefix)/Caskroom/sqlcl/$(ls -t "$(brew --prefix)/Caskroom/sqlcl" | head -1)/sqlcl/bin:$PATH"
# Prepends LuaJIT binaries to PATH
export PATH="/opt/homebrew/opt/luajit/bin:$PATH"

# Fully disables all history saving
unsetopt INC_APPEND_HISTORY
unsetopt APPEND_HISTORY
setopt HIST_NO_STORE
export HISTFILE=/dev/null

# Creates hushlogin to silence login messages
touch ~/.hushlogin

# Runs custom fastfetch script only in WezTerm
if [[ $- == *i* ]] && [[ "$TERM_PROGRAM" == "WezTerm" ]] && [[ -z "$NVIM" ]]; then
  ~/bin/fastfetch-dual
fi

# Load function for hooks
autoload -Uz add-zsh-hook

# Blank line before the prompt
_blank_line_precmd() { print -r -- '' }
add-zsh-hook precmd _blank_line_precmd

# Initializes Starship
eval "$(starship init zsh)"

# Sets host-specific compdump cache path
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

# Sets appearance options for fzf-tab
zstyle ':fzf-tab:*' fzf-flags \
  --no-separator \
  --padding=1,1 \
  --color fg:#CDD6F4,bg:#1E1E2E,hl:#F38BA8,fg+:#FFFFFF,pointer:#CBA6F7,info:#1E1E2E

# Sets Oh My Zsh plugin list
plugins=(
  fzf-tab
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  )

# Add completion directories to fpath
fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+=~/.zfunc
fpath+=~/.rbenv/completions

# Loads Oh My Zsh framework
source $ZSH/oh-my-zsh.sh

# Loads NVM
. "$NVM_DIR/nvm.sh"
# Loads NVM completions
. "$NVM_DIR/bash_completion"
# Prepends current nvm Node.js version's bin directory to PATH
export PATH="$NVM_DIR/versions/node/$(nvm current)/bin:$PATH"

# Hook to change Node.js version based on .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Enables GitHub CLI completions
eval "$(gh completion -s zsh)"

# Enables Docker CLI completions
source <(docker completion zsh)

# Enables kubectl completions
source <(kubectl completion zsh)

# Enables .NET completions
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")
  if [ -z "$completions" ]; then
    _arguments '*::arguments: _normal'
    return
  fi
  _values = "${(ps:\n:)completions}"
}
compdef _dotnet_zsh_complete dotnet

# Sets Docker context to Colima
docker context use colima &>/dev/null
# Initializes LuaRocks
eval "$(luarocks path --bin)"
# Initializes pyenv
eval "$(pyenv init - zsh)"
# Initializes pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
# Initializes rbenv
eval "$(rbenv init - zsh)"
# Initializes Atuin shell history manager
eval "$(atuin init zsh)"
# Initializes batman (colorized man pages)
eval "$(batman --export-env)"
# Initializes zoxide (directory jumper)
eval "$(zoxide init zsh)"
# Enables thefuck for correcting failed commands
eval $(thefuck --alias)
# Loads SDKMAN
source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Disables default fzf keybindings and loads fzf bindings and completions
FZF_CTRL_T_COMMAND= \
FZF_ALT_C_COMMAND= \
FZF_CTRL_R_OPTS= \
  source <(fzf --zsh)

# Re-enable blinking cursor before each prompt
precmd() { print -n '\e[?12h'; }

# Defines yazi wrapper to auto-cd into selected directory
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Defines lazygit wrapper to cd into selected repo directory
lg() {
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
    lazygit "$@"
    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
        cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
        rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# Defines custom file search logic for fzf
_fzf_compgen_path() {
  fd -t f --hidden --no-ignore --follow --color=always  . "$1"
}

# Defines custom dir search logic for fzf
_fzf_compgen_dir() {
  fd -t d --hidden --no-ignore --follow --color=always . "$1"
}

# Defines a flexible fzf-based completion UI for various commands
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd|rmdir|pushd)
      fzf --ansi --style full \
          --input-label ' Input ' \
          --preview 'eza -T -L=2 -F --colour=always --colour-scale=all --color-scale-mode=fixed --icons=always --all {}' \
          --bind 'result:transform-list-label:
            if [[ -z $FZF_QUERY ]]; then
              echo " $FZF_MATCH_COUNT items "
            else
              echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
            fi
          ' \
          --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {}' \
          --color 'preview-border:#F38BA8,preview-label:#F5E0DC' \
          --color 'list-border:#B4BEFE,list-label:#CDD6F4' \
          --color 'input-border:#CBA6F7,input-label:#CBA6F7' \
          --color 'header-border:#F5E0DC,header-label:#F38BA8' \
          "$@"
      ;;
    kill)
      fzf --ansi --style full \
          --input-label ' Input ' \
          --bind 'result:transform-list-label:
            if [[ -z $FZF_QUERY ]]; then
              echo " $FZF_MATCH_COUNT items "
            else
              echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
            fi
          ' \
          --color 'list-border:#B4BEFE,list-label:#CDD6F4' \
          --color 'input-border:#CBA6F7,input-label:#CBA6F7' \
          --color 'header-border:#F5E0DC,header-label:#F38BA8' \
          "$@"
      ;;
    ssh|telnet)
      fzf --ansi --style full \
          --input-label ' Host ' \
          --preview 'dig +nocmd {} ANY +noall +answer || echo "No DNS info found for {}"' \
          --bind 'result:transform-list-label:
            if [[ -z $FZF_QUERY ]]; then
              echo " $FZF_MATCH_COUNT hosts "
            else
              echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
            fi
          ' \
          --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Resolving [%s] " {}' \
          --color 'preview-border:#F38BA8,preview-label:#F5E0DC' \
          --color 'list-border:#B4BEFE,list-label:#CDD6F4' \
          --color 'input-border:#CBA6F7,input-label:#CBA6F7' \
          --color 'header-border:#F5E0DC,header-label:#F38BA8' \
          "$@"
      ;;
    export|unset)
      fzf --ansi --style full \
          --input-label ' Input ' \
          --preview 'printenv {}' \
          --bind 'result:transform-list-label:
            if [[ -z $FZF_QUERY ]]; then
              echo " $FZF_MATCH_COUNT items "
            else
              echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
            fi
          ' \
          --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Variable [%s] " {}' \
          --color 'preview-border:#F38BA8,preview-label:#F5E0DC' \
          --color 'list-border:#B4BEFE,list-label:#CDD6F4' \
          --color 'input-border:#CBA6F7,input-label:#CBA6F7' \
          --color 'header-border:#F5E0DC,header-label:#F38BA8' \
          "$@"
      ;;
    unalias)
      fzf --ansi --style full \
          --input-label ' Input ' \
          --bind 'result:transform-list-label:
            if [[ -z $FZF_QUERY ]]; then
              echo " $FZF_MATCH_COUNT items "
            else
              echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
            fi
          ' \
          --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Alias [%s] " {}' \
          --color 'list-border:#B4BEFE,list-label:#CDD6F4' \
          --color 'input-border:#CBA6F7,input-label:#CBA6F7' \
          --color 'header-border:#F5E0DC,header-label:#F38BA8' \
          "$@"
      ;;
    *)
      fzf --ansi --style full \
          --input-label ' Input ' \
          --preview 'fzf-preview.sh {}' \
          --bind 'result:transform-list-label:
            if [[ -z $FZF_QUERY ]]; then
              echo " $FZF_MATCH_COUNT items "
            else
              echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
            fi
          ' \
          --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {}' \
          --color 'preview-border:#F38BA8,preview-label:#F5E0DC' \
          --color 'list-border:#B4BEFE,list-label:#CDD6F4' \
          --color 'input-border:#CBA6F7,input-label:#CBA6F7' \
          --color 'header-border:#F5E0DC,header-label:#F38BA8' \
          "$@"
      ;;
  esac
}

# Defines an fzf-powered file picker with previews and smart open actions
fzff() {
  fd -t f --hidden --no-ignore --follow --color=always | \
  command fzf --ansi --style full \
    --border --padding 1,2 \
    --border-label ' FZF ' --input-label ' Input ' --header-label ' File Type ' \
    --preview 'if [[ -d {} ]]; then
        eza -T -L=2 -F --colour=always --colour-scale=all --color-scale-mode=fixed --icons=always --all {};
      else
        fzf-preview.sh {};
      fi' \
    --bind 'result:transform-list-label:
        if [[ -z $FZF_QUERY ]]; then
          echo " $FZF_MATCH_COUNT items "
        else
          echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
        fi
    ' \
    --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {}' \
    --bind 'focus:+transform-header:file --brief {} || echo "No file selected"' \
    --bind 'ctrl-d:reload(fd -t d --hidden --no-ignore --follow --color=always)' \
    --bind 'ctrl-f:reload(fd -t f --hidden --no-ignore --follow --color=always)' \
    --bind 'enter:become(zsh -c "case {} in \
        *.pdf|*.jpg|*.jpeg|*.png|*.gif|*.bmp|*.heic|*.tiff|*.tif|*.mp3|*.aac|*.m4a|*.mov|*.mp4|*.m4v|*.caf|*.aiff|*.zip|*.dmg|*.img|*.iso|*.webloc|*.app) \
          open {} ;; \
        *) \
          nvim {} ;; \
      esac")' \
    --color 'border:#1E1E2E,label:#CDD6F4' \
    --color 'preview-border:#F38BA8,preview-label:#F5E0DC' \
    --color 'list-border:#B4BEFE,list-label:#CDD6F4' \
    --color 'input-border:#CBA6F7,input-label:#CBA6F7' \
    --color 'header-border:#F5E0DC,header-label:#F38BA8'
}

# Defines an fzf + ripgrep integration for searching and previewing text matches
fzfr() {
  fzf --ansi --disabled --style full \
    --delimiter : \
    --border --padding 1,2 \
    --border-label ' RIPGREP ' --input-label ' Input ' --header-label ' File Type ' \
    --preview 'bat --style=numbers --color=always {1} --highlight-line {2}' \
     --preview-window '+{2}/3' \
    --bind 'result:transform-list-label:
        if [[ -z $FZF_QUERY ]]; then
          echo " $FZF_MATCH_COUNT items "
        else
          echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
        fi
    ' \
    --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {1}' \
    --bind 'focus:+transform-header:file --brief {1} || echo "No file selected"' \
    --bind 'start:reload:rg --column --line-number --no-heading --color=always --smart-case ""' \
    --bind 'change:reload:rg --column --line-number --no-heading --color=always --smart-case {q} || true' \
    --bind 'enter:become(nvim {1} +{2})' \
    --color 'border:#1E1E2E,label:#CDD6F4' \
    --color 'preview-border:#F38BA8,preview-label:#F5E0DC' \
    --color 'list-border:#B4BEFE,list-label:#CDD6F4' \
    --color 'input-border:#CBA6F7,input-label:#CBA6F7' \
    --color 'header-border:#F5E0DC,header-label:#F38BA8'
}

# Customizes fzf UI used by zoxide
export _ZO_FZF_OPTS="\
--ansi --style=full \
--input-label=' Input ' \
--preview='eza -T -L=2 -F --colour=always --colour-scale=all --color-scale-mode=fixed --icons=always --all \"\$(echo {} | awk '\''{print \$NF}'\'')\"' \
--bind='result:transform-list-label:if [[ -z \$FZF_QUERY ]]; then echo \" \$FZF_MATCH_COUNT items \"; else echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"; fi' \
--bind='focus:transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" \"\$(echo {} | awk '\''{print \$NF}'\'')\"' \
--color='preview-border:#F38BA8,preview-label:#F5E0DC' \
--color='list-border:#B4BEFE,list-label:#CDD6F4' \
--color='input-border:#CBA6F7,input-label:#CBA6F7' \
--color='header-border:#F5E0DC,header-label:#F38BA8'"

# Aliases
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias eza='eza -T -L=10 -F --colour=always --colour-scale=all --color-scale-mode=fixed --icons=always --all -l --no-permissions --no-user --no-time --no-filesize'
alias batgrep='batgrep --smart-case --context=4 --color --paging=never --no-ignore --hidden --fixed-strings'
alias fd='fd --hidden --no-ignore --follow --color=always --list-details'
alias dust='dust -C -r --skip-total'
alias gping='gping -c blue --clear'
alias duf='duf --all --sort usage'
alias pip='python -m pip'
alias viddy='viddy -n 5'
alias yazi='y'
alias df='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
