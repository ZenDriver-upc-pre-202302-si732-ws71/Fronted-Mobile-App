import 'package:flutter/material.dart';
import 'package:zendriver/models/driver_profile.dart';
import 'package:zendriver/services/driver_profile_service.dart';
import 'package:zendriver/ui/pages/filtered_driver_item.dart';

class FilteredDrivers extends StatefulWidget {
  const FilteredDrivers({Key? key, required this.licenseType, required this.operation, required this.title}) : super(key: key);
  final String licenseType;
  final int operation;
  final String title;

  @override
  State<FilteredDrivers> createState() => _FilteredDriversState();
}

class _FilteredDriversState extends State<FilteredDrivers> {
  List<DriverProfile>? profiles;
  DriverProfileService httpHelper = DriverProfileService();

  Future initialize() async {
    profiles = List.empty();
    if(widget.operation == 0){
     profiles = await httpHelper.getProfiles(widget.licenseType);
    }
    else if (widget.operation == 1){
      profiles = await httpHelper.getAllProfiles();
    }
    setState(() {
      profiles = profiles;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: profiles?.length,
            itemBuilder: (context, index) {
              return DriverItem(driverProfile: profiles![index]);
            },
          )
        ],
      ),
    );
  }
}
