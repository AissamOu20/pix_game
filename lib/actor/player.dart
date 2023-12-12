// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flame/components.dart';

import 'package:flutter/services.dart';

import 'package:pixel_game/pixel_adv.dart';

enum PlayerState { idle, running }

enum PlayerDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdv>, KeyboardHandler {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;
  final double fps = 0.05;
  String character;
  Player({
    position,
    this.character = 'Ninja Frog',
  }) : super(position: position);
  PlayerDirection playerDirection = PlayerDirection.none;
  double movespeed = 90;
  Vector2 vectority = Vector2.zero();
  bool isFacingRight = true;
  @override
  FutureOr<void> onLoad() {
    _onloadallanimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovment(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isleftkeypressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isrightkeypressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    if (isleftkeypressed && isrightkeypressed) {
      playerDirection = PlayerDirection.none;
      print('Both Arrow key pressed');
    } else if (isleftkeypressed) {
      playerDirection = PlayerDirection.left;
    } else if (isrightkeypressed) {
      playerDirection = PlayerDirection.right;
    } else {
      playerDirection = PlayerDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void _updatePlayerMovment(double dt) {
    double dx = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        current = PlayerState.running;
        dx -= movespeed;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        current = PlayerState.running;
        dx += movespeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
      default:
    }
    vectority = Vector2(dx, 0.0);
    position += vectority * dt;
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
