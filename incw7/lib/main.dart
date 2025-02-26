import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: FadingTextAnimation(toggleTheme: _toggleTheme),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final Function(ThemeMode) toggleTheme;

  FadingTextAnimation({required this.toggleTheme});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation Page 1'),
        actions: <Widget>[
          Switch(
            value: isDarkMode,
            onChanged: (isOn) {
              if (isOn) {
                widget.toggleTheme(ThemeMode.dark);
              } else {
                widget.toggleTheme(ThemeMode.light);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Go to Page 2'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SecondRoute(toggleTheme: widget.toggleTheme)),
                );
              },
            ),
            SizedBox(height: 300),
            GestureDetector(
              onTap: toggleVisibility,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                curve: Curves.bounceInOut,
                child: const Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  final Function(ThemeMode) toggleTheme;

  SecondRoute({required this.toggleTheme});

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fading Text Animation Page 2'),
        actions: <Widget>[
          Switch(
            value: isDarkMode,
            onChanged: (isOn) {
              if (isOn) {
                widget.toggleTheme(ThemeMode.dark);
              } else {
                widget.toggleTheme(ThemeMode.light);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Go to Page 1'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 300),
            GestureDetector(
              onTap: toggleVisibility,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                curve: Curves.decelerate,
                child: const Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
