import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setWindowSize(const Size(500, 800));
  }
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: CrumbCollectorApp()),
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
  int _skillLevel = 1;
  int _skillUpgradeCost = 10;
  int _antCount = 0;
  int _antHireCost = 20;
  int _crumbsPerSecond = 0;
  int _weaponLevel = 0;
  int _weaponUpgradeCost = 20;
  List<String> _weapons = ['None', 'Rock', 'Stick', 'GUN'];
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_antCount > 0) {
        setState(() {
          _crumbs += _antCount;
          _crumbsPerSecond = _antCount.toInt();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _collectCrumbs() {
    setState(() {
      _crumbs += _crumbsPerClick;
    });
  }

  void _upgradeSkill() {
    if (_crumbs >= _skillUpgradeCost) {
      setState(() {
        _crumbs -= _skillUpgradeCost;
        _skillLevel++;
        _crumbsPerClick++;
        _skillUpgradeCost = (_skillUpgradeCost * 1.5).round();
      });
    }
  }

  void _hireAnt() {
    if (_crumbs >= _antHireCost) {
      setState(() {
        _crumbs -= _antHireCost;
        _antCount++;
        _antHireCost = (_antHireCost * 1.5).round();
      });
    }
  }

  void _upgradeWeapon() {
    if (_crumbs >= _weaponUpgradeCost && _weaponLevel < 3) {
      setState(() {
        _crumbs -= _weaponUpgradeCost;
        _weaponLevel++;
        _weaponUpgradeCost = (_weaponUpgradeCost * 2).round();
      });
    }
  }

  void _reset() {
    setState(() {
      _crumbs = 0;
      _crumbsPerClick = 1;
      _skillLevel = 1;
      _skillUpgradeCost = 10;
      _antCount = 0;
      _antHireCost = 20;
      _crumbsPerSecond = 0;
      _weaponLevel = 0;
      _weaponUpgradeCost = 20;
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
      child: const Icon(Icons.refresh, color: Colors.white, size: 24),
    );

    TextStyle statsText = GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );

    TextStyle upgradeText = GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );

    TextStyle upgradeCostText = GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Text(
                '$_crumbs Crumbs',
                style: GoogleFonts.montserrat(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lvl $_skillLevel Crumb Collector: $_crumbsPerClick crumb${_crumbsPerClick == 1 ? '' : 's'}/click',
                    style: statsText,
                  ),
                  Text(
                    '$_antCount Ant${_antCount == 1 ? '' : 's'}: $_crumbsPerSecond crumb/s',
                    style: statsText,
                  ),
                  Text('Weapon: ${_weapons[_weaponLevel]}', style: statsText),
                ],
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 300,
                height: 80,
                child: ElevatedButton(
                  onPressed: _collectCrumbs,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    textStyle: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: const Text('COLLECT CRUMB'),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 80,
                child: ElevatedButton(
                  onPressed: _crumbs >= _skillUpgradeCost
                      ? _upgradeSkill
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Upgrade Skill', style: upgradeText),
                      Text(
                        '($_skillUpgradeCost Crumbs)',
                        style: upgradeCostText,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 80,
                child: ElevatedButton(
                  onPressed: _crumbs >= _antHireCost ? _hireAnt : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hire Ant', style: upgradeText),
                      Text('($_antHireCost Crumbs)', style: upgradeCostText),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 80,
                child: ElevatedButton(
                  onPressed: (_crumbs >= _weaponUpgradeCost && _weaponLevel < 3)
                      ? _upgradeWeapon
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Upgrade Weapon', style: upgradeText),
                      Text(
                        '($_weaponUpgradeCost Crumbs)',
                        style: upgradeCostText,
                      ),
                    ],
                  ),
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
