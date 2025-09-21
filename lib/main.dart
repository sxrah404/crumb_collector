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
        shape: CircleBorder(),
        backgroundColor: Colors.brown,
        padding: EdgeInsets.all(20),
      ),
      child: const Icon(Icons.refresh, color: Colors.white, size: 30),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lvl 1 Crumb Collector: 1/click',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '1 Ant: 1/s',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'Weapon: None',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
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

              const SizedBox(height: 20),

              SizedBox(width: double.infinity, height: 50, child: resetButton),
            ],
          ),
        ),
      ),
    );
  }
}
