
if [ -t 1 ]; then
  is_tty() {
    true
  }
else
  is_tty() {
    false
  }
fi

# Adapted from code and information by Anton Kochkov (@XVilka)
# Source: https://gist.github.com/XVilka/8346728
supports_truecolor() {
  case "$COLORTERM" in
  truecolor|24bit) return 0 ;;
  esac

  case "$TERM" in
  iterm           |\
  tmux-truecolor  |\
  linux-truecolor |\
  xterm-truecolor |\
  screen-truecolor) return 0 ;;
  esac

  return 1
}

if ! is_tty; then
  FORE_RAINBOW=""
  FORE_RED=""
  FORE_GREEN=""
  FORE_YELLOW=""
  FORE_BLUE=""
  FORE_BOLD=""
  FORE_RESET=""
else 
  if supports_truecolor; then
    FORE_RAINBOW="
      $(printf '\033[38;2;255;0;0m')
      $(printf '\033[38;2;255;97;0m')
      $(printf '\033[38;2;247;255;0m')
      $(printf '\033[38;2;0;255;30m')
      $(printf '\033[38;2;77;0;255m')
      $(printf '\033[38;2;168;0;255m')
      $(printf '\033[38;2;245;0;172m')
    "
  else
    FORE_RAINBOW="
      $(printf '\033[38;5;196m')
      $(printf '\033[38;5;202m')
      $(printf '\033[38;5;226m')
      $(printf '\033[38;5;082m')
      $(printf '\033[38;5;021m')
      $(printf '\033[38;5;093m')
      $(printf '\033[38;5;163m')
    "
  fi 
  
  FORE_RED=$(printf '\033[31m')
  FORE_GREEN=$(printf '\033[32m')
  FORE_YELLOW=$(printf '\033[33m')
  FORE_BLUE=$(printf '\033[34m')
  FORE_BOLD=$(printf '\033[1m')
  FORE_RESET=$(printf '\033[0m')

fi 
