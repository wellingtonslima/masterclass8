import 'package:todo/src/model/task.dart';

sealed class BoardState {}

class LoadingBoardState implements BoardState {}

class GettedTasksBoardState implements BoardState {
  final List<Task> tasks;

  GettedTasksBoardState({required this.tasks});
}

class EmptyBoardState extends GettedTasksBoardState {
  EmptyBoardState() : super(tasks: []);
}

class FailureBoarState implements BoardState {
  final String message;

  FailureBoarState(this.message);
}
