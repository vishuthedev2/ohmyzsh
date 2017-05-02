if [ "$(whoami)" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

PROMPT='%{$fg[green]%}%B[%*]%{$reset_color%} %{$fg_bold[cyan]%}%B%n%{${fg_bold[blue]}%}::%{$reset_color%}%{$fg[yellow]%}%B%m%{$reset_color%} %{$fg_no_bold[magenta]%}➜ %{$reset_color%} %{${fg[green]}%}%B%3~ $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
