import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactivemap/Model/StoryClass.dart';
import 'package:interactivemap/Model/StoryRepository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as IMG;

class MapPage extends StatefulWidget {
  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  @override
  StoryRepo storyrepo = new StoryRepo();
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(33.8547, 35.8623), zoom: 8.5, bearing: 10);
  late GoogleMapController _controller;
  List<Story> stories = [];
  List<Marker> allMarkers = [];
  late BitmapDescriptor pinIcon;
  bool Loaded = false;
  bool showPage = false;
  late Story mainStory;

  retrieveStories() async {
    try {
      stories = await storyrepo.getStories();
      // EasyLoading.showSuccess("Stories Loaded");
      mapCreated(_controller);
    } catch (e) {
      EasyLoading.showError("Could not retrieve Stories");
      print(e);
    }
  }

  Future<Uint8List> getBytesFromAsset(String src, int width, int height,
      {int size = 150,
      bool addBorder = true,
      Color borderColor = Colors.black,
      double borderSize = 12,
      Color titleColor = Colors.white,
      Color titleBackgroundColor = Colors.black}) async {
    // Uint8List data = (await NetworkAssetBundle(Uri.parse(src)).load(src))
    //     .buffer
    //     .asUint8List();
    // IMG.Image? img = IMG.decodeImage(data);
    // IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
    //
    // Uint8List rdata = IMG.encodeJpg(resized) as Uint8List;

    //Start
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color;
    final double radius = size / 2;
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        Radius.circular(100)));
    // clipPath.addOval(Rect.fromCircle(center: Offset(radius, radius), radius: radius));

    // clipPath.addRRect(RRect.fromRectAndRadius(
    //     Rect.fromLTWH(0, size * 8 / 10, size.toDouble(), size * 3 / 10),
    //     Radius.circular(100)));
    canvas.clipPath(clipPath);

    final Uint8List imageUint8List =
        await (await NetworkAssetBundle(Uri.parse(src)).load(src))
            .buffer
            .asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect: Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        image: imageFI.image,
        fit: BoxFit.cover);

    if (addBorder) {
      //draw Border
      paint..color = borderColor;
      paint..style = PaintingStyle.stroke;
      paint..strokeWidth = borderSize;
      canvas.drawCircle(Offset(radius, radius), radius, paint);
    }
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final rdata = await _image.toByteData(format: ui.ImageByteFormat.png);
    //End

    setState(() {});
    EasyLoading.showSuccess("Stories Loaded");
    return rdata!.buffer.asUint8List();
  }

  initState() {
    super.initState();
    // setCustomMapPin();
    EasyLoading.show(status: 'Retrieving Stories');
    retrieveStories();
  }

  // void setCustomMapPin() async {
  //   pinIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 2.5),
  //       'assets/images/image-icon.png');
  // }

  //create a global story and scrollable
  //ontap turn bool true to show widget, replace story with ontapped story params

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
      stories.forEach((e) async {
        // var coords = await locationFromAddress(e.location);
        var latlong =  e.location.split(",");
        double latitude = double.parse(latlong[0]);
        double longitude = double.parse(latlong[1].trimLeft());
        allMarkers.add(Marker(
            markerId: MarkerId(e.title + " " + e.date_submitted),
            draggable: false,
            consumeTapEvents: true,
            icon: BitmapDescriptor.fromBytes(
                await getBytesFromAsset(e.featured_image, 100, 100)),
            // infoWindow: InfoWindow(title: e.title),
            position: LatLng(latitude, longitude),
            onTap: () {
              mainStory = e;
              showPage = true;
            }));
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),
        showPage
            ? Expanded(
              child: DraggableScrollableSheet(builder: (context, scrollController) {
                  return SingleChildScrollView(
                      child: Column(
                    children: [Text(mainStory.title)],
                  ));
                }),
            )
            : Container()
      ],
    ));
  }
}
