import 'dart:async';
import 'package:bird_game/components/ground.dart';
import 'package:bird_game/components/pipe.dart';
import 'package:bird_game/constance.dart';
import 'package:bird_game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  /*

  INIT Bird

  */
  Bird()
      : super(
          position: Vector2(birdStartX, birdStartY),
          size: Vector2(birdWidth, birdHeight),
        );
  double velocity = 0;

  /*

  Load

  */

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('Bird.png');

    add(RectangleHitbox());
  }

  /*

  JUMP Flap

  */

  void flap() {
    velocity = jumpStrength;
  }

  /*

  UPDATE Every Second

  */

  @override
  void update(double dt) {
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }

    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
