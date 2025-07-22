class ChecklistItem {
  final String nome;
  String status; // OK / NOK / NA
  String? observacao;
  final String prazoBloqueio;

  ChecklistItem({
    required this.nome,
    this.status = '',
    this.observacao,
    required this.prazoBloqueio,
  });
}

class Grupo {
  final String nome;
  final List<ChecklistItem> itens;

  Grupo({required this.nome, required this.itens});
}