import 'dart:io';

class ChecklistItem {
  final String nome;
  final String prazoBloqueio;
  String status;
  String? observacao;
  File? foto;

  ChecklistItem({
    required this.nome,
    required this.prazoBloqueio,
    this.status = '',
    this.observacao,
    this.foto,
  });
}

class Grupo {
  final String nome;
  final List<ChecklistItem> itens;

  Grupo({
    required this.nome,
    required this.itens,
  });
}
