import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

import '../utils/AppConstants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  gettodos() async {
    try {

      bool isInternetconnected= await isInternetConnected();
      if(isInternetconnected){
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Users")
            .doc("udI68FakU8FvSwZUwsxZ")
            .collection("Todo")
            .orderBy("datetime", descending: false)
            .get();
        emit(HomeLoaded(querySnapshot));
      }else{
        emit(HomeInternetConnection(errorMessage: "Please Check Your Internet Connection"));
      }



    } on FirebaseException catch (e) {
      print("Error Found");
      if (e.code == 'unavailable') {
        // Firebase is offline
        emit(HomeError(
            errorMessage:
                'Firebase is offline. Please check your internet connection.'));
      } else {
        // Other Firebase-related errors
        emit(HomeError(errorMessage: e.toString()));
      }
    } catch (e) {
      print("Error Found");

      print("e.toString()");
      print(e.toString());
      emit(HomeError(errorMessage: e.toString()));
    }
  }

  deletTodobyId(var id) async {
    try {

      await FirebaseFirestore.instance
          .collection("Users")
          .doc("udI68FakU8FvSwZUwsxZ")
          .collection("Todo")
          .doc(id)
          .delete()
          .then((value) => gettodos());

    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }

  deletefirstTodo() async {
    try {
      // Query Firestore to retrieve documents ordered by timestamp in ascending order
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc("udI68FakU8FvSwZUwsxZ") // Closing quote was missing here
          .collection("Todo")
          .orderBy('datetime', descending: false)
          .limit(1) // Limit to retrieve only the first document
          .get();

      // Check if there are documents in the result
      if (querySnapshot.docs.isNotEmpty) {
        // Access the oldest document
        DocumentSnapshot oldestDocument = querySnapshot.docs.first;

        // Delete the oldest document
        await oldestDocument.reference.delete().then((value) => gettodos());
      } else {
        emit(HomeError(errorMessage: 'No documents found in the collection'));
      }
    } catch (e) {
      emit(HomeError(errorMessage: 'Error deleting data:${e.toString()}'));
    }
  }

  updateSwitch(var id, value) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc("udI68FakU8FvSwZUwsxZ")
          .collection("Todo")
          .doc(id)
          .update({"complete": value ? 1 : 0});
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc("udI68FakU8FvSwZUwsxZ")
          .collection("Todo")
          .orderBy("datetime", descending: false)
          .get();
      emit(HomeLoaded(querySnapshot));
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }

  updateTodo(var todoId, var text) async {
    try {
      // Update the title in Firestore and close the bottom sheet
      await FirebaseFirestore.instance
          .collection("Users")
          .doc("udI68FakU8FvSwZUwsxZ")
          .collection("Todo")
          .doc(todoId)
          .update({"title": text}).then((value) => gettodos());
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }

  AddNewTodo(var todo) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc("udI68FakU8FvSwZUwsxZ")
          .collection("Todo")
          .add({
            "title": todo,
            "complete": 0,
            "datetime": FieldValue.serverTimestamp(),
          })
          .then((value) => gettodos())
          .onError((error, stackTrace) => print("error"));
    } catch (e) {
      print("Error: ${e.toString()}");
      emit(HomeError(errorMessage: e.toString()));
    }
  }


}
