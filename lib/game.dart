import 'dart:async';
import 'package:bird_game/components/background.dart';
import 'package:bird_game/components/bird.dart';
import 'package:bird_game/components/ground.dart';
import 'package:bird_game/components/pipe_manager.dart';
import 'package:bird_game/components/score.dart';
import 'package:bird_game/constance.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:bird_game/components/pipe.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;
  @override
  FutureOr<void> onLoad() {
    // load background
    background = Background(size);
    add(background);

    // load bird
    bird = Bird();
    add(bird);

    // load ground
    ground = Ground();
    add(ground);

    // load pipes
    pipeManager = PipeManager();
    add(pipeManager);

    // score
    scoreText = ScoreText();
    add(scoreText);
  }

  @override
  void onTap() {
    bird.flap();
  }

  /*

  Score

  */
  int score = 0;

  void incrementScore() {
    score += 1;
  }

  bool isGameOver = false;
  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    // show dialog box for user
    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("High Score: $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              resetGame();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    // Remove all Pipes from the game
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFormatParent);
    resumeEngine();
  }
}
