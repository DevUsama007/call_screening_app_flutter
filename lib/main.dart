import 'package:call_screening_app/app/view/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class CallBlockerApp extends StatefulWidget {
  const CallBlockerApp({super.key});

  @override
  State<CallBlockerApp> createState() => _CallBlockerAppState();
}

class _CallBlockerAppState extends State<CallBlockerApp> {
  static const platform = MethodChannel('call_blocker_channel');
  bool isBlockingEnabled = false;
  int blockedCount = 0;
  List<String> whitelist = [];

  @override
  void initState() {
    super.initState();
    _loadSettings();
    platform.setMethodCallHandler(_handleNativeCalls);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBlockingEnabled = prefs.getBool('isBlockingEnabled') ?? false;
      blockedCount = prefs.getInt('blockedCount') ?? 0;
      whitelist = prefs.getStringList('whitelist') ?? [];
    });
  }

  Future<void> _toggleBlocking(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => isBlockingEnabled = value);
    await prefs.setBool('isBlockingEnabled', value);
    platform.invokeMethod('setBlockingEnabled', {"enabled": value});
  }

  Future<void> _handleNativeCalls(MethodCall call) async {
    if (call.method == "onCallBlocked") {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        blockedCount++;
      });
      prefs.setInt('blockedCount', blockedCount);
    }
  }

  Future<void> _addWhitelistNumber(String number) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      whitelist.add(number);
    });
    await prefs.setStringList('whitelist', whitelist);
    platform.invokeMethod('updateWhitelist', {"numbers": whitelist});
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text("Call Blocker MVP"))),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text("Enable Blocking"),
                value: isBlockingEnabled,
                onChanged: _toggleBlocking,
              ),
              Text("Blocked calls: $blockedCount"),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Add Whitelist Number",
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    _addWhitelistNumber(controller.text);
                    controller.clear();
                  }
                },
                child: const Text("Add to Whitelis"),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children:
                      whitelist.map((e) => ListTile(title: Text(e))).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
