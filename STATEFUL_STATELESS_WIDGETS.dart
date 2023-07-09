import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'STATEFULL VS STATELESS'),
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
  String _TextFieldInformation = "";
  bool _checkBoxBool = false;
  int _buttonActivating = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Muharrem Aslan',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            sayi('Şu anki Değer -> $_counter'),
            sayac('Stateless Degeri-> $_counter', 3),

            // BINARY BUTTON
            ElevatedButton(
                onPressed: _buttonActivating == 0
                    ? () {
                        print("o");
                        setState(() {
                          _buttonActivating = 1;
                        });
                      }
                    : null,
                child: Text("o")),
            ElevatedButton(
                onPressed: _buttonActivating == 1
                    ? () {
                        print("1");
                        setState(() {
                          _buttonActivating = 0;
                        });
                      }
                    : null,
                child: Text("1")),
            Checkbox(
                value: _checkBoxBool,
                onChanged: (checkValueChanged) {
                  setState(() {
                    if (checkValueChanged != null) {
                      _checkBoxBool = checkValueChanged;
                    }
                  });
                }),

            TextField(
              onChanged: (TextFieldInformation) {
                print(TextFieldInformation);
                setState(() {
                  _TextFieldInformation = TextFieldInformation;
                });
              },
            ),
            Text(_TextFieldInformation)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//STALESS
class sayi extends StatelessWidget {
  final String deger;
  const sayi(this.deger, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(deger);
  }
}

//STATEFUL
class sayac extends StatefulWidget {
  final int ilkDeger;
  final String sayacDegeri;
  const sayac(this.sayacDegeri, this.ilkDeger, {Key? key}) : super(key: key);

  @override
  State<sayac> createState() => _sayacState();
}

class _sayacState extends State<sayac> {
  int baslangicDegeri = 0;

  @override
  void initState() {
    super.initState();
    baslangicDegeri = widget.ilkDeger;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            baslangicDegeri++;
          });
        },
        child: Text('Stateful Sayac Degeri-> $baslangicDegeri'));
  }
}
