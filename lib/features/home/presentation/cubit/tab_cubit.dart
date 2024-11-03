import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  int tabNumber = 0;
  TabCubit() : super(TabState(tabs: []));

  void addNewTab({required String title, required Widget content}) {
    final newTab = TabData(title: title, content: content);

    // to prevent use from opening same tab
    // if (!state.tabs.contains(newTab)) {
    //   state.tabs.add(newTab);
    // }
    if (!state.tabs.contains(newTab)) {
      tabNumber++;
      final newTab =
          TabData(title: '(${tabNumber.toString()}) $title', content: content);
      state.tabs.add(newTab);
    } else {
      state.tabs.add(newTab);
    }

    emit(TabState(tabs: state.tabs));
  }

  void removeTab(int index) {
    // final newTabs = List<TabData>.from(state.tabs)..removeAt(index);
    emit(TabState(tabs: state.tabs..removeAt(index)));
    reIndexTabNumber();
  }

  void removeLastTab() {
    emit(TabState(tabs: state.tabs..remove(state.tabs.last)));
    reIndexTabNumber();
  }

  void reIndexTabNumber() {
    if (state.tabs.isEmpty) {
      tabNumber = 0;
    }
  }
}
