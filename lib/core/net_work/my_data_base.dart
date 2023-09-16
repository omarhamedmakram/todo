import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/add_task_model.dart';

class MyDataBase {
  static CollectionReference<AddTaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection(AddTaskModel.collection)
        .withConverter<AddTaskModel>(
          fromFirestore: (snapshot, options) {
            return AddTaskModel.fromFireStore(snapshot.data() ?? {});
          },
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> addTask(AddTaskModel addTaskModel) async {
    var collection = getCollection();
    var doc = collection.doc();
    addTaskModel.id = doc.id;
    doc.set(addTaskModel);
  }

  static Stream<QuerySnapshot<AddTaskModel>> getTask() {
    var collection = getCollection();
    return collection.snapshots();
  }

  static Future<void> deleteTask(AddTaskModel taskModel) {
    var collection = getCollection();
    return collection.doc(taskModel.id).delete();
  }

  static Future<void> UpdateTask(AddTaskModel addTaskModel) {
    var collection = getCollection();
    return collection.doc(addTaskModel.id).update(addTaskModel.toFireStore());
  }
}
