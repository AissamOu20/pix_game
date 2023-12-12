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
  Player player = Player(character: 'Pink Man');

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final world = Level(player: player);

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    addJostick();

    return super.onLoad();
  }

  void addJostick() {}
}
