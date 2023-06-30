if ! command -v scw &> /dev/null; then
  echo "[oh-my-zsh] scw command not found, please install it from https://github.com/scaleway/scaleway-cli"
  return
fi

function sgp() {
  echo "$SCW_PROFILE"
}

# SCW profile selection
function ssp() {
  if [[ -z "$1" ]]; then
    unset SCW_PROFILE
    echo SCW profile cleared.
    return
  fi

  local -a available_profiles
  available_profiles=($(scw_profiles))
  if [[ -z "${available_profiles[(r)$1]}" ]]; then
    echo "${fg[red]}Profile '$1' not found in '$(scw_config_path)'" >&2
    echo "Available profiles: ${(j:, :)available_profiles:-no profiles found}${reset_color}" >&2
    return 1
  fi

  export SCW_PROFILE=$1
}

function scw_profiles() {
  scw autocomplete complete zsh 3 -- scw --profile 2> /dev/null
}

function scw_config_path() {
  if [[ -v SCW_CONFIG_PATH ]]; then
    echo "$SCW_CONFIG_PATH"
    return
  fi

  for f in "$XDG_CONFIG_HOME/scw/config.yaml" \
           "$HOME/.config/scw/config.yaml"    \
           "$USERPROFILE/.config/scw/config.yaml"; do
    if [[ -f "$f" ]]; then
      echo "$f"
      return
    fi
  done
}

function _scw_profiles() {
  reply=($(scw_profiles))
}
compctl -K _scw_profiles ssp

# Load scw autocompletion if autocompletion not already loaded
if ! command -v _scw &> /dev/null; then
  eval "$(scw autocomplete script shell=zsh)"
fi
