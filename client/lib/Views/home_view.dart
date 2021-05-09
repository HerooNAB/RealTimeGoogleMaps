import 'package:client/Models/location_model.dart';
import 'package:client/Services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locationModel = Provider.of<LocationModel>(context);
    LocationService.upLoadLocation(
        locationModel.latitude, locationModel.longitude);
    // LocationService.gettset();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text(
              "Vĩ Độ: ${locationModel.latitude}, Kinh Độ: ${locationModel.longitude}"),
        ),
      ),
    );
  }
}
