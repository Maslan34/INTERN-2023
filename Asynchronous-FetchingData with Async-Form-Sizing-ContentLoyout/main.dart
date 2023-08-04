import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';

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
        title: Text(widget.title),
      ),
      body: Center(
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
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondRoute()));
                },
                child: Text("Sonraki Projeye Geç!"))
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Asynchronous"),
        ),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => futureOzellik()));
                  },
                  child: Text("Future")),
              ElevatedButton(
                  onPressed: () {
                    Future<bool?> future = Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                futureIsrarci("18 yaşından büyük müsün?")));
                    future.then((value) => {
                          // 18 yaşından küçükse tebrikler mesajı bastırılmayacak ve futureIsrarcı clasına yonlendırelecek.
                          if (value == false)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => futureIsrarci(
                                        "18 Yaşından Büyük Olmanız Gereklidir!!!")))
                          else
                            {print("Tebrikler")}
                        });

                    // onaylama ekranından gelen değere gore burası çalaşıcak.
                    future.then((bool? value) => {
                          if (value == true)
                            print("18 yaşından büyük mü ? Cevap: Evet")
                          else
                            {print("18 yaşından büyük mü ? Cevap: Hayır")}
                        });

                    print("Future 2 On Pressed Kısmı");
                  },
                  child: Text("Future2")),
              ElevatedButton(
                  onPressed: () async {
                    //// ASNCY UYGULAMASI RUN TERMINALINDE TAKIP ET

                    print("Markete Gidildi");
                    final String? awaitR = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => awaitFuture()));
                    if (awaitR == "Pizza") {
                      Future.delayed(Duration(seconds: 7), () {
                        print("Pizza Geldi Film İzlemeye Devam...");
                      });
                    } else {
                      Future.delayed(Duration(seconds: 3), () {
                        print("Köfte Geldi Film İzlemeye Devam...");
                      });
                    }

                    print("Film izleniyor");
                  },
                  child: Text("await Future")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FetchingAsync()));
                  },
                  child: Text("Sonraki Projeye geç"))
            ],
          ),
        ));
  }
}

class futureOzellik extends StatelessWidget {
  const futureOzellik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Future"),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text("18 yaşından büyükmüsün"),
              ElevatedButton(

                  // Bir push future variable eklenerek ekrandan dönecek değere göre işlem yapılacak
                  // Push future then kısmı sadece düğmeye basılınca dışındaki print ise her zaman çalışır.
                  // Bu ikisinin çalışması Async olarak gerçekleşir.

                  onPressed: () {
                    Future<bool?> pushFuture = Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                            builder: (context) => futureOzellik2()));
                    pushFuture.then((bool? value) => {
                          if (value == true)
                            print("18 yaşından büyük mü ? Cevap: Evet")
                          else
                            {print("18 yaşından büyük mü ? Cevap: Hayır")}
                        });
                    print("On Pressed Kısmı ");
                  },
                  child: Text("Cevapla")),
            ],
          ),
        ));
  }
}

class futureOzellik2 extends StatelessWidget {
  const futureOzellik2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Future 1 Pop Sayfası"),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text("18 yaşından büyükmüsün"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Evet")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Hayır"))
            ],
          ),
        ));
  }
}

class futureIsrarci extends StatelessWidget {
  futureIsrarci(this.uyari, {Key? key}) : super(key: key);
  String uyari;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Onaylama Ekranı"),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              // Burada eğer hayıra tıklanmışsa parametre olarak gelen uyarı mesajı ekrana basılır.
              // ve tekrar soru sorulur.
              Text(uyari),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Evet")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Hayır"))
            ],
          ),
        ));
  }
}

class awaitFuture extends StatelessWidget {
  const awaitFuture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("awaitFuture"),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Text("Film izlerken,Ne yemeği alalım?"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop("Pizza");
                  },
                  child: Text("Pizza->Sipraiş Süresi 7 sn")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop("Köfte");
                  },
                  child: Text("Köfte->Sipraiş Süresi 7 sn"))
            ],
          ),
        ));
  }
}

// Internetden async olarak veri çekme işlemi gerçekleştirir.

class FetchingAsync extends StatefulWidget {
  const FetchingAsync({Key? key}) : super(key: key);

  @override
  State<FetchingAsync> createState() => _FetchingAsyncState();
}

class _FetchingAsyncState extends State<FetchingAsync> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("FetchingData with Async"),
        ),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => albumPage()));
                  },
                  child: Text("FetchData")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => uploadData()));
                  },
                  child: Text("Upload data")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => manyWidgets()));
                  },
                  child: Text("Sonraki Projeye Geç!")),
            ],
          ),
        ));
  }
}

//  async olarak veri yükleme işlemi gerçekleştirir.

