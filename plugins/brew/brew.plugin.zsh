alias bc='brew cleanup'
alias bci='brew cask info'
alias bcin='brew cask install'
alias bcrin='brew cask reinstall'
alias bcl='brew cask list'
alias bco='brew cask outdated'
alias bcup='brew cask upgrade'
alias bl='brew list'
alias bo='brew outdated'
alias bu='brew update'
alias bup='brew upgrade'
alias brewp='brew pin'
alias brews='bl -1'
alias brewsp='bl --pinned'
alias bubo='bu && bo'
alias bubc='bup && bc'
alias bubu='bubo && bubc'
alias bcubo='bu && bco'
alias bubobco='bubo && bco'
alias bcubc='bcrin $(bco) && bc'