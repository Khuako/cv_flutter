import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScopedModel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ScopedModel Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScopedModel Widget'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ScopedModel<MyModelState>(
            model: MyModelState(),
            child: _AppRootWidget(),
          ),
        ],
      ),
    );
  }
}

class _AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModelState>(
      builder: (context, child, model) => Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            Text('(Root Widget)', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 50),
            Text('${model.counterValue}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _Counter(),
                _Counter(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModelState>(
      rebuildOnChange: true,
      builder: (context, child, model) => Card(
        margin: const EdgeInsets.all(4.0).copyWith(bottom: 32.0),
        color: Colors.yellowAccent,
        child: Column(
          children: <Widget>[
            const Text('(Child Widget)'),
            Text('${model.counterValue}',
                style: Theme.of(context).textTheme.headline4),
            ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () => model._decrementCounter(),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.green,
                  onPressed: () => model._incrementCounter(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyModelState extends Model {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void _decrementCounter() {
    _counter--;
    notifyListeners();
  }
}

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
