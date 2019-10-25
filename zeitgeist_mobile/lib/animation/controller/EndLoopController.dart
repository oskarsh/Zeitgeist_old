import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

class EndLoopController implements FlareController {
  final String _animation;
  final double _loopAmount;
  final double _mix;

  EndLoopController(this._animation, this._loopAmount, [this._mix = 0.5]);

  @override
  void initialize(FlutterActorArtboard artboard) {
    _actor = artboard.getAnimation(_animation);
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {}

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  ValueNotifier<bool> isActive;
}