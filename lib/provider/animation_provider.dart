// file: swiper/provider/choose_screen_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseState {
  final int index;
  final Offset dragOffset;

  ChooseState({required this.index, required this.dragOffset});

  ChooseState copyWith({int? index, Offset? dragOffset}) {
    return ChooseState(
      index: index ?? this.index,
      dragOffset: dragOffset ?? this.dragOffset,
    );
  }
}

class ChooseScreenNotifier extends StateNotifier<ChooseState> {
  ChooseScreenNotifier() : super(ChooseState(index: 0, dragOffset: Offset.zero));

  void updateOffset(Offset newOffset) {
    state = state.copyWith(dragOffset: newOffset);
  }

  void resetOffset() {
    state = state.copyWith(dragOffset: Offset.zero);
  }

  void nextIndex() {
    state = state.copyWith(index: state.index + 1, dragOffset: Offset.zero);
  }
}

final chooseScreenProvider =
    StateNotifierProvider<ChooseScreenNotifier, ChooseState>((ref) {
  return ChooseScreenNotifier();
});
