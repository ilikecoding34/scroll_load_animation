import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/theme_provider.dart';
import 'package:provider_test/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _darkTheme = true;
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      myController.text = (prefs.getInt('number') != null)
          ? prefs.getInt('number').toString()
          : '1';
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    SnackBar snackBar;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(children: [
        Switch(
          activeColor: Colors.blue,
          activeTrackColor: Colors.white,
          inactiveThumbColor: Colors.black,
          value: _darkTheme,
          onChanged: (val) {
            setState(() {
              _darkTheme = val;
            });
            themeNotifier.onThemeChanged(val, themeNotifier);
          },
        ),
        _darkTheme ? Text('Sötét') : Text('Világos'),
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      width: 150.0,
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          labelText: 'Listázott sorok',
                          labelStyle: TextStyle(color: Colors.green),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      )),
                )),
                ElevatedButton(
                    onPressed: () => {
                          savedlistingnumber(myController.text),
                          snackBar = SnackBar(
                            content: Text('${myController.text} elmentve'),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          ),

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar),
                        },
                    child: Text('Mentés'))
              ],
            ))
      ]),
    );
  }

  void savedlistingnumber(String value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('number', int.parse(value));
  }
}
