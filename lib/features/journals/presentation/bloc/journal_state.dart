part of 'journal_bloc.dart';

sealed class JournalState extends Equatable {
  const JournalState();

  @override
  List<Object> get props => [];
}

final class JournalInitial extends JournalState {}

class LoadingJournalState extends JournalState {}

class LoadedJournalState extends JournalState {
  final JournalEntity journalEntity;

  const LoadedJournalState({required this.journalEntity});
  @override
  List<Object> get props => [journalEntity];
}

class ErrorJournalState extends JournalState {
  final String message;

  const ErrorJournalState({required this.message});
  @override
  List<Object> get props => [message];
}
