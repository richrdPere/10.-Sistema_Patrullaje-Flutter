import 'package:google_maps/app/ui/pages/home/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController {
  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }
}