class uploadData extends StatefulWidget {
  const uploadData({Key? key}) : super(key: key);

  @override
  State<uploadData> createState() => _uploadDataState();
}

class _uploadDataState extends State<uploadData> {
  var students = ["Muharrem", "Ayşe", "Ali"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("FetchingData with Async"),
        ),
        body: Container(
          child: Column(
            children: [
              // Burda Yukleme Islemı Manuel Olarak Yapılıyor
              // Baska dosyadan veya başka sayfadaki öğrenciler de yüklenebilir.

              ElevatedButton(
                  onPressed: () async {
                    /*
                    Burda hepsi paralel başlıyor biz tek tek yüklenmesini istiyoruz
                      students.forEach((student) {  print("$student uploaded"); });
                        await Future.delayed(Duration(seconds: 1));
                          print("all students uploaded");*/
                    await Future.forEach(students, (student) async {
                      print("$student uploaded");
                      Future.delayed(Duration(seconds: 2));
                      print("$student yüklendi");
                    });

                    print("all students uploaded");
                  },
                  child: Text("Upload")),
            ],
          ),
        ));
  }
}

class manyWidgets extends StatefulWidget {
  const manyWidgets({Key? key}) : super(key: key);

  @override
  State<manyWidgets> createState() => _manyWidgetsState();
}

enum Cinsiyet { erkek, kadin, bos }

class _manyWidgetsState extends State<manyWidgets> {
  var list = ["Muharrem", "Fatma", "Ayşe"];

  @override
  Widget build(BuildContext context) {
    /* SAYFA DÜZENİ */

    /*


     Safe Area Notchun arkasında app barın arkasında veya ekran yuvarlak olduğunda görünmeme gibi problemleri halleder


    return Scaffold(
      body: SafeArea(
        child: Container(child: Text("Merhaba"),color:Colors.red),
      ),
    );*/

    /*

    EKRANIN SAG ALT KISMINA GELEN FLOATING ACTION BUTTON


    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Uyarı Mesajı")));
        },
        child: Text("Mesaj Göster"),
      ),
    );*/

    /*


    APP BARDA ICON OLUSTURMA


    return Scaffold(
        appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text("Widgets"),
      leading: IconButton(
        icon: Icon(Icons.star),
        onPressed: () {
          print("Star");
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              print("Search");
            },
            icon: Icon(Icons.search)),
        IconButton(
            onPressed: () {
              print("settings");
            },
            icon: Icon(Icons.settings)),
        IconButton(
            onPressed: () {
              print("account_circle_rounded");
            },
            icon: Icon(Icons.account_circle_rounded)),
        TextButton(
            onPressed: () {
              print("Clicked");
            },
            child: Text(
              "Click me!",
              style: TextStyle(color: Colors.orange),
            ))
      ],
    ));


     */

    /*

     DRAWER


    return Scaffold(
      appBar: AppBar(title: Text("Drawer")),
      body: Center(

      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),

              onTap: () {
                // Update the state of the app

                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),

              onTap: () {
                // Update the state of the app

                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),

              onTap: () {
                // Update the state of the app

                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );



     */

    /* İÇERİK DÜZENİ */

    /*

    SIZED BOX ILE PADDING VERME


    return Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final iter in list)
              ...[
                  Text(iter),
                  SizedBox(height: 50,)]
            ],
          ),
        ));

     */

    /*


    PADDING

    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        for (final iter in list) Padding(
          padding: const EdgeInsets.only(top: 4,left: 3) +const EdgeInsets.all(2), // her yerden 2 daha sonra üstten 4 soldan 3 padding eklemesi yapıldı.
          child: Text(iter),
        ),
      ]),
    ));




     */

    //DEKORASYON İŞLEMLERİ
    /*
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Dekarasyon İşlemleri"),
        ),
        body: Align(
          child: Stack(children: [
            Container(

                //ClipRRect in düzgün çalışabilmesi için bu comment edildi.

                // color: Colors.green,
                ),

            //Bulunduğu parentın belirlen yüzdesi kadarını kullanır bu box türü.
            PhysicalModel(
              //color parametresi pyhsical model için zorunludur.
              color: Colors.purple,
              elevation: 40,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: FractionallySizedBox(
                  widthFactor: 0.75,
                  heightFactor: 0.75,
                  child: Container(

                      //Burada bu container kırmızı verirsek Pyhsical Model Widgetiını bozar.
                      //color: Colors.green,

                      ),
                ),
              ),
            )
          ]),
        ));

     */

    // SAYFA DUZENLEME ISLEMLERI

    /*

     */
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("FORM"),
        ),
        body: Center(
            child: Column(children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => myCheckBox()));
              },
              child: Text("Input Elements!")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => myForm()));
              },
              child: Text("FORM !")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Sizing()));
              },
              child: Text("Sonraki Projeye Geç !"))
        ])));
  }
}

