import 'package:flutter/material.dart';
import 'package:flutter_todo_challange/bloc/home_cubit.dart';
import 'package:provider/provider.dart';

import '../utils/AppConstants.dart';

void showUpdateTitleBottomSheet(
    BuildContext context, String todoId, String currentTitle) {
  TextEditingController titleController =
      TextEditingController(text: currentTitle);

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Todo Title',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'New Title'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                bool isInternetconnected = await isInternetConnected();
                if (isInternetconnected) {
                  Provider.of<HomeCubit>(context, listen: false)
                      .updateTodo(todoId, titleController.text);
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    content: Text('Please check your Internet Connection'),
                    // backgroundColor: _color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      );
    },
  );
}
