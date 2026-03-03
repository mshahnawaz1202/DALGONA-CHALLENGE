

# DALGONA CHALLENGE  🔺⭐☂️🔵

![Bash](https://img.shields.io/badge/Language-Bash-282C34?logo=gnu-bash)
![OS](https://img.shields.io/badge/Platform-Ubuntu-E95420?logo=ubuntu)
![Version](https://img.shields.io/badge/Version-1.0.0-blue)
![Lines](https://img.shields.io/badge/Lines-448-lightgrey)
![License](https://img.shields.io/badge/License-Unlicensed-red)

🎯 A terminal-based DalGona (shape guessing) game implemented in Bash. Players identify ASCII shapes within a time limit and earn points. This project includes single-player, vs-computer, and multiplayer modes.

**Quick Icons / Shapes**: 🔵 circle • ⭐ star • ☂ umbrella • 🔺 triangle

**🚀 Demo**

- 🎮 Simple terminal game with colorful ASCII shapes and a scoring system.

**📁 Contents**

- 📄 `pro.sh`: The main Bash game script.
- 📝 `high_scores.txt`: Appended with player scores after each game.

**✨ Features**

- 👤 Single Player, 🤖 Vs Computer, and 👥 Multiplayer modes.
- ⚡ Adjustable difficulty levels (Easy / Medium / Hard).
- 🎨 Colorful ASCII shapes displayed in the terminal.
- 🏆 Simple high score tracking (appends to `high_scores.txt`).

**🛠️ Requirements**

- 🐧 Ubuntu or any Unix-like shell with Bash (Linux, macOS, WSL, or Git Bash on Windows).
- 🖥️ Terminal that supports ANSI color escape codes.

**▶️ How to run**

1. Make the script executable (if necessary):

```bash
chmod +x Code.sh
```

2. Run the game:

```bash
./Code.sh
# or
bash Code.sh
```

**⚠️ Notes for Windows users**

- If you're on Windows, run this inside WSL, Git Bash, or another ANSI-compliant terminal for the best experience.

**🧩 Development**

- The script is self-contained. For small changes, edit the relevant function inside `pro.sh`:
  - 🎉 `disWelcomeMsg()` — welcome screen
  - 🕹️ `disGameMode()` — select the mode and player names
  - ⏱️ `Difficulty_level()` — adjust `time_limit`
  - 🎯 `player_turn()` / 🤖 `computer_turn()` / 👥 `multiplayer_turn()` — game logic



