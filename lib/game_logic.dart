class TicTacToeGame {
  List<String> board = List.filled(9, '');
  String currentPlayer = '';
  String player1Symbol = '';
  String player2Symbol = '';

  TicTacToeGame({required this.player1Symbol, required this.player2Symbol}) {
    currentPlayer = player1Symbol;
  }

  Future<void> makeMove(int index) async {
    if (board[index].isEmpty) {
      board[index] = currentPlayer;
      currentPlayer =
          (currentPlayer == player1Symbol) ? player2Symbol : player1Symbol;
    }
  }

  void resetGame() {
    board = List.filled(9, '');
    currentPlayer = player1Symbol;
  }

  bool isGameOver() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (board[i].isNotEmpty &&
          board[i] == board[i + 1] &&
          board[i + 1] == board[i + 2]) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i].isNotEmpty &&
          board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6]) {
        return true;
      }
    }

    // Check diagonals
    if (board[0].isNotEmpty && board[0] == board[4] && board[4] == board[8]) {
      return true;
    }

    if (board[2].isNotEmpty && board[2] == board[4] && board[4] == board[6]) {
      return true;
    }

    // Check for a tie
    if (!board.contains('')) {
      return true;
    }

    return false;
  }
}
