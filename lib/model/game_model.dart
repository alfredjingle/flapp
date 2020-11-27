import 'package:flutter/widgets.dart';
import 'package:flapp/state/game_state.dart';

class GameModel extends InheritedNotifier<GameState> {
  GameModel({GameState notifier, Widget child})
      : super(notifier: notifier, child: child);

  static GameModel of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<GameModel>();
    } else {
      return context
          .getElementForInheritedWidgetOfExactType<GameModel>()
          .widget;
    }
  }
}
