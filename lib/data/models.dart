// lib/data/models.dart
import 'dart:typed_data';

class ChecklistItem {
  final String nome;
  String status; // OK / NOK / NA
  String? observacao;
  final String prazoBloqueio;
  Uint8List? foto; // foto do item NOK

  ChecklistItem({
    required this.nome,
    this.status = '',
    this.observacao,
    required this.prazoBloqueio,
    this.foto,
  });
}

class Grupo {
  final String nome;
  final List<ChecklistItem> itens;

  Grupo({required this.nome, required this.itens});
}
