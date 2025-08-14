import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        // Notice that the counter didn't reset back to zero; the application

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  //controller
  final _nameEditingCtrl = TextEditingController();
  final _emailEditingCtrl = TextEditingController();

  Future<void> _loadProfile() async{
    final prefs = await SharedPreferences.getInstance();
    _nameEditingCtrl.text = prefs.getString('name')?? "";
    _emailEditingCtrl.text = prefs.getString('email')?? "";

  }
  Future<void> _updateProfile() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameEditingCtrl.text);
    prefs.setString('email', _emailEditingCtrl.text);
}
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailEditingCtrl.dispose();
    _nameEditingCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameEditingCtrl,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Name'
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailEditingCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email'
              ),

            ),
            const Expanded(child: SizedBox()),
            ElevatedButton(onPressed:(){
              _updateProfile();
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile info updated'))
              );
            },
            child: Text('Save'))
          ],

        ),
      ),
    );
  }
}
