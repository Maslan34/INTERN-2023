import 'package:flutter/material.dart';

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
  int _counter = 0;
  int _buttonActivating=0;
  String ucurulacakYazi="";

  var isim="Muharrem";
  var sinif =3;
  var yetenekler=["C","Flutter","SiberGüvenlik"];


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            YaziYazmaYeri(ucurulacakYazi:ucurulacakYazi),
            TextField(onChanged: (value){
                  print(value);
            },),
            ElevatedButton(
                onPressed: _buttonActivating == 0 ? () {
                  print("o");
                  setState(() {
                    _buttonActivating=1;
                    ucurulacakYazi="Muharrem";

                  });

                }:null,
                child: Text("Muharrem")),
            ElevatedButton(onPressed: _buttonActivating == 1 ? () {
              print("1");
              setState(() {
                _buttonActivating=0;
                ucurulacakYazi="Aslan";
              });

            }:null,
                child: Text("Aslan")),
            Text(isim,textScaleFactor: 4),
            Text("$sinif.sınıf",textScaleFactor: 3),
            for (final element in yetenekler)
              Text(element),
            ElevatedButton(onPressed: () { setState(() {
              yetenekler.add("yeni");
            });;},
            child: Text('Öğrenci Ekle'))
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

class YaziYazmaYeri extends StatefulWidget {
  final String ucurulacakYazi;
  const YaziYazmaYeri({Key? key, required this.ucurulacakYazi}) : super(key: key);

  @override
  State<YaziYazmaYeri> createState() => _YaziYazmaYeriState();
}

class _YaziYazmaYeriState extends State<YaziYazmaYeri> {
  @override

  late TextEditingController textEditingController;

  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController=TextEditingController();
    textEditingController.addListener(() {
      print("Listenerından dinleme yapılıyor:${textEditingController.text}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant YaziYazmaYeri oldWidget) {
    // TODO: implement didUpdateWidget

    if(oldWidget.ucurulacakYazi != widget.ucurulacakYazi){
      textEditingController.text=textEditingController.text+" "+widget.ucurulacakYazi+" ";
      // Cursoru sona getirme
      textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: textEditingController.text.length) );

    }
    super.didUpdateWidget(oldWidget);
  }
  Widget build(BuildContext context) {
    return TextField(onChanged: (value){
      Text(value);
    },
    controller: textEditingController,
    decoration: InputDecoration(
        suffixIcon: IconButton(
      icon: Icon(Icons.delete),
      onPressed: (){
        // delete basıldığında fieldı temizleme
        textEditingController.text="";
      },)),

    );
  }
}

