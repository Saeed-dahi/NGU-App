part of 'tab_cubit.dart';

class TabState {
  final List<TabData> tabs;

  TabState({required this.tabs});
}

class TabData extends Equatable {
  final String title;
  final Widget content;

  const TabData({required this.title, required this.content});

  @override
  List<Object?> get props => [title,content];
}
