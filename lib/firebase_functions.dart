import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) =>
                TaskModel.fromJson(docSnapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );
  static Future<void> addTaskToFireStore(TaskModel task) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    DocumentReference<TaskModel> docRef = tasksCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFireStore() async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    querySnapshot.docs;
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> deleteTaskFromFireStore(String taskId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    return tasksCollection.doc(taskId).delete();
  }
}
