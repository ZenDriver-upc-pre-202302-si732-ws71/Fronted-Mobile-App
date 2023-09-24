import 'package:flutter/material.dart';
import 'package:zendriver/entities/driver.dart';
import 'package:zendriver/entities/find_driver.dart';
import 'package:zendriver/networking/services/driver_service.dart';
import 'package:zendriver/ui/pages/filtered_driver_item.dart';

class FilteredDrivers extends StatefulWidget {
  const FilteredDrivers({Key? key, this.licenseType, required this.title}) : super(key: key);
  final String? licenseType;
  final String title;

  @override
  State<FilteredDrivers> createState() => _FilteredDriversState();
}

class _FilteredDriversState extends State<FilteredDrivers> {
  List<Driver>? drivers = List.empty();
  final DriverService _driverService = DriverService();

  Future initialize() async {
    List<Driver> result = List.empty();
    if(widget.licenseType == null) {
      result = await _driverService.getAll();
    }
    else {
      result = await _driverService.getByLicenseType(FindDriver(yearsOfExperience: 0, categoryName: widget.licenseType));
    }
    setState(() {
      drivers = result;
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
            itemCount: drivers?.length,
            itemBuilder: (context, index) {
              return DriverItem(driver: drivers![index]);
            },
          )
        ],
      ),
    );
  }
}
