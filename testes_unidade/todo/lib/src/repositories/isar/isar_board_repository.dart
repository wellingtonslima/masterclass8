import 'package:todo/src/model/task.dart';
import 'package:todo/src/repositories/board_repository.dart';
import 'package:todo/src/repositories/isar/isar_datasource.dart';
import 'package:todo/src/repositories/isar/task_model.dart';

class IsarBoardRepository implements BoardRepository {
  final IsarDataSource dataSource;

  /**
   * Está usando uma camada "Suja", camada que é quase imposível ser testada.
   */
  IsarBoardRepository(this.dataSource);

  @override
  Future<List<Task>> fetch() async {
    final models = await dataSource.getTasks();
    return models
        .map((e) => Task(
              id: e.id,
              description: e.description,
              check: e.check,
            ))
        .toList();
  }

  @override
  Future<List<Task>> update(List<Task> tasks) async {
    final models = tasks.map((e) {
      final model = TaskModel()
        ..check = e.check
        ..description = e.description;
      if (e.id != -1) {
        model.id = e.id;
      }
      return model;
    }).toList();

    await dataSource.deleteAllTasks();
    await dataSource.putAllTasks(models);

    return tasks;
  }
}
