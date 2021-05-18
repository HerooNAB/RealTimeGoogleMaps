import 'package:client/Models/location_model.dart';
import 'package:client/Services/location_service.dart';
import 'package:client/Views/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LocationModel>(
      create: (_) => LocationService().getStreamData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(), 
        //ThemeData.light(),
        home: SignInView(),
        
        
      ),
    );
  }
}
