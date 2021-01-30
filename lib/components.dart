// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ScreenOne extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final todos = List.generate(
//       50,
//       (i) => Todo(
//         'Todo item ${i + 1}',
//         'Description ${i + 1}',
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen one'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text('Late nights team'),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//             ),
//             ListTile(
//               title: Text('Hong Son Tran'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: Text('Huy Le Hoang'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: Text('Phi Nguyen Hoang'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             child: OutlineButton(
//               onPressed: () async {
//                 final result = await Navigator.pushNamed(
//                   context,
//                   'screentwo',
//                   arguments: ScreenTwoArgs('123456'),
//                 );
//                 if (result == null) {
//                   return;
//                 }
//                 final snackBar = SnackBar(
//                   content: Text(
//                     'Answer: $result',
//                     style: TextStyle(color: Colors.lightBlue),
//                   ),
//                 );
//                 ScaffoldMessenger.of(context)
//                   ..removeCurrentSnackBar()
//                   ..showSnackBar(snackBar);
//               },
//               child: Text(
//                 'Pass id = 123456',
//                 style: TextStyle(color: Colors.lightBlue),
//               ),
//               color: Colors.blue,
//             ),
//           ),
//           Container(
//             child: Expanded(
//               child: TodosWidget(todos: todos),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ScreenTwo extends StatefulWidget {
//   final String id;

//   const ScreenTwo({Key key, @required this.id}) : super(key: key);

//   @override
//   ScreenTwoState createState() => ScreenTwoState(id: this.id);
// }

// class ScreenTwoState extends State<ScreenTwo> {
//   final String id;
//   ScreenTwoState({@required this.id});

//   String lastAnswer = '';

//   Future<Null> getSharedPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final lastAnswer = prefs.getString('answer') ?? '';
//     setState(() {
//       this.lastAnswer = lastAnswer;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getSharedPrefs();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen two'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             OutlineButton(
//               onPressed: () async {
//                 Navigator.pop(context, 'Yes');
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 await prefs.setString('answer', 'Yes');
//               },
//               child: Text('Yes', style: TextStyle(color: Colors.green)),
//               color: Colors.blue,
//             ),
//             OutlineButton(
//               onPressed: () async {
//                 Navigator.pop(context, 'No');
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 await prefs.setString('answer', 'No');
//               },
//               child: Text('No', style: TextStyle(color: Colors.red)),
//               color: Colors.blue,
//             ),
//             Text(
//               'Id = $id',
//               style: TextStyle(color: Colors.lightBlue, fontSize: 25),
//             ),
//             Text(
//               'The last answer is $lastAnswer',
//               style: TextStyle(color: Colors.purple, fontSize: 30),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TodosWidget extends StatelessWidget {
//   final List<Todo> todos;

//   TodosWidget({Key key, @required this.todos}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: todos.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(
//             todos[index]?.title,
//           ),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => DetailScreen(),
//                 settings: RouteSettings(
//                   arguments: todos[index],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class DetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Todo todo = ModalRoute.of(context).settings.arguments;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(todo.title),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Text(
//           todo.description,
//           style: TextStyle(fontSize: 40, color: Colors.green),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

// class ScreenTwoArgs {
//   final String id;
//   ScreenTwoArgs(this.id);
// }

// class Todo {
//   final String title;
//   final String description;
//   Todo(this.title, this.description);
// }
