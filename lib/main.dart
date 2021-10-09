import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/TodoModel.dart';
import 'package:provider_test/settings_page.dart';
import 'package:provider_test/theme_provider.dart';
import 'package:provider_test/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cp.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoModel()),
          ChangeNotifierProvider<ThemeNotifier>(
              create: (_) =>
                  ThemeNotifier(darkModeOn ? darkTheme : lightTheme)),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late bool betoltott;
  int number = 0;
  int plus = 0;
  double szam = 0;
  double start = 0;
  double meret = 0;
  double elozo = 0;
  double elso = 0;
  double animpadding = 0;
  bool bottomelerve = false;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    betoltott = true;
    getsavednumber();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      bottomelerve = true;
    } else {
      bottomelerve = false;
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      //  loadmore();
    }
  }

  getsavednumber() async {
    SharedPreferences.getInstance().then((prefs) {
      plus = prefs.getInt('number') ?? 0;
    });
  }

  move(double indulas, double mozgas) {
    setState(() {
      meret = indulas - mozgas;
      if (meret < 0) {
        meret = 0;
      }
    });
    if (meret > 150) {
      meret = 0;
      bool loaded = Provider.of<TodoModel>(context, listen: false).getloaded;
      if (loaded) {
        loadmore();
      }
    }
  }

  loadmore() async {
    await getsavednumber();
    Provider.of<TodoModel>(context, listen: false).getalldatas(number, plus);
    number = number + plus;
    bottomelerve = false;
    szam = 0;
    start = 0;
    meret = 0;
    elozo = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api provider test'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
                child: Icon(Icons.more_vert),
              )),
        ],
      ),
      body: GestureDetector(
          onVerticalDragStart: (detail) =>
              {start = detail.globalPosition.dy.floorToDouble()},
          onVerticalDragUpdate: (detail) => {
                szam = detail.globalPosition.dy.floorToDouble(),
                move(start, szam),
              },
          onVerticalDragEnd: (value) => setState(() {
                meret = 0;
              }),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Consumer<TodoModel>(
                  builder: (context, todo, child) {
                    return Listener(
                        onPointerDown: (PointerDownEvent event) {
                          if (bottomelerve) {
                            elso = event.position.dy;
                          }
                        },
                        onPointerUp: (PointerUpEvent event) {
                          setState(() {
                            meret = 0;
                          });
                        },
                        onPointerMove: (PointerMoveEvent event) {
                          if (bottomelerve) {
                            move(elso, event.position.dy);
                          } else {
                            setState(() {
                              meret = 0;
                            });
                          }
                        },
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ListView.builder(
                              itemCount: todo.taskapiList.length,
                              controller: _controller,
                              shrinkWrap: false,
                              itemBuilder: (context, index) {
                                return Container(
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 5, 0),
                                        child: Card(
                                            child: ListTile(
                                          title: Text(todo.taskapiList[index].id
                                                  .toString() +
                                              ': ' +
                                              todo.taskapiList[index].title),
                                        ))));
                              },
                              // A subclass of `ScrollView`
                            ),
                            ClipRect(
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  heightFactor: (meret > 0 && meret < 900)
                                      ? meret / 300
                                      : 0,
                                  child: Column(
                                    children: [
                                      /*   Container(
                                        color: Colors.black.withOpacity(0.2),
                                        height: 5,
                                        width: double.infinity,
                                      ),*/
                                      /*
                                      Container(
                                        height: 100,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                        ),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text('Pull more')),
                                      ),
                                      Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                        ),
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text('Almost')),
                                      ),*/
                                      CustomPaint(
                                        size: Size(
                                            700,
                                            (700 * 0.625)
                                                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                        painter: RPSCustomPainter(meret),
                                      ),
                                    ],
                                  )),
                            ),
                            Consumer<TodoModel>(
                                builder: (context, todo, child) {
                              return todo.loaded
                                  ? Container()
                                  : Positioned(
                                      top: MediaQuery.of(context).size.height *
                                          0.5,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.black,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                        strokeWidth: 10,
                                      ));
                            }),
                          ],
                        ));
                  },
                ),
              ),
              Container(
                height: 20,
                color: Colors.transparent,
              ),
              Container(
                height: 20,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text('Pull up to load more'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () => loadmore(),
                            child: Text('Load more')),
                        ElevatedButton(
                            onPressed: () => {
                                  Provider.of<TodoModel>(context, listen: false)
                                      .addTaskInList(),
                                },
                            child: Text('+1')),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
