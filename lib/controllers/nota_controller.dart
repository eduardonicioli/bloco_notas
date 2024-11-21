import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/nota.dart';

abstract class NotaEvent {}

class AdicionarNota extends NotaEvent {
  final Nota nota;
  AdicionarNota(this.nota);
}

class EditarNota extends NotaEvent {
  final Nota nota;
  EditarNota(this.nota);
}

class ExcluirNota extends NotaEvent {
  final String id;
  ExcluirNota(this.id);
}

class CarregarNotas extends NotaEvent {}

abstract class NotaState {}

class NotasCarregadas extends NotaState {
  final List<Nota> notas;
  NotasCarregadas(this.notas);
}

class NotaController extends Bloc<NotaEvent, NotaState> {
  List<Nota> notas = [];

  NotaController() : super(NotasCarregadas([]));

  @override
  Stream<NotaState> mapEventToState(NotaEvent event) async* {
    if (event is CarregarNotas) {
      yield NotasCarregadas(notas);
    } else if (event is AdicionarNota) {
      notas.add(event.nota);
      yield NotasCarregadas(notas);
    } else if (event is EditarNota) {
      int index = notas.indexWhere((nota) => nota.id == event.nota.id);
      if (index != -1) {
        notas[index] = event.nota;
        yield NotasCarregadas(notas);
      }
    } else if (event is ExcluirNota) {
      notas.removeWhere((nota) => nota.id == event.id);
      yield NotasCarregadas(notas);
    }
  }
}
