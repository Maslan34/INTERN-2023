import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
      home: const MyHomePage(title: 'Ogrenci Ekleme'),
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
  var list = ["Muharrem", "Ayşe", "Eda"];
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
 // OKUNANAN OGRENCİ ISMINI LISTEYE EKLEME VE SETSTATE ILE EKRANI GUNCELLEME
  void yeniOgrenciEkle(String yeniOgrenci) {
    setState(() {
      list.add(yeniOgrenci);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        // SINIF WIDGET ILE HEM LISTELEME HEMDE PARAMETRE ILE EKLEME ISLEMI YAPILIYOR.
        child: sinif(list: list, yeniOgrenciEkleme: yeniOgrenciEkle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class sinif extends StatelessWidget {
  final List<String> list;
  final void Function(String yeniOgrenci) yeniOgrenciEkleme;

  const sinif({super.key, required this.list, required this.yeniOgrenciEkleme});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      // x ekseninde align ama kapsadığı alanda
      children: <Widget>[
        // LISTE DE KI HER ELEMAN SINIF LISTESI WIDGETINA GONDERILEREKE EKRANA BASTIRILIYOR.
        for (final element in list) sinifListesi(element: element),
        ogrenciEkleme(yeniOgrenciEkleme: yeniOgrenciEkleme),
        ElevatedButton(
          child: const Text('Sonraki projeye Geç'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FirstRoute()),
            );
          },
        )
      ],
    );
  }
}

class ogrenciEkleme extends StatefulWidget {
  final void Function(String yeniOgrenci) yeniOgrenciEkleme;
  const ogrenciEkleme({
    super.key,
    required this.yeniOgrenciEkleme,
  });

  @override
  State<ogrenciEkleme> createState() => _ogrenciEklemeState();
}

class _ogrenciEklemeState extends State<ogrenciEkleme> {
  @override
  var textFieldController = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextField(
          controller: textFieldController,
        ),
        ElevatedButton(
            onPressed: () {

              // STRING BOS VEYA BOSLUK SADECE SPACE ICERIYORSA BUNU LISTEYE EKLEMEYOR.
              final yeniOgrenci = textFieldController.text;
              yeniOgrenci == " " || yeniOgrenci == ""
                  ? null
                  : widget.yeniOgrenciEkleme(yeniOgrenci);
              //EKLEME ISLEMI YAPILDIKTAN SONRA FIELD TEMIZLENIYOR.
              textFieldController.text = "";
            },
            child: Text("Ogrenci ekle")),
      ],
    );
  }
}

class sinifListesi extends StatelessWidget {
  const sinifListesi({
    super.key,
    required this.element,
  });

  final String element;

  @override
  Widget build(BuildContext context) {
    return Text(element);
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alignment'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // x ekseninde align ama kapsadığı alanda
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.star),
                Text("Muharrem "),
                Text("Aslan"),
                Icon(Icons.star)
              ],
            ),

            Text("Aslan"),
            Text("Muharrem"),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Left"),
            ),
            Align(
              alignment: Alignment.center,
              child: Text("Center"),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Right"),
            ),

            ////SIZED BOX WIDTH HEIGHT DEGERLERI ALABILIR
            SizedBox(
                width: 175,
                height: 115,
                child: Center(
                    child: Text(
                  "Sized Box > CENTER",
                  textAlign: TextAlign.right,
                ))),
            SizedBox(
                width: 175,
                height: 115,
                child:

                    ////ALIGN ALIGN EDILEBILEN BIR KUTU OLUSTURUR ALABILIR
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Sized Box > ALIGN",
                        ))),

            ///// CONTAINER = ALIGN + SIZED BOX

            Container(
                width: 175,
                height: 115,
                child:

                    ////ALIGN ALIGN EDILEBILEN BIR KUTU OLUSTURUR ALABILIR
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "CONTAINER > ALIGN ",
                        ))),
            ElevatedButton(
              child: const Text('Sonraki projeye Geç'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Önceki Sayfa Dön')),
          ],
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ALIGNMENT 2'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
                width: 200,
                height: 200,
                // CONTANIER HEM WIDTH HEM ALIGN OZELLIGI ALABİLİR.
                child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Container(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.yellow,
                              alignment: Alignment.center,
                              child: Text(" bu container 400 px olamaz")),
                        )))),
            SizedBox(
                width: 100,
                height: 200,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Text(
                      "Burda 2.Size box 60 olamıyor parent izin vermiyor bunun için araya bir center atılır.w=100"),
                )),
            SizedBox(
                width: 100,
                height: 100,
                child: Center(
                    child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Text("0<w<100"),
                ))),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdRoute()),
                );
              },
              child: Text("Sonraki projeye Geç"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Geri Dön!'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layouts'),
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(children: [
            //FLEXIBLE SADECE SIKIRKEN EXPANDED HEM SIKISIR HEM DE GENISLEYEBILIR
            Row(
              children: [
                Flexible(child: Text("Muharrem Aslan")),
                Text("Muharrem Aslan"),
                Text("Muharrem Aslan"),
                Text("Muharrem Aslan"),
                Text("Muharrem Aslan"),
                Text("Muharrem Aslan"),
              ],
            ),

            ////STACK Widgetlerın üst üste binmesine olanak saglar.
            //// ayrıca stack mantıgı gecerlidir en son widget ilk render edilir.
            //// en büyük olan widget alanı tamamen kaplar
            Stack(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 150,
                  color: Colors.red,
                ),
                Container(
                  width: 180,
                  height: 120,
                  color: Colors.green,
                ),
                Container(
                  width: 160,
                  height: 100,
                  color: Colors.blue,
                ),
                Positioned(top: 80, left: 90, child: Text("blue")),
                Positioned(top: 100, left: 135, child: Text("green")),
                Positioned(top: 130, left: 170, child: Text("red"))
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FourthRoute()),
                );
              },
              child: Text("Sonraki projeye Geç"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Geri Dön!'),
            ),
          ]),
        ),
      ),
    );
  }
}

