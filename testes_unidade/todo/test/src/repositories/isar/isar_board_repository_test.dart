import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/model/task.dart';
import 'package:todo/src/repositories/board_repository.dart';
import 'package:todo/src/repositories/isar/isar_board_repository.dart';
import 'package:todo/src/repositories/isar/isar_datasource.dart';
import 'package:todo/src/repositories/isar/task_model.dart';

class IsarDataSourceMock extends Mock implements IsarDataSource {}

void main() {
  late IsarDataSource dataSource;
  late BoardRepository repository;

  setUp(() {
    dataSource = IsarDataSourceMock();
    repository = IsarBoardRepository(dataSource);
  });

  test('fetch', () async {
    when(() => dataSource.getTasks()).thenAnswer((_) async => [
          TaskModel()..id = 1,
        ]);

    final tasks = await repository.fetch();
    expect(tasks.length, 1);
  });

  test('update', () async {
    when(() => dataSource.deleteAllTasks());
    when(() => dataSource.putAllTasks(any())).thenAnswer((_) async => []);

    final tasks = await repository.update([
      const Task(id: -1, description: ''),
      const Task(id: 2, description: ''),
    ]);
    expect(tasks.length, 2);
  });
}
