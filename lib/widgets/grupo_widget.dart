import 'package:flutter/material.dart';
import 'checklist_item_widget.dart';
import '../data/models.dart';

class GrupoWidget extends StatelessWidget {
  final Grupo grupo;
  const GrupoWidget({super.key, required this.grupo});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: grupo.itens.length,
      itemBuilder: (context, index) {
        final item = grupo.itens[index];
        return ChecklistItemWidget(
          titulo: item.nome,
          prazo: item.prazoBloqueio,
          onStatusChanged: (status) => item.status = status,
          onObservacaoChanged: (obs) => item.observacao = obs,
        );
      },
    );
  }
}