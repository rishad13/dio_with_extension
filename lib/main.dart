import 'dart:developer';

import 'package:dio_with_extension/network/http_request.dart';
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
      title: 'Dio with extension',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dio with extension'),
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
/// Fetches data from a placeholder API using a GET request and logs the response data.
/// 
/// This method utilizes the `NetworkApiService` to make a GET request to the specified URL.
/// If the request fails, it throws an exception with the failure message.
/// On success, it logs the response data to the console.
  void _getApi() async {
    NetworkApiService apiService = NetworkApiService();
    var response = await apiService.getAPIResponse(
        "https://jsonplaceholder.typicode.com/posts", {}, null);
    if (response.fail != null) {
      throw response.fail!.message;
    } else {
      log(response.success!.response.data.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getApi();
        },
        tooltip: 'get Api',
        child: const Icon(Icons.get_app),
      ),
    );
  }
}
