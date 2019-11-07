
class User{
  int id;
  String nombre, ciudad;

  //contructor que recibe los valores separados
  User({this.id, this.nombre,this.ciudad});

  //constructor que recibe los valores como map
  User.fromMap(Map<String,dynamic> map){
    id = map['id'];
    nombre = map['nombre'];
    ciudad = map['ciudad'];
  }

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'nombre':nombre,
      'ciudad':ciudad
    };
  }

}