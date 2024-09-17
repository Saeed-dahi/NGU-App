import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState(tabs: []));

  void addNewTab({required String title, required Widget content}) {
    final newTab = TabData(title: title, content: content);

    // to prevent use from opening same tab
    // if (!state.tabs.contains(newTab)) {
    //   state.tabs.add(newTab);
    // }
    state.tabs.add(newTab);

    emit(TabState(tabs: state.tabs));
  }

  void removeTab(int index) {
    // final newTabs = List<TabData>.from(state.tabs)..removeAt(index);

    emit(TabState(tabs: state.tabs..removeAt(index)));
  }
}
