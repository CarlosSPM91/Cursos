import 'Persona.dart';

class Professor extends Persona {
  List<String>? _asignaturas = <String>[];
  final String _idProf;

  Professor({
    required String idProf,
    required List<String> asignaturas,
    required dni,
    required nombre,
    required edad,
  }) :_idProf=idProf, _asignaturas=asignaturas, super.conNombre(dni: dni, nombre: nombre, edad: edad);

  void printProfessor() {
    print(
        'dni: $this.getDni, nombre: $this.getNombre, edad: $this.getEdad, idProf: $this._idProf, Asignaturas: $this.asignaturas');
  }

  String get id => this._idProf;

  List<String> get asignaturas => this.asignaturas;
  
  void setAssignatura(String asignatura) => _asignaturas?.add(asignatura);

  @override
  bool operator ==(Object other) {
    if (other is Professor) {
      return id == other.id && asignaturas == other.asignaturas;
    }
    return false;
  }

  @override
  int get hashCode => _idProf.hashCode + asignaturas.hashCode;
}
