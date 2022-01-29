if (( ! $+commands[rbw] )); then
  return
fi

# TODO: 2021-12-28: remove this bit of code as it exists in oh-my-zsh.sh
# Add completions folder in $ZSH_CACHE_DIR
command mkdir -p "$ZSH_CACHE_DIR/completions"
(( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)


# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `rbw`. Otherwise, compinit will have already done that.
if [[ ! -f "$ZSH_CACHE_DIR/completions/_rbw" ]]; then
  typeset -g -A _comps
  autoload -Uz _rbw
  _comps[rbw]=_rbw
fi

rbw gen-completions zsh >| "$ZSH_CACHE_DIR/completions/_rbw" &|

# rbwpw function copies the password of a service to the clipboard
# and clears it after 20 seconds
function rbwpw {
  [[ $# -ne 1 ]] && echo "usage: rbwg <service>" && return 1
  local service=$1
  rbw unlock || (echo "rbw is locked" && return 1)
  local pw=$(rbw get $service 2>/dev/null)
  [[ -z $pw ]] && echo "$service not found" && return 1
  echo -n $pw | clipcopy
  echo "password for $service copied!"
  (sleep 20 && clipcopy </dev/null 2>/dev/null) &|
}

function _rbwpw {
  local -a services=("${(@f)$(rbw ls 2>/dev/null)}")
  [[ -n services ]] && compadd -a -- services
}

compdef _rbwpw rbwpw
