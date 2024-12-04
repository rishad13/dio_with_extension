import 'dart:developer';
import 'package:dio_with_extension/network/http_request.dart';
import 'package:dio_with_extension/network/parts_and_exceptions/network_response.dart';
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

/// Fetches data from the given API endpoint and logs the response.
///
/// This function makes an asynchronous GET request to the specified URL using
/// the `NetworkApiService`. The response is processed based on whether the
/// request is successful or fails. If successful, the response data is logged.
/// If the request fails, an exception with the error message is thrown.
///
/// Throws:
///   An exception if the API request fails, containing the error message.
  void _getApi() async {
    NetworkApiService apiService = NetworkApiService();
    var response = await apiService.getAPIResponse(
        "https://jsonplaceholder.typicode.com/posts", {}, null);
    response.when(
        onSuccess: (value) => log(value.response.data.toString()),
        onFail: (value) => throw value.message);
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
