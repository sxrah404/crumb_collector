import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CrumbCollectorApp(),
    ),
  );
}

class CrumbCollectorApp extends StatefulWidget {
  const CrumbCollectorApp({super.key});

  @override
  State<CrumbCollectorApp> createState() => _CrumbCollectorAppState();
}

class _CrumbCollectorAppState extends State<CrumbCollectorApp> {
  int _crumbs = 0;
  int _crumbsPerClick = 1;

  void _collectCrumbs() {
    setState(() {
      _crumbs += _crumbsPerClick;
    });
  }

  void _reset() {
    setState(() {
      _crumbs = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final resetButton = ElevatedButton(
      onPressed: _reset,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.brown,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      child: const Text('RESET', style: TextStyle(color: Colors.white)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Text(
                '$_crumbs Crumbs',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 60),

              SizedBox(
                width: double.infinity,
                height: 80,
                child: ElevatedButton(
                  onPressed: _collectCrumbs,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('COLLECT CRUMB'),
                ),
              ),

              const SizedBox(height: 16),
              SizedBox(width: double.infinity, height: 50, child: resetButton),
            ],
          ),
        ),
      ),
    );
  }
}
