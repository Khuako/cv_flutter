// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CountProvider>.value(
            value: CountProvider(),
          ),
          FutureProvider<List<User>>(
            create: (_) async => UserProvider().loadUserData(),
            initialData: [],
          ),
          StreamProvider(
              create: (_) => EventProvider().intStream(), initialData: 0),
        ],
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Provider Demo'),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.add),
                  ),
                  Tab(
                    icon: Icon(Icons.person),
                  ),
                  Tab(
                    icon: Icon(Icons.message),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              MyCountPage(),
              MyUserPage(),
              MyEventPage(),
            ]),
          ),
        ),
      ),
    );
  }
}

class MyCountPage extends StatelessWidget {
  const MyCountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountProvider _state = Provider.of<CountProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ChangeNotifierProvider Example',
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 50),
            Text('${_state.counterValue}',
                style: Theme.of(context).textTheme.headlineMedium),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () => _state._decrementCount(),
                ),
                Consumer<CountProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.green,
                      onPressed: () => value._incrementCount(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CountProvider extends ChangeNotifier {
  int _count = 0;
  int get counterValue => _count;
  void _incrementCount() {
    _count++;
    notifyListeners();
  }

  void _decrementCount() {
    _count--;
    notifyListeners();
  }
}

class MyUserPage extends StatelessWidget {
  const MyUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('FutureProvider Example, users loaded from a File',
              style: TextStyle(fontSize: 17)),
        ),
        Consumer<List<User>>(
          builder: (context, List<User> users, _) {
            return Expanded(
              child: users.isEmpty
                  ? Container(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 50,
                            color: Colors.grey[(index * 200) % 400],
                            child: Center(
                                child: Text(
                                    '${users[index].firstName} ${users[index].lastName} | ${users[index].website}')));
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}

class User {
  final String firstName, lastName, website;
  const User(this.firstName, this.lastName, this.website);
  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        website = json['website'];
}

class UserList {
  final List<User> users;
  UserList(this.users);
  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((user) => User.fromJson(user)).toList();
}

class UserProvider {
  final String _dataPath = "assets/users.json";
  List<User> users = [];

  Future<String> loadAsset() async {
    return await Future.delayed(const Duration(seconds: 2), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>> loadUserData() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    return users;
  }
}

// Event page (counting)
class MyEventPage extends StatelessWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _value = Provider.of<int>(context);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('StreamProvider Example', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 50),
        Text('${_value.toString()}',
            style: Theme.of(context).textTheme.headlineMedium)
      ],
    ));
  }
}

class EventProvider {
  Stream<int> intStream() {
    Duration interval = Duration(seconds: 2);
    return Stream<int>.periodic(interval, (int _count) => _count++);
  }
}




// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ScopedModel Widget'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: <Widget>[
//           ScopedModel<MyModelState>(
//             model: MyModelState(),
//             child: _AppRootWidget(),
//           ),
//         ],
//       ),
//     );
//   }
// }




// class _AppRootWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<MyModelState>(
//       builder: (context, child, model) => Card(
//         elevation: 4.0,
//         child: Column(
//           children: <Widget>[
//             Text('(Root Widget)', style: Theme.of(context).textTheme.headline4),
//             const SizedBox(height: 50),
//             Text('${model.counterValue}'),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 _Counter(),
//                 _Counter(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Counter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<MyModelState>(
//       rebuildOnChange: true,
//       builder: (context, child, model) => Card(
//         margin: const EdgeInsets.all(4.0).copyWith(bottom: 32.0),
//         color: Colors.yellowAccent,
//         child: Column(
//           children: <Widget>[
//             const Text('(Child Widget)'),
//             Text('${model.counterValue}',
//                 style: Theme.of(context).textTheme.headline4),
//             ButtonBar(
//               children: <Widget>[
//                 IconButton(
//                   icon: const Icon(Icons.remove),
//                   color: Colors.red,
//                   onPressed: () => model._decrementCounter(),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   color: Colors.green,
//                   onPressed: () => model._incrementCounter(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyModelState extends Model {
//   int _counter = 0;

//   int get counterValue => _counter;

//   void _incrementCounter() {
//     _counter++;
//     notifyListeners();
//   }

//   void _decrementCounter() {
//     _counter--;
//     notifyListeners();
//   }
// }

// INHERITED WIDGET 
//
//
//
//

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   int get counterValue => _counter;

//   void _incrementCounter() => setState(() => _counter++);
//   void _decrementCounter() => setState(() => _counter--);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Inherited Widget'),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: <Widget>[
//           MyInheritedWidget(
//             myState: this,
//             child: const AppRootWidget(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AppRootWidget extends StatelessWidget {
//   const AppRootWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final rootWidgetState = MyInheritedWidget.of(context)!.myState;
//     return Card(
//       elevation: 4.0,
//       child: Column(
//         children: <Widget>[
//           Text('(Root Widget)', style: Theme.of(context).textTheme.bodySmall),
//           Text('${rootWidgetState.counterValue}',
//               style: Theme.of(context).textTheme.bodySmall),
//           const SizedBox(height: 50),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: const <Widget>[
//               Counter(),
//               Counter(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Counter extends StatelessWidget {
//   const Counter({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final rootWidgetState = MyInheritedWidget.of(context)!.myState;
//     return Card(
//       margin: const EdgeInsets.all(4.0).copyWith(bottom: 32.0),
//       color: Colors.yellowAccent,
//       child: Column(
//         children: <Widget>[
//           const Text('(Child Widget)'),
//           Text('${rootWidgetState.counterValue}',
//               style: Theme.of(context).textTheme.displayMedium),
//           ButtonBar(
//             children: <Widget>[
//               IconButton(
//                 icon: const Icon(Icons.remove),
//                 color: Colors.red,
//                 onPressed: () => rootWidgetState._decrementCounter(),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.add),
//                 color: Colors.green,
//                 onPressed: () => rootWidgetState._incrementCounter(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyInheritedWidget extends InheritedWidget {
//   final MyHomePageState myState;

//   const MyInheritedWidget(
//       {Key? key, required Widget child, required this.myState})
//       : super(key: key, child: child);
//   @override
//   bool updateShouldNotify(MyInheritedWidget oldWidget) {
//     return true;
//   }

//   static MyInheritedWidget? of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType();
//   }
// }
