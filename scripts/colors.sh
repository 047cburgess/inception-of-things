C_RESET='\033[0m'
C_BLACK='\033[0;30m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'
C_PURPLE='\033[0;35m'
C_CYAN='\033[0;36m'
C_WHITE='\033[0;37m'
C_BOLD_BLACK='\033[1;30m'
C_BOLD_GREY='\033[1;38;5;239m'
C_BOLD_RED='\033[1;31m'
C_BOLD_GREEN='\033[1;32m'
C_BOLD_YELLOW='\033[1;33m'
C_BOLD_BLUE='\033[1;34m'
C_BOLD_PURPLE='\033[1;35m'
C_BOLD_CYAN='\033[1;36m'
C_BOLD_WHITE='\033[1;37m'
C_PINK='\033[38;5;205m'
C_HOT_PINK='\033[38;5;198m'
C_LIGHT_PINK='\033[38;5;218m'
C_PALE_VIOLET_RED='\033[38;5;211m'
C_ORANGE='\033[38;5;209m'
C_SKY_BLUE='\033[38;5;117m'
C_PLUM='\033[38;5;183m'

# Braille extended set (U+2800–U+28FF):
#⠀⠁⠂⠃⠄⠅⠆⠇⠈⠉⠊⠋⠌⠍⠎⠏⠐⠑⠒⠓⠔⠕⠖⠗⠘⠙⠚⠛⠜⠝⠞⠟
#⠠⠡⠢⠣⠤⠥⠦⠧⠨⠩⠪⠫⠬⠭⠮⠯⠰⠱⠲⠳⠴⠵⠶⠷⠸⠹⠺⠻⠼⠽⠾⠿
#⡀⡁⡂⡃⡄⡅⡆⡇⡈⡉⡊⡋⡌⡍⡎⡏⡐⡑⡒⡓⡔⡕⡖⡗⡘⡙⡚⡛⡜⡝⡞⡟
#⡠⡡⡢⡣⡤⡥⡦⡧⡨⡩⡪⡫⡬⡭⡮⡯⡰⡱⡲⡳⡴⡵⡶⡷⡸⡹⡺⡻⡼⡽⡾⡿
#⢀⢁⢂⢃⢄⢅⢆⢇⢈⢉⢊⢋⢌⢍⢎⢏⢐⢑⢒⢓⢔⢕⢖⢗⢘⢙⢚⢛⢜⢝⢞⢟
#⢠⢡⢢⢣⢤⢥⢦⢧⢨⢩⢪⢫⢬⢭⢮⢯⢰⢱⢲⢳⢴⢵⢶⢷⢸⢹⢺⢻⢼⢽⢾⢿
#⣀⣁⣂⣃⣄⣅⣆⣇⣈⣉⣊⣋⣌⣍⣎⣏⣐⣑⣒⣓⣔⣕⣖⣗⣘⣙⣚⣛⣜⣝⣞⣟
#⣠⣡⣢⣣⣤⣥⣦⣧⣨⣩⣪⣫⣬⣭⣮⣯⣰⣱⣲⣳⣴⣵⣶⣷⣸⣹⣺⣻⣼⣽⣾⣿

