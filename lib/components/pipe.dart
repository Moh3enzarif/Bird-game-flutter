import 'dart:async';
import 'package:bird_game/constance.dart';
import 'package:bird_game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;
  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'pipe-top.png' : 'pipe-bottom.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollingSpeed * dt;

    if (!scored && position.x + size.x < gameRef.bird.position.x) {
      scored = true;

      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }

    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }

  removeFormatParent() {}
}
