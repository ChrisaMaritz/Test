import Foundation

func rollDie() -> Int {
    return Int.random(in: 1...6)
}

let targetScore = 50
var playerScore = 0
var aiScore = 0

print("Welcome to Dice Duel! First to \(targetScore) points wins.")

while playerScore < targetScore && aiScore < targetScore {
    // Player turn
    var turnScore = 0
    print("\nYour turn. Total score: \(playerScore). AI score: \(aiScore).")
    playerTurn: while true {
        let roll = rollDie()
        print("You rolled a \(roll)")
        if roll == 1 {
            print("Bust! You lose your turn score.")
            turnScore = 0
            break playerTurn
        } else {
            turnScore += roll
            print("Turn score: \(turnScore). Type 'r' to roll again or 'h' to hold:", terminator: " ")
            if let choice = readLine()?.lowercased() {
                if choice == "h" {
                    playerScore += turnScore
                    print("You hold. Total score now \(playerScore).")
                    break playerTurn
                } else if choice != "r" {
                    print("Invalid input, rolling again by default.")
                }
            }
        }
    }

    if playerScore >= targetScore { break }

    // AI turn
    turnScore = 0
    print("\nAI's turn. Total score: \(aiScore).")
    while true {
        let roll = rollDie()
        print("AI rolled a \(roll)")
        if roll == 1 {
            print("AI busts and loses its turn score.")
            turnScore = 0
            break
        } else {
            turnScore += roll
            // AI strategy: hold if turnScore >= 12 or it can win this turn
            if turnScore >= 12 || aiScore + turnScore >= targetScore {
                aiScore += turnScore
                print("AI holds. Total score now \(aiScore).")
                break
            }
        }
    }
}

if playerScore >= targetScore {
    print("\nCongratulations! You beat the AI with \(playerScore) points.")
} else {
    print("\nThe AI wins with \(aiScore) points. Better luck next time!")
}
