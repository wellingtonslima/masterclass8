import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/cubits/board_cubit.dart';
import 'package:todo/src/model/task.dart';
import 'package:todo/src/repositories/board_repository.dart';
import 'package:todo/src/states/board_state.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

void main() {
  late BoardRepositoryMock repository = BoardRepositoryMock();
  late BoardCubit cubit;
  tearDown(() => reset(repository));
  setUp(() {
    repository = BoardRepositoryMock();
    cubit = BoardCubit(repository);
  });

  group('fetchTasks |', () {
    test('deve pegar todas as tasks', () async {
      when(() => repository.fetch()).thenAnswer(
        (_) async => [
          const Task(id: 1, description: '', check: false),
        ],
      );

      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadingBoardState>(),
          isA<GettedTasksBoardState>(),
        ]),
      );
      await cubit.fetchTasks();
    });

    test('Deve retornar um estado de erro ao falhar', () async {
      when(() => repository.fetch()).thenThrow(Exception('Error'));

      expect(
        cubit.stream,
        emitsInOrder(
          [isA<LoadingBoardState>(), isA<FailureBoarState>()],
        ),
      );
      await cubit.fetchTasks();
    });
  });

  group('addTasks |', () {
    test('deve pegar uma tasks', () async {
      when(() => repository.update(any())).thenAnswer((_) async => []);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );
      const task = Task(id: 1, description: '');
      await cubit.addTask(task);
      final state = cubit.state as GettedTasksBoardState;
      expect(state.tasks.length, 1);
      expect(state.tasks, [task]);
    });

    test('Deve retornar um estado de erro ao falhar', () async {
      when(() => repository.update(any())).thenThrow(Exception('Error'));

      expect(
        cubit.stream,
        emitsInOrder(
          [isA<FailureBoarState>()],
        ),
      );
      const task = Task(id: 1, description: '');
      await cubit.addTask(task);
    });
  });

  group('removeTasks |', () {
    test('deve remover uma task', () async {
      when(() => repository.update(any())).thenAnswer((_) async => []);
      const task = Task(id: 1, description: '');
      cubit.addTasks([task]);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      expect((cubit.state as GettedTasksBoardState).tasks.length, 1);

      await cubit.removeTask(task);
      final state = cubit.state as GettedTasksBoardState;
      expect(state.tasks.length, 0);
    });

    test('Deve retornar um estado de erro ao falhar', () async {
      when(() => repository.update(any())).thenThrow(Exception('Error'));
      const task = Task(id: 1, description: '');
      cubit.addTasks([task]);

      expect(
        cubit.stream,
        emitsInOrder(
          [isA<FailureBoarState>()],
        ),
      );

      await cubit.removeTask(task);
    });
  });

  group('checkTasks |', () {
    test('deve checar uma task', () async {
      when(() => repository.update(any())).thenAnswer((_) async => []);
      const task = Task(id: 1, description: '');
      cubit.addTasks([task]);
      expect((cubit.state as GettedTasksBoardState).tasks.length, 1);
      expect((cubit.state as GettedTasksBoardState).tasks.first.check, false);

      expect(
        cubit.stream,
        emitsInOrder([
          isA<GettedTasksBoardState>(),
        ]),
      );

      await cubit.checkTask(task);
      final state = cubit.state as GettedTasksBoardState;
      expect(state.tasks.length, 1);
      expect(state.tasks.first.check, true);
    });

    test('Deve retornar um estado de erro ao falhar', () async {
      when(() => repository.update(any())).thenThrow(Exception('Error'));
      const task = Task(id: 1, description: '');
      cubit.addTasks([task]);

      expect(
        cubit.stream,
        emitsInOrder(
          [isA<FailureBoarState>()],
        ),
      );

      await cubit.checkTask(task);
    });
  });
}
