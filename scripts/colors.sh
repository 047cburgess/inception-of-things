# Usage: echo -e ...

# ANSI color reset
echo "export C_RESET='\033[0m'" >> /etc/environment

# Standard colors
echo "export C_BLACK='\033[0;30m'"   >> /etc/environment
echo "export C_RED='\033[0;31m'"     >> /etc/environment
echo "export C_GREEN='\033[0;32m'"   >> /etc/environment
echo "export C_YELLOW='\033[0;33m'"  >> /etc/environment
echo "export C_BLUE='\033[0;34m'"    >> /etc/environment
echo "export C_PURPLE='\033[0;35m'"  >> /etc/environment
echo "export C_CYAN='\033[0;36m'"    >> /etc/environment
echo "export C_WHITE='\033[0;37m'"   >> /etc/environment

# Bold / bright variants
echo "export C_BOLD_BLACK='\033[1;30m'"   >> /etc/environment
echo "export C_BOLD_RED='\033[1;31m'"     >> /etc/environment
echo "export C_BOLD_GREEN='\033[1;32m'"   >> /etc/environment
echo "export C_BOLD_YELLOW='\033[1;33m'"  >> /etc/environment
echo "export C_BOLD_BLUE='\033[1;34m'"    >> /etc/environment
echo "export C_BOLD_PURPLE='\033[1;35m'"  >> /etc/environment
echo "export C_BOLD_CYAN='\033[1;36m'"    >> /etc/environment
echo "export C_BOLD_WHITE='\033[1;37m'"   >> /etc/environment

# 256-color extras — pink family + others
echo "export C_PINK='\033[38;5;205m'"          >> /etc/environment
echo "export C_HOT_PINK='\033[38;5;198m'"      >> /etc/environment
echo "export C_LIGHT_PINK='\033[38;5;218m'"    >> /etc/environment
echo "export C_PALE_VIOLET_RED='\033[38;5;211m'" >> /etc/environment
echo "export C_ORANGE='\033[38;5;209m'"        >> /etc/environment
echo "export C_SKY_BLUE='\033[38;5;117m'"      >> /etc/environment
echo "export C_PLUM='\033[38;5;183m'"          >> /etc/environment
