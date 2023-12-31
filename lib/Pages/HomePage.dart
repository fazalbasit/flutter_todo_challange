import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_challange/Pages/AddTodo.dart';
import 'package:flutter_todo_challange/component/TodoItem.dart';
import 'package:flutter_todo_challange/bloc/home_cubit.dart';
import 'package:flutter_todo_challange/component/Custom_Alerts.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text('Flutter Todo App'),
    );
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeLoaded) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: appbar,
            body: Builder(builder: (context) {
              return Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return TodoListItem(
                        context, state.querySnapshot.docs[index]);
                  },
                  itemCount: state.querySnapshot.docs.length,
                ),
              );
            }),
            floatingActionButton: FloatingActionButton(
              heroTag: "button_animtaion",
              onPressed: () => state.querySnapshot.docs.length >= 10
                  ? showBuyProVersionDialog(context)
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddTodo(),
                    )),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ));
      } else if (state is HomeError) {
        return Scaffold(
          appBar: appbar,
          body: Center(child: Text("${state.errorMessage}")),
        );
      } else if (state is HomeInternetConnection) {
        return Scaffold(
          appBar: appbar,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${state.errorMessage}"),
              InkWell(
                  onTap: () {
                    BlocProvider.of<HomeCubit>(context).gettodos();
                  },
                  child: Icon(Icons.refresh))
            ],
          )),
        );
      }
      return Scaffold(
        appBar: appbar,
        body: Center(child: CircularProgressIndicator()),
      );
    });
  }

  Future<bool> isInternetConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
