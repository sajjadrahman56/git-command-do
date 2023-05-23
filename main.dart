import 'package:flutter/material.dart';
import 'package:tata/model.dart';

import 'http_call.dart';

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

        primarySwatch: Colors.blue,
      ),
      home: ChuckNorrisJokePage(), //NetworkCall(),
    );
  }
}

 

class ChuckNorrisJokePage extends StatefulWidget {
  @override
  _ChuckNorrisJokePageState createState() => _ChuckNorrisJokePageState();
}

class _ChuckNorrisJokePageState extends State<ChuckNorrisJokePage> {
  String _joke = '';
  String api_name = 'https://api.chucknorris.io/jokes/random';

  Future<void> fetchJoke() async {

    var response = await http.get(Uri.parse(api_name));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        _joke = data['value'];
      });
    } else {
      setState(() {
        _joke = 'Failed to fetch joke.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuck Norris Joke'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchJoke,
              child: Text('Get Joke'),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.yellow,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _joke,
                style: TextStyle(fontSize: 28, color: Colors.red),
                textAlign: TextAlign.center,
              ),),
          ],
        ),
      ),
    );
  }
}
