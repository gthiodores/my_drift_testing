import 'package:drift_testing/database/database.dart';
import 'package:drift_testing/presentation/categories_list_route.dart';
import 'package:drift_testing/presentation/todo_master_detail_route.dart';
import 'package:drift_testing/presentation/todos_edit_route.dart';
import 'package:drift_testing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const TodoMasterDetailRoute(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case TODO_LIST_ROUTE:
            return MaterialPageRoute(
                builder: (_) => const TodoMasterDetailRoute());
          case TODO_EDIT_ROUTE:
            final Todo? todo = settings.arguments as Todo?;
            return MaterialPageRoute(builder: (_) => TodoEditRoute(todo: todo));
          case CATEGORY_LIST_ROUTE:
            return MaterialPageRoute(builder: (_) => CategoryListRoute());
          default:
            return MaterialPageRoute(builder: (_) {
              return const Scaffold(
                body: Center(
                  child: Text('Page not found :('),
                ),
              );
            });
        }
      },
    );
  }
}
