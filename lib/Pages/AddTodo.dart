import 'package:flutter/material.dart';
import 'package:flutter_todo_challange/bloc/home_cubit.dart';
import 'package:flutter_todo_challange/utils/AppConstants.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatelessWidget {
  TextEditingController newtask = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'New Todo',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What task are you planning to perfrom?',
              style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0),
            ),
            Container(
              height: 16.0,
            ),
            TextField(
              controller: newtask,
              // cursorColor: _color,
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Your Todo...',
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  )),
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 36.0),
            ),
            Container(
              height: 26.0,
            ),
            Row(
              children: [
                Container(
                  width: 16.0,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton.extended(
            heroTag: "button_animtaion",
            icon: Icon(Icons.add),
            label: Text('Create Task'),
            onPressed: () async {
              if (newtask.text.isEmpty) {
                final snackBar = SnackBar(
                  content: Text(
                      'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
                  // backgroundColor: _color,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // _scaffoldKey.currentState.showSnackBar(snackBar);
              } else {

                bool isInternetconnected= await isInternetConnected();
                if(isInternetconnected){
                  Provider.of<HomeCubit>(context, listen: false)
                      .AddNewTodo(newtask.text);
                  Navigator.pop(context);
                }else {
                  final snackBar = SnackBar(
                    content: Text(
                        'Please check your Internet Connection'),
                    // backgroundColor: _color,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                }



              }
            },
          );
        },
      ),
    );
  }
}
