
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/menu_items.dart';
import 'package:flutter_crud/pages/add_user_page.dart';
import 'package:flutter_crud/pages/list_user_page.dart';

class HomePage extends StatefulWidget{

  @override
  State createState()=> _HomeState();
}

class _HomeState extends State<HomePage>{

  final _menuItems=[
    MenuItem(Icon(Icons.list),"Lista Usuarios",0),
    MenuItem(Icon(Icons.add),"Agregar Usuario",1),
    MenuItem(Icon(Icons.edit),"Actualizar Usuario",2),
    MenuItem(Icon(Icons.delete),"Borrar Usuario",3),
    MenuItem(Icon(Icons.details),"Detalles Usuario",4),
    MenuItem(Icon(Icons.search),"Buscar Usuario",5)];

    int _seletedPage =0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_menuItems.firstWhere((item)=>item.route == _seletedPage).title}"),
      ),
      drawer: Drawer(
        child:ListView(
          children:_menu(context),
        ) ,
      ),
      body: _getContentWidget(),
      
    );
  }
  
  List<Widget> _menu(BuildContext context) {
    List<Widget> list = List<Widget>();
    list.add(_drawerHeader());

    for(MenuItem item in _menuItems){
      list.add(menuItem(context, item));
    }
    return list;
    
  }

  Widget _drawerHeader(){
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green,Colors.lightGreen])
      ),
      child: Center(
        child: CircleAvatar(
          radius: 60.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
            "https://cdn.pixabay.com/photo/2019/10/30/16/17/roe-4589923_960_720.jpg"),
        ),
      ),
    );
  }

  Widget menuItem(BuildContext context,MenuItem item){
    return ListTile(
    leading: item.icon,
      title: Text(item.title),
      onTap: (){
      setState(() {
        _seletedPage = item.route;
        Navigator.pop(context);
      });
      },
    );
  }

  Widget _getContentWidget(){
    switch(_seletedPage){

      case 1:
        return AddUserPage();

      case 0:
        return ListUserPage();


      default:
        return Center(
          child: Text(
            "Not Fount",
             style: TextStyle(fontSize: 32.0, color: Colors.red )),
        );
    }
  }
}