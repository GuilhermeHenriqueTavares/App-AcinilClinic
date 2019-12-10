import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';

class Mapa extends StatefulWidget {
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  double zoomVal = 5.0;
   GlobalKey<State> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMap(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Find Health",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }

  LatLng _center = LatLng(-22.90661752, -47.0593518);
  LatLng _veraCruz = LatLng(-22.9048647, -47.0686417);

  FlutterMap _buildMap() {
    return FlutterMap(
        options: new MapOptions(
          minZoom: 14.0,
          center: _center,
          interactive: true,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/mateuspc/ck0q6d4vq19nl1coidvsj3l0k/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWF0ZXVzcGMiLCJhIjoiY2swcTNpNzFhMDRmcDNsbXE3b2Z3bm1paCJ9.D2upszt5bqYrty2uVgwxbQ",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoibWF0ZXVzcGMiLCJhIjoiY2swcTNpNzFhMDRmcDNsbXE3b2Z3bm1paCJ9.D2upszt5bqYrty2uVgwxbQ',
                'id': 'mapbox.mapbox-streets-v8'
              }),
          new MarkerLayerOptions(markers: _buildMarkersOnMap()),
        ]);
  }

  List<Marker> _buildMarkersOnMap() {
    List<Marker> markers = List<Marker>();

    var marker = Marker(
        width: 80.0,
        height: 80.0,
        point: _veraCruz,
        builder: (context) => Container(
              child: IconButton(
                icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                iconSize: 49.0,
                color: Colors.lightBlueAccent,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return new Column(

                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(FontAwesomeIcons.locationArrow,color: Color(0xFFBDA778),),
                              title: new Text('Av. Andrade Neves, 402', style: TextStyle(fontSize: 18),),
                            ),
                            new ListTile(
                              leading: new Icon(FontAwesomeIcons.clock,color: Color(0xFFBDA778),),
                              title: new Text('Aberto 24 horas',style: TextStyle(fontSize: 18),),
                            ),
                            new ListTile(
                              leading: new Icon(FontAwesomeIcons.weebly,color: Color(0xFFBDA778),),
                              title: new Text('http://www.hospitalveracruz.com.br',style: TextStyle(fontSize: 18),),
                            ),
                            new ListTile(
                              leading: new Icon(FontAwesomeIcons.phoneAlt,color: Color(0xFFBDA778),),
                              title: new Text('(19) 3734-3000',style: TextStyle(fontSize: 18),),
                            ),
                          ],
                        );
                      });
                },
              ),
            ));
    markers.add(marker);

    return markers;
  }
}
