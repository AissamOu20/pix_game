import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pixel_game/actor/player.dart';
import 'package:pixel_game/levels/level.dart';

class PixelAdv extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  late JoystickComponent joystick;
  bool showjoystick = false;
  Player player = Player(character: 'Pink Man');

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final world = Level(player: player);

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    if (showjoystick) {
      addJostick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showjoystick) {
      updateJoystick();
    }

    super.update(dt);
  }

  void addJostick() {
    joystick = JoystickComponent(
        background: SpriteComponent(
            sprite: Sprite(images.fromCache('HUD/Joystick.png'))),
        position: Vector2.all(13),
        margin: EdgeInsets.only(left: 32, bottom: 100),
        knob: SpriteComponent(
          sprite: Sprite(images.fromCache('HUD/Knob.png')),
        ));
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.downLeft:
      case JoystickDirection.upLeft:
        player.playerDirection = PlayerDirection.left;

        break;
      case JoystickDirection.right:
      case JoystickDirection.downRight:
      case JoystickDirection.upRight:
        player.playerDirection = PlayerDirection.right;
        break;
      case JoystickDirection.idle:
        player.playerDirection = PlayerDirection.none;
        break;
      default:
        player.playerDirection = PlayerDirection.none;
    }
  }
}
