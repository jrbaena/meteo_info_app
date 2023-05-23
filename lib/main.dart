import 'package:flutter/material.dart';
import 'package:meteo_info_app/dashboard/dashboard.dart';

import 'municipalities/repository/municipalities_repository_impl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeteoFlutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("MeteoFlutter")),
        body: FutureBuilder(
          future: MunicipalitiesRepositoryImpl().fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error?.toString() ?? "");
            }
            if (snapshot.hasData) {
              MunicipalitiesRepositoryImpl.municipalities = snapshot.data ?? [];
              return const Dashboard();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
