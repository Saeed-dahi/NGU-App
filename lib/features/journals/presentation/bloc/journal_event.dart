part of 'journal_bloc.dart';

sealed class JournalEvent extends Equatable {
  const JournalEvent();

  @override
  List<Object> get props => [];
}

class ShowJournalEvent extends JournalEvent {
  final int journalId;
  final String? direction;

  const ShowJournalEvent({required this.journalId, this.direction});
}

class CreateJournalEvent extends JournalEvent {
  final JournalEntity journalEntity;
  final List<TransactionEntity> transactions;

  const CreateJournalEvent(
      {required this.journalEntity, required this.transactions});
}

class UpdateJournalEvent extends JournalEvent {
  final JournalEntity journalEntity;
  final List<TransactionEntity> transactions;

  const UpdateJournalEvent(
      {required this.journalEntity, required this.transactions});
}
