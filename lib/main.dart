import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:pagination/view/home_page.dart';
import 'package:pagination/vm/vm_pagination.dart';
import 'package:provider/provider.dart';
import 'app_constant/offline_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VMPagination(),
        ),
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
              return HomePage();
            } else {
              return OfflineScreen();
            }
          },
        ),
      ),
    );
  }
}
