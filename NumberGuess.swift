import Foundation

let number = Int.random(in: 1...100)
var guess: Int? = nil

print("Welcome to Guess the Number!")
print("I'm thinking of a number between 1 and 100.")

while guess != number {
    print("Enter your guess:", terminator: " ")
    if let line = readLine(), let value = Int(line) {
        guess = value
        if guess! < number {
            print("Too low! Try again.")
        } else if guess! > number {
            print("Too high! Try again.")
        } else {
            print("Correct! The number was \(number).")
        }
    } else {
        print("Please enter a valid integer.")
    }
}
