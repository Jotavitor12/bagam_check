import 'package:flutter/material.dart';
import '../data/models.dart';
import 'checklist_item_widget.dart';

class GrupoWidget extends StatelessWidget {
  final Grupo grupo;
  const GrupoWidget({super.key, required this.grupo});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: grupo.itens.length,
      itemBuilder: (context, index) {
        final item = grupo.itens[index];
        return ChecklistItemWidget(
          item: item,
          onStatusChanged: (status) {
            item.status = status;
          },
        );
      },
    );
  }
}
