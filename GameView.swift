import SwiftUI

class Score: ObservableObject {
    @Published var score: Int = 0
}

struct GameView: View {
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    let operators: [String] = ["plus.circle", "minus.circle", "multiply.circle"]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var operatorID: Int = 0
    @State private var currentValue: Int = 0
    @State private var goalValue: Int = Int.random(in: 20...40)
    @State private var isGameOver = false
    @State private var timeRemaining = 30
    
    @State private var setup: [String] = [
        "\(Int.random(in: 1...9)).square",
        "\(Int.random(in: 1...9)).square",
        "\(Int.random(in: 1...9)).square",
        "\(Int.random(in: 1...9)).square",
        "plus.circle",
        "\(Int.random(in: 1...9)).square",
        "\(Int.random(in: 1...9)).square",
        "\(Int.random(in: 1...9)).square",
        "\(Int.random(in: 1...9)).square"
    ]
    
    @ObservedObject var score = Score()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text("Timer: \(timeRemaining)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .onReceive(timer) { _ in
                            updateTimer()
                        }
                    
                    HStack {
                        Text("Goal: \(goalValue)")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(25)
                        
                        Text("Current: \(currentValue)")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(25)
                    }
                    .padding(10)
                }
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.yellow)
                                .frame(width: geometry.size.width / 3 - 15,
                                       height: geometry.size.width / 3 - 15)
                            
                            if i != 4 {
                                Image(systemName: setup[i])
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: operators[operatorID])
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.indigo)
                                    .onTapGesture {
                                        selectOperator()
                                    }
                            }
                        }
                        .onTapGesture {
                            guard !isGameOver else { return }
                            
                            let haptic = UIImpactFeedbackGenerator(style: .rigid)
                            haptic.impactOccurred()
                            
                            if i != 4 {
                                let numberLabel = setup[i]
                                guard let digitChar = numberLabel.first,
                                      let numberValue = digitChar.wholeNumberValue else { return }
                                
                                setup[i] = "checkmark" // mark used
                                performedOperation(numberValue)
                                winCondition()
                            }
                        }
                    }
                }
                .padding(.top)
                
                Text("Score: \(score.score)")
                    .font(.title)
                    .fontWeight(.bold)
                
                if isGameOver {
                    Button(action: {
                        resetGame()
                    }) {
                        Text("Reset Game")
                            .font(.title2)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }
    
    // ✅ All helper functions are defined OUTSIDE the body now
    
    func countRemainingNumbers() {
        var count = 0
        for i in setup {
            if i == "checkmark" {
                count += 1
            }
        }
        if count == 0 && currentValue != goalValue {
            timeRemaining = 0
        }
    }
    
    func winCondition() {
        if currentValue == goalValue {
            score.score += 1
            goalValue = Int.random(in: 20...40)
            currentValue = 0
            operatorID = 0
            setup = [
                "\(Int.random(in: 1...9)).square",
                "\(Int.random(in: 1...9)).square",
                "\(Int.random(in: 1...9)).square",
                "\(Int.random(in: 1...9)).square",
                "plus.circle",
                "\(Int.random(in: 1...9)).square",
                "\(Int.random(in: 1...9)).square",
                "\(Int.random(in: 1...9)).square",
                "\(Int.random(in: 1...9)).square"
            ]
        }
    }
    
    func updateTimer() {
        guard !isGameOver else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            isGameOver = true
        }
    }
    
    func performedOperation(_ numberValue: Int) {
        switch operatorID {
        case 0:
            currentValue += numberValue
        case 1:
            currentValue -= numberValue
        case 2:
            currentValue *= numberValue
        default:
            break
        }
    }
    
    func selectOperator() {
        let haptic = UIImpactFeedbackGenerator(style: .rigid)
        haptic.impactOccurred()
        operatorID = (operatorID + 1) % operators.count
    }
    
    func resetGame() {
        currentValue = 0
        goalValue = Int.random(in: 20...40)
        operatorID = 0
        timeRemaining = 30
        isGameOver = false
        setup = [
            "\(Int.random(in: 1...9)).square",
            "\(Int.random(in: 1...9)).square",
            "\(Int.random(in: 1...9)).square",
            "\(Int.random(in: 1...9)).square",
            "plus.circle",
            "\(Int.random(in: 1...9)).square",
            "\(Int.random(in: 1...9)).square",
            "\(Int.random(in: 1...9)).square",
            "\(Int.random(in: 1...9)).square"
        ]
    }
}
