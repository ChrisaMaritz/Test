import Foundation

func rollDie() -> Int {
    return Int.random(in: 1...6)
}

/// Possible text for each die face.
let faceMessages: [Int: [String]] = [
    1: ["Oh no, snake eyes!", "A one means bust."],
    2: ["Rolling a timid two.", "Two dots staring back."],
    3: ["Triple threat with a three.", "A solid three."],
    4: ["Four. Nice and even.", "A steady four."],
    5: ["High five for a five!", "Five on the board."],
    6: ["Six! Maximum roll.", "You hit the high six!"]
]

/// Random AI responses to short player messages.
let aiReplies = [
    "Good luck with that roll!",
    "We'll see who wins this round.",
    "Interesting strategy...",
    "I'm not worried about your chances."
]

func messageForRoll(_ roll: Int) -> String {
    return faceMessages[roll]?.randomElement() ?? ""
}

func aiReply() -> String {
    return aiReplies.randomElement() ?? ""
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
        print("Predict high (h) or low (l):", terminator: " ")
        let guessInput = readLine()?.lowercased() ?? ""
        let guessHigh = guessInput == "h"
        print("Say something to the AI or press Enter to roll:", terminator: " ")
        let chat = readLine() ?? ""
        if !chat.isEmpty {
            print("You: \(chat)")
            print("AI: \(aiReply())")
        }

        let roll = rollDie()
        let bonus = ((guessHigh && roll > 3) || (!guessHigh && roll <= 3)) ? 1 : 0
        print("You rolled a \(roll). \(messageForRoll(roll))")
        if bonus > 0 { print("Your prediction was correct! +1 bonus point.") }
        if roll == 1 {
            print("Bust! You lose your turn score.")
            turnScore = 0
            break playerTurn
        } else {
            turnScore += roll + bonus
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
    print("AI: \(aiReply())")
    while true {
        let roll = rollDie()
        print("AI rolled a \(roll). \(messageForRoll(roll))")
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
