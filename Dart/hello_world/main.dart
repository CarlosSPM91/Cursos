
///Class for implement first steps on dart language
import 'Professor.dart';

void main() {
  dynamic vary = "juan";
  print(vary.runtimeType);
  vary = 19.0;
  print(vary.runtimeType);

  var name = "Carlos";
  const lastName = "Paredes";

  final username = '$name$lastName/100';
  print(username);
  print(madeName(name, lastName));

  print(DateTime.now());

  List<String> names = ['jis', 'jose', 'jaime', 'jis'];
  names.map((m) => m.toUpperCase()).forEach(print);

  names.add('maria');
  print(names);

  print(names[0].length);
  print(names);

  names.removeWhere((n) => n == 'jis');
  print(names);

  Map<String, String> routes = Map();
  routes['Home'] = '/home';

  print(routes);
  
  //Inicialización parametros con nombre
  Professor professor1 = Professor(idProf: 'CF434', dni: '4267642J', nombre: 'Jose', edad: 23, asignaturas: ['Plastica', 'Geometria']);

  professor1.printProfessor();

  //Record tipe
  final data = getData();
  print(data.name + (data.id).toString());

}

//Funcion Record Type
  ({int id, String name, int nota}) getData(){
    return (id:3,name:'Alfonso',nota:5);
  }

enum MediaType{
  image(101),
  audio(110),
  video(200);

 const MediaType(this.id);
 
 final int id;

}

String madeName(String name, String lastName) {
  return name + lastName;
}
