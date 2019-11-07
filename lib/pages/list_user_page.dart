

import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/providers/db_provider.dart';

class ListUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: DBProvider.db.listaUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot)
      {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == 0) {
          return Center(
            child: Text(
              'No hay usuarios registrados',
              style: TextStyle(fontSize: 28.0, color: Colors.red),
            ),
          );
        }
        return ListView(
          children: _listaMapUsers(context, snapshot.data),
        );
      },
    );
//    return ListView(
//      children: _listaMapUsers(context),
//    );
  }

  List<Widget> _listaMapUsers(BuildContext context, List<User> users) {
    return users.map((user) {
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.redAccent,
        ),
        onDismissed: (direction) {
          //DBProvider.db.deleteUserById(user.id);
        },
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text(user.nombre),
              subtitle: Text('CI: ${user.ciudad}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, 'user_details', arguments: 'user');
              },
            ),
            Divider(
              thickness: 2.0,
              color: Colors.lightBlue,
              indent: 70.0,
              endIndent: 20.0,
            )
          ],
        ),
      );
    }).toList();

//    return usersG.getUsers().map((user) {
//      return Column(
//        children: <Widget>[
//          ListTile(
//            leading: Icon(Icons.perm_identity),
//            title: Text(user['nombre']),
//            subtitle: Text(user['ciudad']),
//            trailing: Icon(Icons.arrow_forward_ios),
//            onTap: () {
//              Navigator.pushNamed(context, 'user_details', arguments: 'user');
//            },
//          ),
//          Divider(
//            thickness: 2.0,
//            color: Colors.lightBlue,
//            indent: 70.0,
//            endIndent: 20.0,
//          )
//        ],
//      );
//    }).toList();
  }
}
