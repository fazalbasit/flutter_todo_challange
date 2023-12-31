import 'package:flutter/material.dart';
import 'package:flutter_todo_challange/bloc/home_cubit.dart';
import 'package:flutter_todo_challange/component/Bottomsheet.dart';
import 'package:flutter_todo_challange/component/Custom_Alerts.dart';
import 'package:provider/provider.dart';

import '../utils/AppConstants.dart';

Widget TodoListItem(
  BuildContext context,
  var doc,
) {
  return Container(
    padding: EdgeInsets.only(left: 22.0, right: 22.0),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
      leading: Switch(
        value: int.parse(doc.get("complete").toString()) == 0 ? false : true,
        onChanged: (value) async {

          bool isInternetconnected= await isInternetConnected();
          if(isInternetconnected){
            Provider.of<HomeCubit>(context, listen: false)
                .updateSwitch(doc.id, value);
          } else{
            final snackBar = SnackBar(
              content: Text(
                  'Please check your Internet Connection'),
              // backgroundColor: _color,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }

        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Show the bottom sheet for updating the title
              showUpdateTitleBottomSheet(
                context,
                doc.id,
                doc.get("title"),
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                showDeleteConfirmationDialog(context, doc.id);
              }),
        ],
      ),
      title: Text(
        "${doc.get("title")}",
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
            decoration: int.parse(doc.get("complete").toString()) == 1
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
    ),
  );
}
