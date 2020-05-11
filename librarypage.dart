//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:reelhouse/main.dart';
import 'main.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:dio/dio.dart';

class LibraryPage extends StatelessWidget{  
  
  final TextEditingController _filter = new TextEditingController();
  final DBRef = FirebaseDatabase.instance.reference();
  final List movieTitleList = new List();

  Future<List<String>>  getMovies() async{
    DataSnapshot movies =  await DBRef.child("Movies").once();
    var moviesMap = Map<String, dynamic>.from(movies.value);
    List<String> moviesList = [];
    moviesMap.forEach((key, value){
      moviesList.add(key);
    });
    return moviesList;
  }

  Widget _displayPage(){
    return new FutureBuilder(
      future:  getMovies(),
      builder: (context, snapshot) {
        List tempList =  snapshot.data;
        if (tempList == null)
        {
          return Text ('Your Library is Currently Empty', style: TextStyle(fontSize: 20));
        }
        else
        {
          return ListView.builder(
            itemCount: tempList.length,
            itemBuilder: (BuildContext context, int index){
              return new ListTile(
                title: Text(tempList[index]),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LibraryScreen(
                          title: tempList[index], 
                  )));
                },
              );
            }
          );
        }
      }
    );
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
        title: new Text('Your Library',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ), 
    ),
    body: _displayPage(),
  );
  }
}

class LibraryScreen extends StatelessWidget {

  final String title;
  final DBRef = FirebaseDatabase.instance.reference();

  LibraryScreen({Key key, @required this.title  }) : super(key : key);

  Future<List<String>> getMovieDetails(String movieName) async {
    DataSnapshot movies = await DBRef.child("Movies").child(movieName).once();
    var moviesMap = Map<String, dynamic>.from(movies.value);
    List<String> moviesList = [];
    moviesMap.forEach((key, value){
      moviesList.add(value);
    });
    print(moviesList);
    return moviesList;
  }

  Widget _displayLibraryMovie(String movieTitle){
    return new FutureBuilder(
      future: getMovieDetails(movieTitle),
      builder: (context, snapshot) {
        List tempList = snapshot.data;
        print('Length: ${tempList.length}');        
        return new SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Icon(Icons.camera_alt, color: Colors.black,),
            Text(" Camera", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
            Padding(padding: EdgeInsets.fromLTRB(30, 50, 10, 0)),
            Expanded(child: new Text(tempList[12], style: TextStyle(fontSize: 20), textAlign: TextAlign.right,)),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Icon(Icons.device_hub, color: Colors.black,),
            Text(" Acuisition", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.fromLTRB(10, 50, 10, 0)),
            Expanded(child: new Text(tempList[9], style: TextStyle(fontSize: 20,), textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(
            children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
            Icon(Icons.color_lens, color: Colors.black,),
            Text(" Lense", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.fromLTRB(50, 50, 10, 0)),
            Expanded(child: new Text(tempList[11], style: TextStyle(fontSize: 20), textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.create, color: Colors.black,),
            Expanded(child: new Text(" Lense Manufacture", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[1], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.open_with, color: Colors.black,),
            Expanded(child: new Text(" Camera Aperature", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[7], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.speaker, color: Colors.black,),
            Expanded(child: new Text(" Sound System", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[2], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.mail, color: Colors.black,),
            Expanded(child: new Text(" Distributor", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[6], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.store_mall_directory, color: Colors.black,),
            Expanded(child: new Text(" Distributor Medium", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[10], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.edit_attributes, color: Colors.black,),
            Expanded(child: new Text(" Editing System", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[3], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.done, color: Colors.black,),
            Expanded(child: new Text(" Finishing System", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[4], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.done_outline, color: Colors.black,),
            Expanded(child: new Text(" Finishing Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[11], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.camera, color: Colors.black,),
            Expanded(child: new Text(" Capture", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[13], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.aspect_ratio, color: Colors.black,),
            Expanded(child: new Text(" Aspect Ratio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[0], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
          
          Divider(thickness: 1, color: Colors.black),
          Row(children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 50)),
            Icon(Icons.map, color: Colors.black,),
            Expanded(child: new Text(" Shooting Region", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
            //Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
            Expanded(child: new Text(tempList[5], style: TextStyle(fontSize: 20),textAlign: TextAlign.right,),),
          ],),
            ],
          ),
        );
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
        title: new Text(title,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ), 
    ),
    body: _displayLibraryMovie(title),
  );
  }
}