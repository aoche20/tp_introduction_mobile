import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

Future<http.Response> getUsers(String firsname,String lastname,String mail, String bio , String adresse) {
  return http.post(

    Uri.parse('https://ifri.raycash.net/ifri.postman_collection.json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstname': firsname,
      'lastname': lastname,
      'mail': mail,
      'adresse': adresse,
    }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Introduction mobile '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final _formKey= GlobalKey<FormState>();
  final _birthday = new TextEditingController();
  final _lastName = new TextEditingController();
  final _firstName = new TextEditingController();
  final _tel = new TextEditingController();
  final _mail = new TextEditingController();
  final _adresse = new TextEditingController();
  final _bio= new TextEditingController();

  String? _sexe;
  
  @override
  Widget imageprofile(){
    return Stack(children: [
      CircleAvatar(
        radius: 80.0,
        backgroundImage:  AssetImage("images/user.png",)
          ),
         ],);
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:ListView(children: [
          Column(
            children: [
              Text("Formulaire",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
              SizedBox(height: 15.0,),
              Center(
                child:
                imageprofile(),
              ),
              SizedBox(height: 30.0,),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: _lastName,
                        keyboardType: TextInputType.name,
                        decoration:InputDecoration(
                            hintText: "Quel est votre nom",
                            labelText: "Firstname *"
                        ),
                        validator:(String? v){
                          return(v==null||v=="")? "Ce champ est obligatoire": null;
                        }
                    ),
                    TextFormField(
                        controller: _firstName,
                        keyboardType: TextInputType.name,
                        decoration:InputDecoration(
                            hintText: "Quel est votre prénom",
                            labelText: "Lastname *"
                        ),
                        validator:(String? v){
                          return(v==null||v=="")? "Ce champ est obligatoire": null;
                        }
                    ),
                    TextFormField(
                        controller: _birthday,
                        keyboardType: TextInputType.name,
                        decoration:InputDecoration(
                            hintText: "Quel est votre date d'anniversaire",
                            labelText: "Date d'anniversaire *"
                        ),
                        validator:(String? v){
                          return(v==null||v=="")? "Ce champ est obligatoire": null;
                        }
                    ),
                    DropdownButtonFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: new InputDecoration(
                          hintText: 'Quel est votre sexe',
                          labelText: 'Sexe *',
                        ),
                        value: _sexe,
                        onChanged: (String? v) async{
                          setState(() {
                            _sexe = v;
                          });
                          },
                        items: <String>['Masculin','Feminin'].map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(value:value,
                          child: Text(value,style: TextStyle(color: Colors.black),),
                        );
                        }).toList(),
                        validator: (str) => str==null ? "Ce champ est obligatoire" : null,
                    ),

                    TextFormField(
                        controller: _mail,
                        keyboardType: TextInputType.name,
                        decoration:InputDecoration(
                            hintText: "Quel est votre mail",
                            labelText: "Mail *"
                        ),
                        validator:(String? v){
                          return(v==null||v=="")? "Ce champ est obligatoire": null;
                        }
                    ),
                    TextFormField(
                        controller: _tel,
                        keyboardType: TextInputType.number,
                        decoration:InputDecoration(
                            hintText: "Quel est votre téléphone",
                            labelText: "Téléphone *"
                        ),
                        validator:(String? v){
                          return(v==null||v=="")? "Ce champ est obligatoire": null;
                        }
                    ),
                    TextFormField(
                        controller: _adresse,
                        keyboardType: TextInputType.name,
                        decoration:InputDecoration(
                            hintText: "Quel est votre adresse",
                            labelText: "Adresse *"
                        ),
                        validator:(String? v){
                          return(v==null||v=="")? "Ce champ est obligatoire": null;
                        }
                    ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _bio,
                  decoration: InputDecoration(
                    icon: Icon(Icons.sms),
                    border: UnderlineInputBorder(),
                    hintText: 'Entrer votre bio',
                  ),
                    validator:(String? v){
                      return(v==null||v=="")? "Ce champ est obligatoire": null;
                    }
                ),
                  ],
                ),
              ),
              SizedBox(height: 15.0,),

              ElevatedButton(onPressed:() async{

                if(_formKey.currentState!.validate()){
                  //Enregistrement dans shared preferences
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("lastName", _lastName.text);
                  prefs.setString("firstName", _firstName.text);
                  prefs.setString("telephone", _tel.text);
                  prefs.setString("bio", _bio.text);
                  prefs.setString("birthday", _birthday.text);
                  prefs.setString("mail", _mail.text);
                  prefs.setString("adresse", _adresse.text);

                }
              },
                  child: Text("Valider")
              ),
              SizedBox(height: 15.0,),
            ],
          ),
        ],)


      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
