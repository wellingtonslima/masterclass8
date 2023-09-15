import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/src/model/task.dart';
import 'package:todo/src/repositories/board_repository.dart';
import 'package:todo/src/states/board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  final BoardRepository repository;

  BoardCubit(this.repository) : super(EmptyBoardState());

  Future<void> fetchTasks() async {
    emit(LoadingBoardState());
    try {
      final tasks = await repository.fetch();
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoarState('Error'));
    }
  }

  Future<void> addTask(Task newTask) async {
    final tasks = _getTasks();
    if (tasks == null) return;
    tasks.add(newTask);
    await emitTasks(tasks);
  }

  Future<void> removeTask(Task newTask) async {
    final tasks = _getTasks();
    if (tasks == null) return;
    tasks.remove(newTask);
    await emitTasks(tasks);
  }

  Future<void> checkTask(Task newTask) async {
    final tasks = _getTasks();
    if (tasks == null) return;
    final index = tasks.indexOf(newTask);
    tasks[index] = newTask.copyWith(check: !newTask.check);
    await emitTasks(tasks);
  }

  @visibleForTesting
  void addTasks(List<Task> tasks) {
    emit(GettedTasksBoardState(tasks: tasks));
  }

  List<Task>? _getTasks() {
    final state = this.state;
    if (state is! GettedTasksBoardState) {
      return null;
    }

    return state.tasks.toList();
  }

  Future<void> emitTasks(List<Task> tasks) async {
    try {
      repository.update(tasks);
      emit(GettedTasksBoardState(tasks: tasks));
    } catch (e) {
      emit(FailureBoarState('Error'));
    }
  }
}
