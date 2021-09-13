import 'dart:convert';

//import 'package:app/function.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

fetchdata(String url) async {
  http.Response response = await http.get(Uri.parse(url), headers: {
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  });
  return response.body;
}

getImage(output) {
  if (output != '') {
    return Image.memory(base64Decode(output.substring(2, output.length - 1)));
  } else {
    return Image.asset('assets/images/transparentImage');
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String url = '';
  String output = '';
  String myvar = '';
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CONVERSION OF TEXT TO IMAGE')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: TextField(
                onChanged: (text) {
                  myvar = text;
                  url = 'http://9848-35-232-27-222.ngrok.io/?query=' +
                      text.toString();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text',
                ),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                ),
              ),
            ),
            /*TextButton(
            onPressed:() async{
                data=await fetchdata(url);
                var decoded=jsonDecode(data);
                setState((){
                output=decoded['output'];
                },
              body: new FutureBuilder(
                future: fetchdata(url),
                builder: (context,snapShot){
                 Map data=snapShot.data;
                 if(snapShot.hasError){
                   print(snapShot.error);
                   return Text('Failed to get response from the server',
                   style: TextStyle(color: Colors.red,
                   fontSize: 22.0
                   ),
                   );
                 }
                 else if(snapShot.hasData)
                 {
                   return new Center(
                     child: new ListView.builder(
                       itemCount: data.length,
                       itemBuilder: (context,index)
                       {
                        return new Column(
                          children: <Widget>[
                            new Padding(padding: const EdgeInsets.all(5,0)),
                            new Container(builder: child: new InkWell(
                              onTap: (){},
                              child: new Image.network(
                                '${data['hits'][index]['largeImageURL']}'
                              ),
                            ),
                            )
                          ],
                        );
                       }
                     ),
                   );
                 }
                 else if(!snapShot.fasData)
                 {
                   return new Center(child: CircularProgressIndicator(),);
                 }
                }
              );
            },*/
            TextButton(
                onPressed: () async {
                  data = await fetchdata(url);
                  var decoded = jsonDecode(data);
                  setState(() {
                    output = decoded["image"];
                  });
                },
                child: Text(
                  'Generate Image',
                  style: TextStyle(fontSize: 20),
                )),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: getImage(output).image, fit: BoxFit.fill),
                ),
              ),
            ),
          ]),
    );
  }
}
