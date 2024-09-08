# TicTacToe

## Это библиотека для реализации мини игры крестики-нолики в своем проекте.

* После того как мини-игра будет подключена в проект, её можно будет вызвать в контроллере.

> [!TIP]
>  import TicTacToe
> let ticTacToeVC = TicTacToeViewController()
> navigationController?.pushViewController(ticTacToeVC, animated: true)


* У VC есть свойства "backButtonImage: UIImage?" и "backButtonTintColor: UIColor?" для реализации кастомной кнопки возврата.

> [!TIP]
> "let ticTacToeVC = TicTacToeViewController()
> ticTacToeVC.backButtonImage = UIImage(systemName: "chevron.left")
> ticTacToeVC.backButtonTintColor = .black
> navigationController?.pushViewController(ticTacToeVC, animated: true)"

