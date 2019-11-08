

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/db_provider.dart';

class AddUserPage extends StatefulWidget{
  @override
  State createState() => AddUserState();
}


class AddUserState extends State<AddUserPage>{
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _cityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0,left: 10.0),
      child: Center(

        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                  height: 25.0
              ),
              TextFormField(
                controller: _userController,
                maxLength: 30,
                validator: (value){
                  return value.isEmpty ? 'El campo no puede estar vacio' : null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Inserte Nombre'
                ),
              ),
              SizedBox(
                height: 15.0
              ),
              TextFormField(
                controller: _cityController,
                maxLength: 50,
                validator: (value){
                  return value.isEmpty ? 'El campo no puede estar vacio': null;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.location_city),
                  hintText: 'Inserte Ciudad'
                ),
              ),
              SizedBox(height:15.0),
              RaisedButton(
                color: Colors.lightBlue,
                textColor: Colors.white,
                child: Text("Guardar"),
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    User user = User(nombre: _userController.text,ciudad: _cityController.text);
                    DBProvider.db
                        .addUser(user);

                    final snackBar = SnackBar(
                      duration: Duration(milliseconds: 1200),
                      content: Text(
                          'El usuario ${_userController.text} ha sido guardado'),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    _formKey.currentState.reset();
                  }
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}