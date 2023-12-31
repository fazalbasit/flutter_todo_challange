import 'package:flutter/material.dart';
import 'package:flutter_todo_challange/Pages/AddTodo.dart';
import 'package:flutter_todo_challange/bloc/home_cubit.dart';
import 'package:provider/provider.dart';

import '../utils/AppConstants.dart';

Future<void> showDeleteConfirmationDialog(BuildContext context, var id) async {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {

      bool isInternetconnected= await isInternetConnected();
      if(isInternetconnected){
        Provider.of<HomeCubit>(context, listen: false).deletTodobyId(id);
        Navigator.of(dialogContext).pop();

      } else{
        Navigator.pop(context);
        final snackBar = SnackBar(
          content: Text(
              'Please check your Internet Connection'),
          // backgroundColor: _color,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
              // Close the dialog
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showBuyProVersionDialog(BuildContext context,) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Buy Pro Version'),
        content: Text('Are you sure you want to Buy Pro Version?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              bool isInternetconnected= await isInternetConnected();
              if(isInternetconnected){
                Provider.of<HomeCubit>(context, listen: false).deletefirstTodo();
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddTodo()));
              } else{
                Navigator.pop(context);
                final snackBar = SnackBar(
                  content: Text(
                      'Please check your Internet Connection'),
                  // backgroundColor: _color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

              }


            },
            child: Text(
              'Remove first todo',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Buy Pro Version',
            ),
          ),
        ],
      );
    },
  );
}
