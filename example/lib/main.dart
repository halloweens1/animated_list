import 'package:animated_list/animated_list.dart';
import 'package:example/ui/widget/list_item.dart';
import 'package:flutter/material.dart' hide AnimatedList, AnimatedListState;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> _list = List.generate(3, (index) => (3 - 1) - index);
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _insertAtBeginning() {
    _list.insert(0, _list.length);
    _listKey.currentState?.insertItem(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: AnimatedList(
          key: _listKey,
          shrinkWrap: true,
          reverse: true,
          initialItemCount: _list.length,
          itemBuilder: (ctx, index, animation) {
            return SizeTransition(
              key: ValueKey(_list[index]),
              sizeFactor: animation,
              axisAlignment: -1,
              child: SlideTransition(
                  position: animation.drive(Tween(
                          begin: const Offset(0.0, 1.0),
                          end: const Offset(0.0, 0.0))
                      .chain(CurveTween(curve: Curves.linear))),
                  child: ListItem(
                    id: _list[index],
                    content: '${_list[index]}',
                  )),
            );
          },
          findChildIndexCallback: (Key key) {
            if (key is ValueKey) {
              int index = _list.indexWhere((e) => e == key.value);
              return index == -1 ? null : index;
            } else {
              return null;
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insertAtBeginning,
        tooltip: 'Insert',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
