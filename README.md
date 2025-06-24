# 🧠BrainRush — iOS Game (SwiftUI)

**BrainRush** is a timed arithmetic puzzle game built with SwiftUI.  
Your goal: reach a randomly generated target value by selecting numbers and operations from a 3x3 grid — all within 30 seconds!

---

## 🚀 Features

- 🧮 Simple math gameplay (Addition, Subtraction, Multiplication)
- 🟡 Interactive 3x3 circle grid with tap gestures
- 🔁 Operator selector (taps the center icon to cycle through +, -, ×)
- ⏱ Countdown timer (30 seconds per round)
- 🎯 Randomized goal and input numbers
- 🎉 Score tracking and game reset
- ✅ Haptic feedback on each tap
- 🛠 Safe handling of optionals to prevent crashes

---

## 📸 Screenshots

![Photo 24-06-25, 6 15 13 PM (2)](https://github.com/user-attachments/assets/7960d272-bc11-4fa5-a1bc-67573ed6c245)
![Photo 24-06-25, 6 15 13 PM (1)](https://github.com/user-attachments/assets/dd3b80bc-d1cf-4fd2-8780-04212a0d7f24)

---

## 🛠 Tech Stack

- `Swift`  
- `SwiftUI`  
- `Xcode`  
- `UIKit` (for haptics)
- `SF Symbols` for visual representation

---

## ✅ Improvements & Fixes

| Issue                                  | Fix                                                   |
|---------------------------------------|--------------------------------------------------------|
| `setup[i] = ""` caused crash          | Replaced with `"checkmark"` (valid SF Symbol)         |
| Optional value forced unwrapped       | Used `guard let` to unwrap safely                     |
| Timer kept running after game end     | Added `guard !isGameOver` condition                   |
| Game over not visible                 | Added `"Game Over"` message + styling                 |
| No reset mechanism                    | Added `"Reset Game"` button to restart logic cleanly  |

---

## 🎮 How to Play

1. Use the center operator icon to cycle between `+`, `-`, `×`
2. Tap numbers on the grid to perform the operation with the current total
3. Match the **Goal** value before the timer ends
4. Win and score increases — or lose and press **Reset Game** to try again!

---

## 🔄 Future Enhancements (Coming Soon)

- ⬆️ Level system with increasing difficulty  
- 🔊 Sound feedback and animations  
- 🧠 Smarter operator suggestions  
- 📊 High score tracking with persistence  
- 🌐 Leaderboard integration

---

## 📁 Folder Structure (if you split into files)


