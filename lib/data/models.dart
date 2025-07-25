import 'dart:typed_data';

class ChecklistItem {
  final String nome;
  final String prazoBloqueio;
  String status;
  String? observacao;
  List<Uint8List> fotos; // ✅ Agora é uma lista e nunca será nula

  ChecklistItem({
    required this.nome,
    required this.prazoBloqueio,
    this.status = '',
    this.observacao,
    List<Uint8List>? fotos,
  }) : fotos = fotos ?? []; // ✅ Garante que nunca é nulo
}

class Grupo {
  final String nome;
  final List<ChecklistItem> itens;

  Grupo({
    required this.nome,
    required this.itens,
  });
}
