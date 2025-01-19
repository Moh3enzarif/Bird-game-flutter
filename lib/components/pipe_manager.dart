import 'dart:math';
import 'package:bird_game/components/pipe.dart';
import 'package:bird_game/constance.dart';
import 'package:bird_game/game.dart';
import 'package:flame/components.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    pipeSpawnTimer += dt;
    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    // Calculate Pipe Height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * maxPipeHeight - minPipeHeight;

    // height of top pipe
    final topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    // Create Bottom Pipe
    final bottomPipe = Pipe(
        //position
        Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
        //size
        Vector2(pipeWidth, bottomPipeHeight),
        isTopPipe: false);

    // Create Top Pipe
    final topPipe = Pipe(
      //position
      Vector2(gameRef.size.x, 0),
      //size
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    // add both pipes
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
