import 'package:flutter/material.dart';

import 'dart:io'; 
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _picker = ImagePicker(); // 1
  File? _photo; // 2

  Future _takePhoto() async { // 3
    final xfile = await _picker.pickImage(source: ImageSource.camera); // 4 
    setState(() {
      if (xfile != null) {
        _photo = File(xfile.path); // 5
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoView = SizedBox( // 写真撮影のビュー
        width: 200,
        height: 200,
        child: _photo == null
            ? const Text("写真撮影のビュー")
            : Image.file(_photo!),
    );

    final body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          photoView, // 写真撮影のビュー
        ],
      )
    );
      
    final fab = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: _takePhoto, // 写真撮影をする関数
          child: const Icon(Icons.photo_camera),
        ),
      ]
    );

    final sc = Scaffold(
      body: body, // ボディー   
      floatingActionButton: fab,     
    );

    return SafeArea(
      child: sc,
    );
  }
}