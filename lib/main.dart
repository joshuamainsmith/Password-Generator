import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:random_words/random_words.dart';

void main() {
  runApp(const MyApp());
}

String pass = "";
String generateWords(int num)
{
  pass = "";
  for (var i = 0; i < num; i++, pass = "$pass ")
  {
    pass = pass + generateAdjective().take(1).join();
    pass = "$pass ";
    i++;
    if (i < num)
      {
        pass = pass + generateNoun().take(1).join();
      }
  }
  pass = pass.trim();
  if (kDebugMode) {
    print(pass);
  }

  return pass;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _isWithLetters = false;
  bool _isWithUppercase = false;
  bool _isWithNumbers = false;
  bool _isWithSpecial = false;
  bool _isWithWords = true;
  bool _isWithSpaces = true;
  bool isSwitched = true;
  bool _isAdvanced = false;
  double _numberCharPassword = 5;
  String newPassword = '';
  String _labelText = "Enter Number of Words Here";
  Color _color = Colors.blue;
  String isOk = '';
  String strAdvanced = 'Show Advanced Settings';
  final TextEditingController _passwordLength = TextEditingController();
  final password = RandomPasswordGenerator();
  @override
  void initState() {
    super.initState();
  }

  toggleSpaces(String name, Function(bool?)? onTap, bool value)
  {
    if (isSwitched)
      {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name, style: TextStyle(color: Colors.white)),
            Checkbox(value: value, onChanged: onTap/*null/onTap*/),
          ],
        );
      }
    else
      {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name, style: TextStyle(color: Colors.grey)),
            Checkbox(value: value, onChanged: null/*null/onTap*/),
          ],
        );
      }
  }

  checkBox(String name, Function(bool?)? onTap, bool value) {
    if (isSwitched && name != strAdvanced)
      {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name, style: TextStyle(color: Colors.grey)),
            Checkbox(value: value, onChanged: null/*null/onTap*/),
          ],
        );
      }
    else
      {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name, style: TextStyle(color: Colors.white)),
            Checkbox(value: value, onChanged: onTap/*null/onTap*/),
          ],
        );
      }
  }

  checkSwitch(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(name),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              if (kDebugMode) {
                print(isSwitched);
              }
              if (!isSwitched)
              {
                _labelText = "Enter Number of Characters Here";
              }
              else
              {
                _labelText = "Enter Number of Words Here";
                _isWithLetters = false;
                _isWithUppercase = false;
                _isWithNumbers = false;
                _isWithSpecial = false;
              }
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Random Password Generator'),
        ),
        body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    checkBox(strAdvanced, (bool? value) {
                      _isAdvanced = value!;
                      setState(() {
                      });
                    }, _isAdvanced),
                  ],
                ),
                if (_isAdvanced)
                const SizedBox(
                  height: 10,
                ),
                /* Comment start*/
                if (_isAdvanced)
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    checkSwitch('Words'),
                    toggleSpaces('Spaces', (bool? value) {
                      _isWithSpaces = value!;
                      setState(() {});
                    }, _isWithSpaces)
                  ],
                ),

                /*
                const SizedBox(
                  height: 10,
                ),
                /* Comment start*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    checkBox('Words', (bool? value) {
                      _isWithWords = value!;
                      setState(() {
                        if (!_isWithWords)
                        {
                          pass = newPassword;
                          _labelText = "Enter Number of Characters Here";
                        }
                        else
                        {
                          _labelText = "Enter Number of Words Here";
                          _isWithLetters = false;
                          _isWithUppercase = false;
                          _isWithNumbers = false;
                          _isWithSpecial = false;
                        }
                      });
                    }, _isWithWords),
                    checkBox('Spaces', (bool? value) {
                      _isWithSpaces = value!;
                      setState(() {});
                    }, _isWithSpaces)
                  ],
                ),
                */
                if (_isAdvanced)
                  const SizedBox(
                  height: 10,
                ),
                if (_isAdvanced)
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                      checkBox('Upper Case', (bool? value) {
                      _isWithUppercase = value!;
                      setState(() {
                      });
                    }, _isWithUppercase),
                    checkBox('Lower Case', (bool? value) {
                      _isWithLetters = value!;
                      setState(() {
                      });
                    }, _isWithLetters)
                  ],
                ),
                if (_isAdvanced)
                  const SizedBox(
                  height: 10,
                ),
                if (_isAdvanced)
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    checkBox('Symbols', (bool? value) {
                      _isWithSpecial = value!;
                      setState(() {

                      });
                    }, _isWithSpecial),
                    checkBox('Numbers', (bool? value) {
                      _isWithNumbers = value!;
                      setState(() {

                      });
                    }, _isWithNumbers)
                  ],
                ),
                /* Comment end*/

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _passwordLength,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.grey[300],
                       labelText: _labelText,
                      labelStyle: const TextStyle(color: Colors.indigo),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      if (_passwordLength.text.trim().isNotEmpty) {
                        _numberCharPassword =
                            double.parse(_passwordLength.text.trim());
                      }
                      else
                        {
                          _numberCharPassword = 5;
                        }

                      generateWords(_numberCharPassword.toInt());

                      newPassword = password.randomPassword(
                          letters: _isWithLetters,
                          numbers: _isWithNumbers,
                          passwordLength: _numberCharPassword,
                          specialChar: _isWithSpecial,
                          uppercase: _isWithUppercase);

                      if (kDebugMode) {
                        print(newPassword);
                      }

                      if (!isSwitched)
                        {
                          pass = newPassword;
                        }
                      if (!_isWithSpaces)
                        {
                          pass = pass.replaceAll(' ', '');
                        }
                      if (!_isWithUppercase)
                        {
                          pass = pass.toLowerCase();
                        }

                      double passwordstrength =
                      password.checkPassword(password: pass);
                      if (pass.length < 15)
                        {
                          _color = Colors.red;
                          isOk = 'This password is less than 15 characters!';
                        }
                      else if (passwordstrength < 0.7) {
                        _color = Colors.red;
                        isOk = 'This password is weak!';
                      } else if (passwordstrength < 0.9) {
                        _color = Colors.blue;
                        isOk = 'This password is Good';
                      } else {
                        _color = Colors.green;
                        isOk = 'This password is Strong';
                      }

                      setState(() {});
                    },
                    child: Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Generate Password',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                if (newPassword.isNotEmpty)
                  Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isOk,
                            style: TextStyle(color: _color, fontSize: 25),
                          ),
                        ),
                      )),
                if (newPassword.isNotEmpty)
                  Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            pass,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        if(pass == ""){
                          if (kDebugMode) {
                            print('enter text');
                          }
                        } else {
                          if (kDebugMode) {
                            print(pass);
                          }
                          FlutterClipboard.copy(pass);
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Center(child: Text('COPY', style: TextStyle(color: Colors.white),)),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
