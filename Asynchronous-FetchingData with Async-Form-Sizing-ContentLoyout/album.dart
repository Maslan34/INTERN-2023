import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {

  await Future.delayed(Duration(seconds: 2));

  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}



class albumPage extends StatefulWidget {
  const albumPage({super.key});

  @override
  State<albumPage> createState() => _albumPageState();
}

class _albumPageState extends State<albumPage> {
 // late Future<Album> futureAlbum; burdaki late initiliaze etmediğimizde button kısmında hata vericektir
   Future<Album>? futureAlbum;
  @override
  void initState() {
    super.initState();

    // Burda sayfa başladığında hemen fetch işlemi yapar
    //futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              futureAlbum = fetchAlbum();
            });
          }, icon: Icon(Icons.download))

        ],
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {

            // Bu işlem ekran yüklenir yüklenmez fetch yapmasını engellemek için


            if(snapshot.connectionState == ConnectionState.none){
              return Text("Fetch İşlemi Henüz Başlamadı");
            }
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}