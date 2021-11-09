import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:social_distance_reminder/discover_view.dart';
import 'package:social_distance_reminder/settings_view.dart';

class AppThemes {
  static const int lightBlue = 0;
  static const int lightRed = 1;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.lightBlue: ThemeData(primarySwatch: Colors.blue),
    AppThemes.lightRed: ThemeData(primarySwatch: Colors.red),
  },
  fallbackTheme: ThemeData
      .light(), // optional fallback theme, default value is ThemeData.light()
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        themeCollection: themeCollection,
        builder: (context, theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
          // _currentIndex == 1
          //     ? DynamicTheme.of(context)!.setTheme(AppThemes.lightRed)
          //     : DynamicTheme.of(context)!.setTheme(AppThemes.lightBlue);
        },
        children: const [DiscoverView(), SettingsView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
