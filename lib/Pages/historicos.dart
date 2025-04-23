import 'package:flutter/material.dart';

class Historicos extends StatelessWidget {
  const Historicos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Históricos')),
      body: const Center(child: Text('Aquí van los datos históricos')),
    );
  }
}
