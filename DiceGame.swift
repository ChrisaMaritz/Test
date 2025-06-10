import Foundation

func rollDie() -> Int {
    return Int.random(in: 1...6)
}

let responseTable: [Int: [String]] = [
    1: [
        "Ouch, a 1! No points this time.",
        "Snake eyes, tough luck!"
    ],
    2: [
        "Two on the board.",
        "A modest roll of 2."
    ],
    3: [
        "Three adds up nicely.",
        "A solid 3!"
    ],
    4: [
        "Four! Keep it going.",
        "Rolling a four gives you more."
    ],
    5: [
        "High five!",
        "A strong 5!"
    ],
    6: [
        "Six! You're on fire!",
        "Lucky six!"
    ]
]

func randomMessage(for roll: Int) -> String {
    return responseTable[roll]?.randomElement() ?? ""
}

func chatWithAI() {
    print("Say something to the AI:", terminator: " ")
    if let _ = readLine() {
        let aiResponses = [
            "We'll see about that!",
            "Nice try!",
            "I'm feeling lucky.",
            "Bring it on!"
        ]
        let response = aiResponses.randomElement()!
        print("AI responds: \(response)")
    }
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
        print(randomMessage(for: roll))
        if roll == 1 {
            print("Bust! You lose your turn score.")
            turnScore = 0
            break playerTurn
        } else {
            turnScore += roll
            print("Turn score: \(turnScore). Type 'r' to roll again, 'h' to hold, or 'c' to chat:", terminator: " ")
            if let choice = readLine()?.lowercased() {
                if choice == "h" {
                    playerScore += turnScore
                    print("You hold. Total score now \(playerScore).")
                    break playerTurn
                } else if choice == "c" {
                    chatWithAI()
                    continue playerTurn
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
        print(randomMessage(for: roll))
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
