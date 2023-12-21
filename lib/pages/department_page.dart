import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/info_region.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';

class DepartmentPage extends StatelessWidget {
  const DepartmentPage({
    super.key, 
    required this.config, 
    required this.regionName, 
    required this.regionCode}
  );

  final String regionName;
  final String regionCode;
  final Config config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Région: $regionName",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: SlideMenu(config: config, currentPage: config.get('page-name.info-region')),
      body: Flexible(
              child: InfoRegion(config: config, regionName: regionName, regionCode: regionCode),
        )
      
      
      
    );
  }
}