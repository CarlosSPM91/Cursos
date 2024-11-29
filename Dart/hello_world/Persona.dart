abstract class Persona {
  final String dni;
  final String nombre;
  int? edad;


  Persona(
    this.dni,
    this.nombre,
    [this.edad=18]
  );

  Persona.conNombre({
    required this.dni,
    required this.nombre,
    required this.edad,
  });

  get getDni => this.dni;

  get getNombre => this.nombre;


  get getEdad => this.edad;

  set setEdad(value) => this.edad = value;
}
