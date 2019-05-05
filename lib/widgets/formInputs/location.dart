import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_course/domain/album.dart';
import 'dart:convert';
import 'package:flutter_course/widgets/ensureVisibility.dart';
import 'package:map_view/map_view.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as geoLoc;
import '../../domain/locationData.dart';

class LocationInput extends StatefulWidget {

  final Function setLocation;
  final Album album;

  LocationInput(this.setLocation, this.album);

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }

}
  class _LocationInputState extends State<LocationInput> {

    final FocusNode _addressInputFocusNode = FocusNode();
    final TextEditingController _addressInputController = TextEditingController();

    Uri _staticMapUri;
    LocationData _locationData;

    @override
  void initState() {
    _addressInputFocusNode.addListener(this.updateLocation);
    if(widget.album != null){
      getStaticMap(widget.album.location.address, askGoogle:false);
    }
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(this.updateLocation);
    super.dispose();
  }

  void getStaticMap(String address,  {bool askGoogle =true, double lat, double lng}) async {

    if(address.isEmpty){
      setState(() {
        _staticMapUri = null;
      });
      widget.setLocation(null);
      return;
    }

  if(askGoogle){
    final Uri uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {
    'address': address,
    'key': 'AIzaSyAatGRplYt8Uuxp3Syyn7poAi293o6wmrY',
  });
  final http.Response response = await http.get(uri);
  final Map<String, dynamic> decodedResponse = json.decode(response.body);

  final formattedAddress = decodedResponse['results'][0]['formatted_address'];
  final coords = decodedResponse['results'][0]['geometry']['location'];

  _locationData = LocationData(coords['lat'], coords['lng'], formattedAddress);
  }
  else if (lat == null && lng == null){
    _locationData= widget.album.location;
  }
  else {
    _locationData = LocationData(lat, lng, address);
  }

   final StaticMapProvider staticMapProvider = StaticMapProvider('AIzaSyAatGRplYt8Uuxp3Syyn7poAi293o6wmrY');
   final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers([
      Marker('position', 'Position',_locationData.latitude, _locationData.longitude),
    ], center: Location(44.00000, 21.19911),
    width: 500,
    height: 300,
    maptype: StaticMapViewType.roadmap,
    );

    widget.setLocation(_locationData);
    if (mounted) {
      setState(() {
        _staticMapUri = staticMapUri;
        _addressInputController.text= _locationData.address;
      });
    }

  }

  void updateLocation() {
    if(!_addressInputFocusNode.hasFocus){
      getStaticMap(_addressInputController.text);
    }
  }

  Future<String> _getAddress(double lat , double lng) async{
    final url = Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {
    'latlng': '${lat.toString()},${lng.toString()}',
    'key': 'AIzaSyAatGRplYt8Uuxp3Syyn7poAi293o6wmrY',
  });

  final http.Response response = await http.get(url);
  final decodedResponse = json.decode(response.body);

  return decodedResponse['results'][0]['formatted_address'];

  }

  void _getGeoLocation() async{
    final location = geoLoc.Location();
    final currentLocation = await location.getLocation();
    final address = await _getAddress(currentLocation['latitude'], currentLocation['longitude']);

    getStaticMap(address, askGoogle: false, lat: currentLocation['latitude'], lng:currentLocation['longitude'] );
  }

    @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      EnsureVisibleWhenFocused(
        focusNode: _addressInputFocusNode,
        child: TextFormField(
          focusNode: _addressInputFocusNode,
          controller: _addressInputController,
          validator: (String value) {
              if(_locationData == null || value.isEmpty) {
                return "No valid location found";
              }
          },
          decoration: InputDecoration(labelText: 'Address'),

        ),
      ),
      SizedBox(height: 10.0,),
      FlatButton(child:Text("My location"),
      onPressed: _getGeoLocation),
      SizedBox(height: 10.0,),
      _staticMapUri == null ? Container() :Image.network(_staticMapUri.toString(), scale: 0.5,)

    ],);
  }
}
