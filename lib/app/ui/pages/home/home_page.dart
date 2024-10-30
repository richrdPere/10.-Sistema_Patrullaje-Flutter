import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/pages/home/home_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart'; // Paquete para solicitar permisos

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  final _initialCameraPosition = const CameraPosition(
    target: LatLng(-13.540366, -71.982942),
    zoom: 11,
  );

  bool _locationPermissionGranted =
      false; // Variable para verificar el permiso de ubicación

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(); // Solicitar permiso al iniciar
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location
          .request(); // Solicitar permiso si está denegado
    }

    // Actualiza el estado si el permiso está concedido
    if (status.isGranted) {
      setState(() {
        _locationPermissionGranted = true;
      });
    } else {
      // Puedes mostrar un mensaje al usuario si el permiso fue denegado
      // print("Permiso de ubicación denegado.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _controller.onMapCreated,
        // onMapCreated: (GoogleMapController controller) {
        //   controller
        //       .setMapStyle(null); // Para evitar conflictos de renderización
        // },
        myLocationEnabled:
            _locationPermissionGranted, // Habilitado solo si el permiso está concedido
        myLocationButtonEnabled: _locationPermissionGranted,
      ),
    );
  }
}
