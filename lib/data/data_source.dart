import 'models.dart';

List<Grupo> carregarGruposPadrao() {
  return [
    Grupo(
      nome: 'Grupo 1',
      itens: [
        ChecklistItem(nome: 'Vidros fechados e Chave geral desligada?', prazoBloqueio: 'Imediato'),
        ChecklistItem(nome: 'Freio de mão acionado e chave no porta chave?', prazoBloqueio: 'Imediato'),
        ChecklistItem(nome: 'Cabo terra conectado?', prazoBloqueio: 'Imediato'),
        ChecklistItem(nome: 'Escotilhas abertas?', prazoBloqueio: 'Imediato'),
      ],
    ),
    Grupo(
      nome: 'Grupo 2',
      itens: [
        ChecklistItem(nome: 'Balde(s) aterrados?', prazoBloqueio: '24 horas'),
        ChecklistItem(nome: 'Verificada existência de remanescentes?', prazoBloqueio: '24 horas'),
        ChecklistItem(nome: 'Produto, volume e compartimento conferido?', prazoBloqueio: 'Imediato'),
      ],
    ),
  ];
}
