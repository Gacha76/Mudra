import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';

class MapMarker {
  final String? image;
  final String? title;
  final LatLng? location;
  final String? address;
  final int? rating;

  MapMarker({
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
    required this.address,
  });
}

final medical = [
  MapMarker(
      image: 'assets/maps/medplus.png',
      title: 'Medplus Yalakki Shetter Colony',
      address: 'Contact: 8897653248',
      location: LatLng(15.43605850067814, 75.02192527026446),
      rating: 4),
  MapMarker(
      image: 'assets/maps/shiva.png',
      title: 'Shiva Medicals & General Stores',
      address: 'Contact: 9897253248',
      location: LatLng(15.437009946521329, 75.01926451892722),
      rating: 3),
  MapMarker(
      image: 'assets/maps/shiva.png',
      title: 'HEALTH CARE MEDICAL AND GENERAL STORE',
      address: 'Contact: 9125243228',
      location: LatLng(15.439491958641042, 75.01171141825075),
      rating: 4),
  MapMarker(
      image: 'assets/maps/sneha.jpg',
      title: 'Sneha Clinic',
      address: 'Contact: 6326212223',
      location: LatLng(15.397599145234208, 75.00132159948771),
      rating: 2),
  MapMarker(
      image: 'assets/maps/sdmd.png',
      title: 'SDM College of Dental Sciences & Hospital',
      address: 'Contact: 9135243228',
      location: LatLng(15.417879242657511, 75.04074303318959),
      rating: 3),
  MapMarker(
      image: 'assets/maps/sdm.jpg',
      title: 'SDM College of Medical Sciences and Hospital',
      address: 'Contact: 8223223228',
      location: LatLng(15.418681716323594, 75.05018154569872),
      rating: 5),
  MapMarker(
      image: 'assets/maps/mul.png',
      title: 'Mulamuttal Hospital',
      address: 'Contact: 9125243228',
      location: LatLng(
        15.445926916450501,
        75.00305909381967,
      ),
      rating: 3),
  MapMarker(
      image: 'assets/maps/rc.png',
      title: 'Rc hiremath medical Store',
      address: 'Contact: 8325243527',
      location: LatLng(15.399582770730097, 75.0025755240634),
      rating: 4),
  MapMarker(
      image: 'assets/maps/shri.png',
      title: 'Shrinidhi medical store',
      address: 'Contact: 8652243328',
      location: LatLng(15.412778195764567, 75.04190551988742),
      rating: 5),
  MapMarker(
      image: 'assets/maps/medplus.png',
      title: 'Shri Annupurna medicals Store',
      address: 'Contact: 7435633529',
      location: LatLng(
        15.418422828993426,
        75.0476911025154,
      ),
      rating: 2),
  MapMarker(
      image: 'assets/maps/mul.png',
      title: 'Vijaylakshmi medical and general Store',
      address: 'Contact: 7135546327',
      location: LatLng(
        15.434549507465457,
        75.00858613962588,
      ),
      rating: 3),
  MapMarker(
    image: 'assets/maps/shri.png',
    title: 'Shri Bheeem Ambika Medicals',
    address: 'Contact: 9125243228',
    location: LatLng(15.435803947896527, 75.0091427136022),
    rating: 4,
  ),
];

class AppConstants {
  static const String mapBoxAccessToken =
      'pk.eyJ1Ijoidml2YWFuMjAwMyIsImEiOiJjbGZqYXpyNGQ0cmlzM3ludHF5bXRkMmplIn0.wIbS3JVNZOpAF00dogMmHA';

  static const String mapBoxStyleId = 'clh8o2vjx00xe01qy0024elpu';

  static final myLocation = LatLng(15.392543505030979, 75.02528508513441);
}

class MapBox_hospital extends StatefulWidget {
  const MapBox_hospital({super.key});

  @override
  State<MapBox_hospital> createState() => _MapBoxState_hospital();
}

class _MapBoxState_hospital extends State<MapBox_hospital>
    with TickerProviderStateMixin {
  LocationData? _currentLocation;
  final Location _location = Location();

  Future<void> _getCurrentLocation() async {
    try {
      _currentLocation = await _location.getLocation();
    } catch (e) {
      print('Could not get the location: $e');
    }
  }

  int selectedIndex = 0;
  final PageController pageController = PageController();
  ScrollController _controller = ScrollController();
  var currentLocation = AppConstants.myLocation;

  late final MapController mapController;
  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _controller = ScrollController();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('Maps'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 13,
              center: currentLocation,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/vivaan2003/clh8o2vjx00xe01qy0024elpu/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoidml2YWFuMjAwMyIsImEiOiJjbGZqYXpyNGQ0cmlzM3ludHF5bXRkMmplIn0.wIbS3JVNZOpAF00dogMmHA",
                additionalOptions: {
                  'mapStyleId': AppConstants.mapBoxStyleId,
                  'accessToken': AppConstants.mapBoxAccessToken,
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(15.392084031535996, 75.02574705206158),
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                  for (int i = 0; i < medical.length; i++)
                    Marker(
                        height: 40,
                        width: 30,
                        point: medical[i].location ?? AppConstants.myLocation,
                        builder: (_) {
                          return GestureDetector(
                            onTap: () {
                              pageController.animateToPage(
                                i,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                              selectedIndex = i;
                              setState(() {});
                            },
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 500),
                              scale: selectedIndex == i ? 1 : 0.7,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: selectedIndex == i ? 1 : 0.8,
                                child: SvgPicture.asset(
                                  'assets/maps/blue.svg',
                                ),
                              ),
                            ),
                          );
                        })
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                selectedIndex = value;
                currentLocation =
                    medical[value].location ?? AppConstants.myLocation;
                _animatedMapMove(currentLocation, 11.5);
                setState(() {});
              },
              itemCount: medical.length,
              itemBuilder: (_, index) {
                final item = medical[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color.fromARGB(255, 30, 29, 29),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: item.rating,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? '',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 254, 254, 251)),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      item.address ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item.image ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
