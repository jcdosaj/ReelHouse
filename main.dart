import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:reelhouse/librarypage.dart';
//import 'package:flutter/foundation.dart';
import 'librarypage.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reel House',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  
  @override
  _ExamplePageState createState() => new _ExamplePageState();
  final String finalTitle = '';
}

class _ExamplePageState extends State<ExamplePage> {

   
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search' );


  // Data Variables
  String title;
  String acuisition;
  String cameras;
  String lenses;
  String lensManu;
  String cameraAp;
  String soundSys;
  String distribute;
  String distributeMed;
  String editingSystem;
  String finishingSystem;
  String finishMethod;
  String capture;
  String distributeAR;
  String shootingRegion;

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new IconButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));},
              icon: new Icon(Icons.search)
              ), 
            title: new Text('Search'),
            ),
          BottomNavigationBarItem(
            icon: new IconButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LibraryPage()));},
              icon: new Icon(Icons.video_library)
              ), 
            title: new Text("Library"),
            ),
        ],
        ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['title'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['title'].toString()),
        
          onTap: () {
            changePage(
              filteredNames[index]['title'].toString(),
              filteredNames[index]['cameras'].toString(),
              filteredNames[index]['acuisition'].toString(),
              filteredNames[index]['lenses'].toString(),
              filteredNames[index]['lens manufacturer'].toString(),
              filteredNames[index]['camera aperature'].toString(),
              filteredNames[index]['sound system'].toString(),
              filteredNames[index]['distributors'].toString(),
              filteredNames[index]['distribution medium'].toString(),
              filteredNames[index]['editing system'].toString(),
              filteredNames[index]['finishing system'].toString(),
              filteredNames[index]['finishing method'].toString(),
              filteredNames[index]['capture - codec & formats'].toString(),
              filteredNames[index]['distributed aspect ratio'].toString(),
              filteredNames[index]['shooting region'].toString(),
              );
            },
        );
      },
    );
  }


  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( ' Search ' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('https://api.agenty.com/v1/jobs/639522/result?apikey=607d960b176bc48fee26ffc4c994bd18&collection=1');
    List tempList = new List();
    for (int i = 0; i < response.data['result'].length; i++) {
      tempList.add(response.data['result'][i]);
    }
    setState(() {
      names = tempList;
      //names.shuffle();
      filteredNames = names;
    });
  }

  void changePage(
    String title, 
    String camera,
    String acuisition,
    String lenses,
    String lensManu,
    String cameraAp,
    String soundSys,
    String distribute,
    String distributeMed,
    String editingSystem,
    String finishingSystem,
    String finishMethod,
    String caputre,
    String distributeAR,
    String shootingRegion,
    )
  {
    print(title);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen(
      text: title, 
      camera: camera, 
      acuisition: acuisition,
      lenses: lenses,
      lensManu: lensManu,
      cameraAp: cameraAp,
      soundSys: soundSys,
      distribute: distribute,
      distributeMed: distributeMed,
      editingSystem: editingSystem,
      finishingSystem: finishingSystem,
      finishMethod: finishMethod,
      capture: caputre,
      distributeAR: distributeAR,
      shootingRegion: shootingRegion
      ,)
    ,)
  );
    return null;
  }

}


class SecondScreen extends StatelessWidget {
  
  final String text;
  final String camera;
  final String acuisition;
  final String lenses;
  final String lensManu;
  final String cameraAp;
  final String soundSys;
  final String distribute;
  final String distributeMed;
  final String editingSystem;
  final String finishingSystem;
  final String finishMethod;
  final String capture;
  final String distributeAR;
  final String shootingRegion;

  SecondScreen({Key key, @required 
    this.text, 
    this.camera, 
    this.acuisition, 
    this.lenses,
    this.lensManu,
    this.cameraAp,
    this.soundSys,
    this.distribute,
    this.distributeMed,
    this.editingSystem,
    this.finishingSystem,
    this.finishMethod,
    this.capture,
    this.distributeAR,
    this.shootingRegion
      }) : super(key: key);

  final DBRef = FirebaseDatabase.instance.reference();

  void writeData()
  {
    DBRef.child('Movies').child(text).set({
      'Camera' : camera,
      'Acuisition' : acuisition,
      'Lense' : lenses,
      'LensManu' : lensManu,
      'CameraAp' : cameraAp,
      'SoundSys' : soundSys,
      'Distribute' : distribute,
      'DistributeMed' : distributeMed,
      'Editing' : editingSystem,
      'FinishSys' : finishingSystem,
      'FinishMeth' : finishMethod,
      'Capture' : capture,
      'DistributeAR' : distributeAR,
      'ShootingRegion' : shootingRegion,
    });
  }

  @override
   Widget build(BuildContext context){
    return new Scaffold(
       bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: new IconButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));},
              icon: new Icon(Icons.search)
              ), 
            title: new Text('Search'),
            ),
          BottomNavigationBarItem(
            icon: new IconButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));},
              icon: new Icon(Icons.video_library)
              ), 
            title: new Text("Library"),
            ),
        ],
        ),
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(text,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ), 
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            splashColor: Colors.orange,
            color: Colors.white70,
            textColor: Colors.white,
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFFFF872C),
                    Color(0xFFFFA12C),
                    Color(0xFFFF872C),
                  ]
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: const Text('Save to Library',
                style: TextStyle(fontSize: 20),
                ),
              ),
            onPressed: () {              
                writeData();
                },
              ),


          //                                           //
          //                                           //
          //                                           //  
          //   STATIC ROWS FOR SPECIFICATION DISPLAY   //
          //                                           //    
          //                                           //
          //                                           //


          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Icon(Icons.camera_alt, color: Colors.black,),
            Text(" Camera", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
            Padding(padding: EdgeInsets.fromLTRB(30, 50, 10, 0)),
            Expanded(child: new Text(camera, style: TextStyle(fontSize: 20), textAlign: TextAlign.right,)),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Icon(Icons.device_hub, color: Colors.black,),
            Text(" Acuisition", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.fromLTRB(10, 50, 10, 0)),
            Expanded(child: new Text(acuisition, style: TextStyle(fontSize: 20,), textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(
            children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Icon(Icons.color_lens, color: Colors.black,),
            Text(" Lense", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.fromLTRB(50, 50, 10, 0)),
            Expanded(child: new Text(lenses, style: TextStyle(fontSize: 20), textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.create, color: Colors.black,),
            Expanded(child: new Text(" Lense Manufacture", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(lensManu, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.open_with, color: Colors.black,),
            Expanded(child: new Text(" Camera Aperature", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(cameraAp, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.speaker, color: Colors.black,),
            Expanded(child: new Text(" Sound System", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(soundSys, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.mail, color: Colors.black,),
            Expanded(child: new Text(" Distributor", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(distribute, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.store_mall_directory, color: Colors.black,),
            Expanded(child: new Text(" Distributor Medium", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(distributeMed, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.edit_attributes, color: Colors.black,),
            Expanded(child: new Text(" Editing System", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(editingSystem, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.done, color: Colors.black,),
            Expanded(child: new Text(" Finishing System", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(finishingSystem, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.done_outline, color: Colors.black,),
            Expanded(child: new Text(" Finishing Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(finishMethod, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.camera, color: Colors.black,),
            Expanded(child: new Text(" Capture", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(capture, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.aspect_ratio, color: Colors.black,),
            Expanded(child: new Text(" Aspect Ratio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(distributeAR, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.map, color: Colors.black,),
            Expanded(child: new Text(" Shooting Region", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(shootingRegion, style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
        ],
      ),
    )
  );  
  }
}

