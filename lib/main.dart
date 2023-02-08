import 'package:flutter/material.dart';
import 'play_screen.dart';
import 'loading.dart';
import 'players.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Survival of the Fittest',
      initialRoute: '/home',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/home': (context) => const HomePage(),
        '/playerone': (context) => PlayScreen(player: playerOne),
        '/playertwo': (context) => PlayScreen(player: playerTwo),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: const Center(
            child: Text(
              'Survival of the Fittest',
              style: TextStyle(fontSize: 30),
            ),
          ),
          backgroundColor: Colors.green,
        ),
      ),
      backgroundColor: (Colors.brown),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        //  ========  Play Button
        SizedBox(
          height: 75,
          width: 225,
          child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/playerone');
              },
              child: const Text(
                'Play',
                style: TextStyle(fontSize: 25),
              )),
        ),
        const SizedBox(height: 20),

        //  ========  Game Options Button
        SizedBox(
          height: 75,
          width: 225,
          child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/playertwo');
              },
              child: const Text(
                'Game Options',
                style: TextStyle(fontSize: 25),
              )),
        ),

        //  ========  Settings Button
        const SizedBox(height: 20),
        SizedBox(
          height: 75,
          width: 225,
          child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                overlayColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
              ),
              onPressed: () {},
              child: const Text(
                'Settings',
                style: TextStyle(fontSize: 25),
              )),
        ),
      ])),
    );
  }
}