class myCheckBox extends StatefulWidget {
  const myCheckBox({Key? key}) : super(key: key);

  @override
  State<myCheckBox> createState() => _myCheckBoxState();
}

class _myCheckBoxState extends State<myCheckBox> {
  @override
  bool? flutterCalisiyorMusun = false;
  Cinsiyet? cinsiyet = Cinsiyet.bos;
  var sehirler = ["istanbul", "ankara", "izmir"];
  String? sehir;
  double boy = 0;
  bool onayladimi = true;

  // GİRDİ ELEMANLARI
  /*
        // TEXT FIELD DIŞINDAKI TUM GIRDI ELEMANLARI STATINI BIZIM TUTMAMIZI ISTIYOR.


   */
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("GIRDI ELEMANLARI"),
      ),
      body: Column(children: [
        Checkbox(
          checkColor: Colors.white,
          value: flutterCalisiyorMusun,
          onChanged: (bool? value) {
            setState(() {
              flutterCalisiyorMusun = value!;
            });
          },
        ),
        Text(" Cevabınız -> " +
            (flutterCalisiyorMusun == false ? "hayir " : "evet")),
        Radio<Cinsiyet>(
            value: Cinsiyet.kadin,
            groupValue: cinsiyet,
            onChanged: (value) {
              setState(() {
                cinsiyet = value;
              });
            }),
        Radio<Cinsiyet>(
            value: Cinsiyet.erkek,
            groupValue: cinsiyet,
            onChanged: (value) {
              setState(() {
                cinsiyet = value;
              });
            }),
        Text("Cinsiyetiniz--> " + cinsiyet.toString()),
        DropdownButton<String>(
            value: sehir,
            items: sehirler
                .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                sehir = value!;
              });
            }),
        Slider(
            value: boy,
            min: 0,
            max: 250.0,
            onChanged: (double value) {
              setState(() {
                boy = value;
              });
            }),
        Text("Boyunuz $boy"),
        Switch(
          // This bool value toggles the switch.
          value: onayladimi,
          activeColor: Colors.red,
          onChanged: (bool? value) {
            // This is called when the user toggles the switch.
            setState(() {
              onayladimi = value!;
            });
          },
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                flutterCalisiyorMusun = false;
                cinsiyet = Cinsiyet.bos;
                sehir = null;
                boy = 0;
              });
            },
            child: Text("Temizle"))
      ]),
    );
  }
}

class myForm extends StatefulWidget {
  const myForm({Key? key}) : super(key: key);

  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {
  @override
  var sehirler = ["istanbul", "ankara", "izmir"];
  String? sehir;
  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("FORM"),
      ),
      body: Center(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (newValue) {
                    print("Form Kaydediliyor $newValue");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen Bir Şeyler Yazın';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                    value: sehir,
                    validator: (value) {
                      {
                        if (!sehirler.contains(value)) {
                          return "Lütfen Sehir Seciniz";
                        }
                      }
                    },
                    onSaved: (newValue) {
                      print("Sehir Kaydedildi -> $newValue");
                    },
                    items: sehirler
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        sehir = value!;
                      });
                    }),
                ElevatedButton(
                  onPressed: () {
                    final gonderimeHazirmi = formKey.currentState?.validate();
                    if (gonderimeHazirmi == true) {
                      print("Uygun");
                      formKey.currentState?.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('İşlem Sürüyor')),
                      );
                    } else {
                      print("Hazır Değil");
                    }
                  },
                  child: const Text('Gönder'),
                ),
              ],
            )),
      ),
    );
  }
}

class Sizing extends StatefulWidget {
  const Sizing({Key? key}) : super(key: key);

  @override
  State<Sizing> createState() => _SizingState();
}

class _SizingState extends State<Sizing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Sizing"),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(children: [
            Transform.rotate(
                angle: pi * 0.2,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Sizing 0.2"),
                )),
            Transform(
                transform: Matrix4.rotationZ(pi * 0.5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Sizing 0.5"),
                )),
            SizedBox(height: 100),
            SizedBox(
                width: 300,
                height: 150,

                // Fitted Box Koymadan Dene;
                child: FittedBox(
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("FittedBox")))),
            SizedBox(height: 50),
            // quarter Turns 0 , 1 , 2 için dene
            RotatedBox(quarterTurns: 1,child: ElevatedButton(onPressed: () {  }, child: Text("RototedBox"),),),
            ElevatedButton(onPressed: (){}, child: Text("RotatedBox Diğer widgetları etkiler"))


            // !!!!!!!!!!!!!!!!!!!!!!!
            //INTRINSC HEIGHT/WIDTH GOSTERILMEDI DOKUMANTASYONDAN KONTROL ET


          ]),
        ));
  }
}
