part of 'printing_bloc.dart';

sealed class PrintingState extends Equatable {
  const PrintingState();
  
  @override
  List<Object> get props => [];
}

final class PrintingInitial extends PrintingState {}
