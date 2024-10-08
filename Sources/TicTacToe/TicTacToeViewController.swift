//
//  File.swift
//  
//
//  Created by Василий Тихонов on 08.09.2024.
//

import UIKit

public enum Turn {
    case Nought
    case Cross
}

public final class TicTacToeViewController: UIViewController {

     var nought = "⭕️"
     var cross = "❌"
     var firstTurn = Turn.Cross
     var currentTurn = Turn.Cross
     var board = [UIButton]()
     var noughtsScore = 0
     var crossesScore = 0
    
    // MARK: - UI Elements
     lazy var turnLabel: UILabel = {
        let label = UILabel()
        label.text = "Turn\n \(cross)"
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = .black
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

     lazy var buttons: [[UIButton]] = createButtonsGrid()
    
    
    public var backButtonImage: UIImage?
    public var backButtonTintColor: UIColor?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGrid()
        initializeBoard()
        setupConstraints()
        

        let backButton = UIBarButtonItem(image: backButtonImage ?? UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backBarButtonItemTapped))
        backButton.tintColor = backButtonTintColor ?? .black
        navigationItem.leftBarButtonItem = backButton
        

    }
    
    @objc public func backBarButtonItemTapped() {
           navigationController?.popViewController(animated: true)
       }
    

     func setupViews() {
        view.backgroundColor = .systemGray6
        title = "TicTacToe"
        view.addSubview(vStack)
        view.addSubview(turnLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            vStack.topAnchor.constraint(equalTo: turnLabel.bottomAnchor, constant: 10),
            vStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            vStack.heightAnchor.constraint(equalTo: vStack.widthAnchor),

            turnLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            turnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
  public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

     func setupGrid() {
        for row in buttons {
            let hStack = UIStackView(arrangedSubviews: row)
            hStack.axis = .horizontal
            hStack.spacing = 3
            hStack.alignment = .fill
            hStack.distribution = .fillEqually
            vStack.addArrangedSubview(hStack)
        }
    }

     func createButtonsGrid() -> [[UIButton]] {
        var buttonGrid = [[UIButton]]()
        for _ in 0..<3 {
            var row = [UIButton]()
            for _ in 0..<3 {
                let button = UIButton()
                button.setTitle("", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
                button.backgroundColor = .systemGray6
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                row.append(button)
            }
            buttonGrid.append(row)
        }
        return buttonGrid
    }

    @objc func buttonTapped(_ sender: UIButton) {
        guard sender.title(for: .normal) == "" else { return }
        
        let symbol = currentTurn == .Nought ? nought : cross
        sender.setTitle(symbol, for: .normal)
        sender.isEnabled = false
        
        currentTurn = currentTurn == .Nought ? .Cross : .Nought
        turnLabel.text = "Turn\n" + (currentTurn == .Nought ? nought : cross)
        
        if checkForVictory(symbol) {
            if symbol == nought {
                noughtsScore += 1
                resultAlert(title: "Noughts Win!")
            } else {
                crossesScore += 1
                resultAlert(title: "Crosses Win!")
            }
        } else if fullBoard() {
            resultAlert(title: "Draw! The board is full.")
        }
    }
}

