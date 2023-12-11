// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/components.dart';

import 'package:pixel_game/pixel_adv.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent with HasGameRef<PixelAdv> {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  final double fps = 0.05;
  final String character;
  Player({
    position,
    required this.character,
  }) : super(position: position);
  @override
  FutureOr<void> onLoad() {
    _onloadallanimation();
    return super.onLoad();
  }

  void _onloadallanimation() {
    idleAnimation = _spriteAnimation('Idle', 11);
    runAnimation = _spriteAnimation('Run', 12);

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runAnimation
    };
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
        game.images.fromCache('Main Characters/$character/$state (32x32).png'),
        SpriteAnimationData.sequenced(
            amount: amount, stepTime: fps, textureSize: Vector2.all(32)));
  }
}
