// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'game_logic.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: TicTacToeGameScreen(),
      ),
    ),
  );
}

class TicTacToeGameScreen extends StatefulWidget {
  const TicTacToeGameScreen({super.key});

  @override
  _TicTacToeGameScreenState createState() => _TicTacToeGameScreenState();
}

class _TicTacToeGameScreenState extends State<TicTacToeGameScreen> {
  TicTacToeGame game = TicTacToeGame(player1Symbol: 'X', player2Symbol: 'O');

  void _makeMove(int index) {
    setState(() {
      game.makeMove(index);
    });
  }

  void _resetGame() {
    setState(() {
      game.resetGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool gameOver = game.isGameOver();
    String winner = '';
    if (gameOver) {
      winner =
          (game.currentPlayer == game.player1Symbol) ? 'Player 1' : 'Player 2';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Game Over'),
              content: Text('Congratulations, $winner!'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: const Text('New Game'),
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: Column(
        children: [
          Text('Current Player: ${game.currentPlayer}'),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _makeMove(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      game.board[index],
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Reset Game'),
          ),
        ],
      ),
    );
  }
}
