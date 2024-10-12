import 'dart:io';

class TicTacToe {
  late List<List<String>> board;
  late int boardSize;
  String player1 = '';
  String player2 = '';
  String currentPlayer = '';
  void startGame() {
    print('=============================');
    print('Welcome to Tic-Tac-Toe games!');
    print('=============================');
    boardSize = getBoardSize();
    board = List.generate(boardSize, (_) => List.filled(boardSize, ' '));
    player1 = getPlayerName('Player 1');
    player2 = getPlayerName('Player 2');
    currentPlayer = player1;
    while (true) {
      printBoard();
      print(
          'Current player: $currentPlayer (${currentPlayer == player1 ? 'X' : 'O'})');
      makeMove();
      if (checkWin()) {
        printBoard();
        print('🎉 $currentPlayer wins! 🎉');
        break;
      }
      if (isBoardFull()) {
        printBoard();
        print("🤝 It's a draw! 🤝");
        break;
      }
      currentPlayer = (currentPlayer == player1) ? player2 : player1;
    }
    print('Thanks for playing broo!');
  }

  int getBoardSize() {
    while (true) {
      print('Enter the size of the board (e.g., 3 for 3x3, 5 for 5x5):');
      var input = stdin.readLineSync();
      try {
        int size = int.parse(input!);
        if (size >= 3 && size <= 10) {
          return size;
        } else {
          print('Please enter a number between 3 and 10.');
        }
      } catch (e) {
        print('Invalid input. Please enter a number.');
      }
    }
  }

  String getPlayerName(String playerNumber) {
    print('Enter name for $playerNumber:');
    return stdin.readLineSync() ?? '';
  }

  void printBoard() {
    print('\n');
    print('  ${List.generate(boardSize, (i) => '  ${i + 1} ').join('')}');
    print(' ${'+---' * boardSize}+');
    for (int i = 0; i < boardSize; i++) {
      print(
          '${i + 1}${board[i].map((cell) => '| ${cell == ' ' ? ' ' : cell} ').join('')}|');
      if (i < boardSize - 1) {
        print(' ${'+---' * boardSize}+');
      }
    }
    print(' ${'+---' * boardSize}+');
    print('\n');
  }

  void makeMove() {
    while (true) {
      print('$currentPlayer, enter your move (row and column, e.g., 1 2):');
      var input = stdin.readLineSync()?.split(' ');
      if (input == null || input.length != 2) {
        print('Invalid input. Please try again.');
        continue;
      }
      int row, col;
      try {
        row = int.parse(input[0]) - 1;
        col = int.parse(input[1]) - 1;
      } catch (e) {
        print('Invalid input. Please enter numbers.');
        continue;
      }
      if (row < 0 || row >= boardSize || col < 0 || col >= boardSize) {
        print('Invalid move. Row and column must be between 1 and $boardSize.');
        continue;
      }
      if (board[row][col] != ' ') {
        print('That spot is already taken. Try again.');
        continue;
      }
      board[row][col] = (currentPlayer == player1) ? 'X' : 'O';
      break;
    }
  }

  bool checkWin() {
    for (int i = 0; i < boardSize; i++) {
      if (board[i].every((cell) => cell == board[i][0] && cell != ' '))
        return true;
      if (board.every((row) => row[i] == board[0][i] && row[i] != ' '))
        return true;
    }
    if (List.generate(boardSize, (i) => board[i][i])
        .every((cell) => cell == board[0][0] && cell != ' ')) return true;
    if (List.generate(boardSize, (i) => board[i][boardSize - 1 - i])
        .every((cell) => cell == board[0][boardSize - 1] && cell != ' '))
      return true;
    return false;
  }

  bool isBoardFull() {
    return board.every((row) => row.every((cell) => cell != ' '));
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.startGame();
}
