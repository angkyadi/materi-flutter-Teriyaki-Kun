import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';

class MapDetailScreen extends StatelessWidget {
  final Post post;
  const MapDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lat = Double.tryParse(post.latitude??'');
    final lng = Double.tryParse(post.longitude??'');
    final hasLocation = lat!= null && lng!=null;
    final point = hasLocation? LatLng(lat,lng):const LatLng(0,0);
    return Scaffold(
      appBar: AppBar(
        title: Text(post.category??'Map Detail'),
      ),
      body: hasLocation
      ? FlutterMap(
          options: Map
      ),
    )
  }
}