WELCOME_SSH="${C_BOLD_GREY}
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰${C_HOT_PINK}⣶⣶⣤⣴⠛⠉${C_BOLD_GREY}
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣀⣠⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣄⣀⡀⠀⠀⠀⠀${C_HOT_PINK}
⠀⠀⢸⣟⠛⠛⠛⢻⣿⡟⠛⠛⠛⢻⣿⣿⡟⠛⠛⠛⢻⣿⡟⠛⠛⠛⣻⡇⠀⠀
⠀⠀⢸⡿⢦⣤⣴⠞⣿⠻⣦⣤⡴⠟⢸⡇⠻⢦⣤⣴⠟⣿⠷⣦⣤⡴⢿⡇⠀⠀${C_RESET}${C_HOT_PINK}     Today, in ExpoZoo:  ${C_RESET}${C_PINK}
⠀⠀⢸⡇⠂⠀⢂⢀⡿⠀⢂⠀⠀⠂⢸⡇⠀⠂⠔⠀⢂⢿⡀⢂⠀⠂⢸⡇⠀⠀${C_PINK}     - p1: ${C_WHITE} Petting lounge ${C_PINK}
⠀⠀⣿⠔⠀⠂⠀⣸⠇⢂⠀⠂⠀⢠⡟⢻⡄⢂⠀⠂⠀⠸⣇⠀⠂⢂⠀⣿⠀⠀${C_PINK}     - p2: ${C_WHITE} The monkeys' cage  ${C_LIGHT_PINK}
⠀⢰⡏⠀⢂⠀⢀⡿⠔⠀⠂⠔⢀⡾⠁⠈⢷⡀⠂⠀⢂⠀⢿⡀⢂⠀⠂⢹⡆⠀${C_PINK}     - p3: ${C_WHITE} Aquarium (bonus feeding session)${C_LIGHT_PINK}
⠀⣾⠃⠂⠀⠔⣼⠃⠂⠀⢂⢀⡾⠁⠀⠀⠈⢷⡀⠔⠀⠂⠘⣧⠂⠀⢂⠘⣷⠀${C_WHITE}
⠰⠿⠶⠶⠶⠶⠿⠶⠶⠶⠶⠿⠷⠶⠶⠶⠶⠾⠿⠶⠶⠶⠶⠿⠶⠶⠶⠶⠿⠇${C_RESET}"

WELCOME_P1="${C_BOLD_WHITE}
  Part 1 - Petting Lounge${C_PINK}
                  🫳                  🫳
  There is a bossy 🐱 cat here, and a 🐶 dog doing everything she wants.
${C_RESET}"

WELCOME_P2="${C_BOLD_GREY}
⢀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀     ${C_BOLD_WHITE} Part 2 - The Monkeys' Cage${C_BOLD_GREY}
⢸⠀⡇⢸⠀⡇⢸⠀⡇⢸⠀⡇⢸
⢸⠀⡇⢸⡸⠀⠀⢇⡇⢸⠀⡇⢸                   🙈 🥜
⢸⠀⡇⢸⡇⠀⠀⢸⡇⢸⠀⡇⢸      🙉 🥜
⢸⠀⡇⢸⢧⠀⠀⡇⡇⢸⠀⡇⢸     🥜 🥜
⢸⣀⣇⣘⣀⣇⣘⣀⣇⣘⣀⣇⣘                🙊 🥜
${C_RESET}"

WELCOME_P3="${C_SKY_BLUE}
  ˚ ° ˚ ∘ ˚  ${C_BOLD_WHITE}Part 3 - Aquarium${C_SKY_BLUE}  ˚ ∘ ˚ ° ˚

  A whale 🐋 is guarding the surface.
  Deeper down, an octopus 🐙 is teaching math
  to a school of fish. 🐟  🐟
                  🐟 🐟  🐟
${C_RESET}"

WELCOME_BONUS="${C_SKY_BLUE}
  ˚ ° ˚ ∘ ˚  ${C_BOLD_WHITE}Bonus - Feeding Session${C_SKY_BLUE}  ˚ ∘ ˚ ° ˚

  A fox 🦊 librarian replaces the 📚 books for the octopus 🐙 teacher.
                                       📚   📚
${C_RESET}"

# Persist to /etc/environment only when run as script
# With -export: persist to /etc/environment (used by Vagrant provisioner)
# Without: preview the art locally
if [ "$1" = "-export" ]; then
  printf 'export WELCOME_SSH=%q\n' "$WELCOME_SSH" >> /etc/environment
  printf 'export WELCOME_P1=%q\n' "$WELCOME_P1" >> /etc/environment
  printf 'export WELCOME_P2=%q\n' "$WELCOME_P2" >> /etc/environment
  printf 'export WELCOME_P3=%q\n' "$WELCOME_P3" >> /etc/environment
  printf 'export WELCOME_BONUS=%q\n' "$WELCOME_BONUS" >> /etc/environment
else
  echo -e "$WELCOME_SSH"
  echo -e "$WELCOME_P1"
  echo -e "$WELCOME_P2"
  echo -e "$WELCOME_P3"
  echo -e "$WELCOME_BONUS"
fi
