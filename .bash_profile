# Login Bash should load the same interactive configuration.
if [[ $- == *i* && -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi
export STM32_PRG_PATH="/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/Resources/bin"
