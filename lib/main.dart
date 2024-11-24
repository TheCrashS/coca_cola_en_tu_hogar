import 'package:coca_cola_en_tu_hogar/carrito/Carrito.dart';
import 'package:coca_cola_en_tu_hogar/produc/PantallaLogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
      create: (context) => Carrito(),
      child: const MyApp(),
    )
  //runApp(const MyApp());
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coca-cola en tu Hogar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PantallaLogin(),
    );
  }
}