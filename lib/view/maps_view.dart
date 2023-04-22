import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LocationData? _currentLocation;
  final Location _location = Location();
  final MapController _mapController = MapController();
  final List<Map<String, dynamic>> medicalstores = [
    {
      'name': 'Rc hiremath medical Store',
      'lat': 15.399582770730097,
      'long': 75.0025755240634,
    },
    {
      'name': 'Shrinidhi medical store',
      'lat': 15.412778195764567,
      'long': 75.04190551988742,
    },
    {
      'name': 'Shri Annupurna medicals Store',
      'lat': 15.418422828993426,
      'long': 75.0476911025154,
    },
    {
      'name': 'Vijaylakshmi medical and general Store',
      'lat': -15.434549507465457,
      'long': 75.00858613962588,
    },
    {
      'name': 'Shri Bheeem Ambika Medicals ',
      'lat': 15.435803947896527,
      'long': 75.0091427136022,
    },
    {
      'name': 'Shifa Medicals and General Store',
      'lat': 15.436359445799622,
      'long': 75.01087157063665,
    },
    {
      'name': 'Shree Datta Medicals & General store',
      'lat': 15.434767014503814,
      'long': 75.01771016111256,
    },
    {
      'name': 'HEALTH CARE MEDICAL AND GENERAL STORE',
      'lat': -15.439491958641042,
      'long': 75.01171141825075,
    },
    {
      'name': 'M/s. Vijaylaxmi Medical and General Store',
      'lat': 15.44379404253909,
      'long': 75.01256972524456,
    },
    {
      'name': 'Shiva Medicals & General Stores',
      'lat': 15.437009946521329,
      'long': 75.01926451892722,
    },
    {
      'name': 'Medplus Yalakki Shetter Colony',
      'lat': 15.43605850067814,
      'long': 75.02192527026446,
    },
  ];
  final List<Map<String, dynamic>> hospitals= [
    {
      'name': 'SDM College of Dental Sciences & Hospital',
      'lat': 15.417915911553646,
      'long': 75.04078905982114 ,
    },
    {
      'name': 'SDM College of Medical Sciences and Hospital',
      'lat': 15.41859612733524,
      'long':  75.0501358435967,
    },

    {
      'name': 'THE HUBLI HOSPICE',
      'lat': 15.388265846368038,
      'long': 75.0695079165975,
    },
    {
      'name': 'Mulamuttal Hospital',
      'lat': 15.445926916450501,
      'long': 75.00305909381967,
    },
    {
      'name': 'Shivleea Hospital',
      'lat': 15.44011019182318,
      'long': 74.99507935503387,
    },


  ];
  final List<Map<String, dynamic>> clinics = [
    {
      'name': 'Sneha Clinic',
      'lat': 15.397599145234208,
      'long': 75.00132159948771,
    },
    {
      'name': 'Health and fitness block',
      'lat': 15.39128096727695,
      'long': 75.02571701637359,
    },
  ];
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentLocation = await _location.getLocation();
      if (_currentLocation != null) {
        _mapController.move(
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          15,
        );
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(0, 0),
          zoom: 13,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
           
          
          MarkerLayerOptions(
            markers: _currentLocation == null
                ? []
                : [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      builder: (ctx) => 
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
          ),
          MarkerLayerOptions(
            markers: medicalstores.map((location) {
              return Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(location['lat'], location['long']),
                  builder: (ctx) => Column(
                        children: [
                          Text(
                            location['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 255, 7, 238),
                          ),
                        ],
                      ));
            }).toList(),
          ),
          MarkerLayerOptions(
            markers: clinics.map((location) {
              return Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(location['lat'], location['long']),
                  builder: (ctx) => Column(
                        children: [
                          Text(
                            location['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                        ],
                      ));
            }).toList(),
          ),
          MarkerLayerOptions(
            markers: hospitals.map((location) {
              return Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(location['lat'], location['long']),
                  builder: (ctx) => Column(
                        children: [
                          Text(
                            location['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                        ],
                      ));
            }).toList(),
          )
        ],
      ),
    );
  }
}
