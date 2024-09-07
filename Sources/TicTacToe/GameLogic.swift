//
//  File.swift
//  
//
//  Created by Василий Тихонов on 08.09.2024.
//

import UIKit

public extension TicTacToeViewController {
    
     func initializeBoard() {
        board.removeAll()
        for row in buttons {
            for button in row {
                board.append(button)
            }
        }
    }
    
     func resetBoard() {
        for button in board {
            button.setTitle("", for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = "Turn\n" + cross
        } else {
            firstTurn = Turn.Nought
            turnLabel.text = "Turn\n" + nought
        }
        currentTurn = firstTurn
    }

     func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal)?.isEmpty ?? true {
                return false
            }
        }
        return true
    }
    
     func checkForVictory(_ symbol: String) -> Bool {
        for i in 0..<3 {
            if thisSymbol(buttons[i][0], symbol) && thisSymbol(buttons[i][1], symbol) && thisSymbol(buttons[i][2], symbol) {
                return true
            }
        }
        for i in 0..<3 {
            if thisSymbol(buttons[0][i], symbol) && thisSymbol(buttons[1][i], symbol) && thisSymbol(buttons[2][i], symbol) {
                return true
            }
        }
        if thisSymbol(buttons[0][0], symbol) && thisSymbol(buttons[1][1], symbol) && thisSymbol(buttons[2][2], symbol) {
            return true
        }
        if thisSymbol(buttons[0][2], symbol) && thisSymbol(buttons[1][1], symbol) && thisSymbol(buttons[2][0], symbol) {
            return true
        }
        return false
    }
    
     func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }

     func resultAlert(title: String) {
        let message = "\nNoughts \(noughtsScore)\n\nCrosses \(crossesScore)"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak self] _ in
            self?.resetBoard()
        }))
        self.present(ac, animated: true)
    }
}

