import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quizu/helpers/db_helper.dart';
import 'package:quizu/helpers/secure_storage.dart';
import 'package:quizu/presentaion/home_pages/home_screen.dart';
import 'package:quizu/presentaion/login/login_screen.dart';
import 'package:quizu/presentaion/login/otp_screen.dart';
import 'package:quizu/presentaion/resources/theme_manager.dart';
import 'package:quizu/presentaion/spalsh_screen/splash_screen.dart';
import 'package:quizu/providers/login_provider.dart';
import 'package:quizu/providers/quiz_provider.dart';
import 'package:quizu/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SecureStorageHelper.secureStoreageHelper.init();
  await DbHelper.dbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<LoginProvider>(
                create: (context) => LoginProvider(),
              ),
              ChangeNotifierProvider<QuizProvider>(
                create: (context) => QuizProvider(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: getApplicationTheme(),
              navigatorKey: AppRouter.navKey,
              home: SplashScreen(),
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                });
              },
            ),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
