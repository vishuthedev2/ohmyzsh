if ! command -v scw &> /dev/null; then
  echo "[oh-my-zsh] scw command not found, please install it from https://github.com/scaleway/scaleway-cli"
  return
fi

# Load scw autocompletion if autocompletion not already loaded
if ! command -v _scw &> /dev/null; then
  eval "$(scw autocomplete script shell=zsh)"
fi