class FourthRoute extends StatelessWidget {
  const FourthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive Screen(Media) and Images'),
      ),
      body: Center(
          child: Container(
        child: Column(
          children: [
            Text("Adaptive Screen(Media) and Images",
                style: TextStyle(fontSize: 20, color: Colors.red)),
            Positioned(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // BURDAKAI LAYOUT BUILDER SAYESİNDE CONST. BELIRLENEREK RESPONSIVE EKRAN TASARLANABILIR
                // UYGULAMAYI DAHA BUYUK EKRANDA VEYA WEB DE CALISTIRIP YAZININ DEGISTI GOZLEMLENEBILIR.
                if (constraints.maxWidth > 550) {
                  return Text("maxWidth>550");
                } else {
                  return Text("maxWidth<550");
                }
              },
            )),
            SizedBox(
                width: 150,
                height: 150,
                child: Center(child: Image.asset("images/leo_edited.jpg"))),
            Text("Video", style: TextStyle(fontSize: 20, color: Colors.red)),
            SizedBox(width: 150, height: 150, child: video()),
            // BURDAKI RESİM INTDEN CEKILEREK GOSTERILIYOR CACHE ATILMIYOR VEYA UYGULAMA ICINDEN CAGRILMIYOR.
            resmiGor(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  FiveRoute()),
                )
                ;
              },
              child: const Text('Sonraki projeye Geç!'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Geri Dön!'),
            ),
          ],
        ),
      )),
    );
  }
}

class FiveRoute extends StatelessWidget {
   FiveRoute({Key? key}) : super(key: key);
  var  donenDeger;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Navigation'),
        ),
        body: Container(
            child: Column(
          children: [
            Text(
                "Navigition çağırdığımızda  Scaffold  widgetı döndürürsek iyi olur.",
                style: TextStyle(fontSize: 20, color: Colors.red)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => navigation1(deger: 34)));
                },
                child: Text(
                    "Bir sonraki ekrana constructor parametresi ile veri gönder VERI --> 34 ")),
            ElevatedButton(
                onPressed: () async {

                  /// Burda <> generic yaparak donen degerin kontrolü saglandi string donerse popdan hata vericek!!!
                  /// burda async ve await kaldırıp tekrar deneyebilirsin...



                   donenDeger = await Navigator.push<bool>(context,
                      MaterialPageRoute(builder: (context) => navigation2()));


                  print(donenDeger);

                },
                child: Text("Bir sonraki ekrana await ile async olarak veri al")),

          ],
        )));
  }
}

class navigation1 extends StatelessWidget {
  const navigation1({Key? key, required this.deger}) : super(key: key);
  final int deger;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Constructor Parameter'),
        ),
        body: Center(
          child: Text("$deger"),
        ));
  }
}

class navigation2 extends StatelessWidget {
   navigation2({Key? key}) : super(key: key);
  var yasKontrol;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Async'),
        ),
        body: Column(children: [


          Text("18 yaşından büyük müsün?"),
          ElevatedButton(
            onPressed: () {

              Navigator.of(context).pop(true);

            },
            child: Text("Evet"),
          ),
          ElevatedButton(
            onPressed: () {

              Navigator.of(context).pop(false);
            },
            child: Text("Hayır"),
          ),
          Text("Bu Butonlar Will pop u tetikleyecek eğer 18 yaşından büyük değilse dönülmeyecek",style: TextStyle(fontSize: 20,color: Colors.red)),
          ElevatedButton(
            onPressed: () {

              Navigator.of(context).maybePop();
              yasKontrol=true;
            },
            child: Text("Hayır"),
          ),ElevatedButton(
            onPressed: () {

              Navigator.of(context).maybePop();
              yasKontrol=false;
            },
            child: Text("Hayır"),
          ),


        ]));

  }
}

/// Stateful widget to fetch and then display video content.
class video extends StatefulWidget {
  const video({super.key});

  @override
  _videoState createState() => _videoState();
}

class _videoState extends State<video> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("videos/beni_daralttin.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class resmiGor extends StatefulWidget {
  resmiGor({Key? key}) : super(key: key);
  int _confirmed = 0;
  @override
  State<resmiGor> createState() => _resmiGorState();
}

class _resmiGorState extends State<resmiGor> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: Column(
        children: [
          if (widget._confirmed == 1)
            Image.network("https://picsum.photos/id/237/200/300"),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  widget._confirmed = 1;
                });
              },
              child: Text("Resmi Gör")),
        ],
      ),
    );
  }
}
