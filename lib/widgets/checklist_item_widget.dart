import 'package:flutter/material.dart';

class ChecklistItemWidget extends StatefulWidget {
  final String titulo;
  final String prazo;
  final Function(String)? onObservacaoChanged;
  final Function(String)? onStatusChanged;

  const ChecklistItemWidget({
    super.key,
    required this.titulo,
    required this.prazo,
    this.onObservacaoChanged,
    this.onStatusChanged,
  });

  @override
  State<ChecklistItemWidget> createState() => _ChecklistItemWidgetState();
}

class _ChecklistItemWidgetState extends State<ChecklistItemWidget> {
  String? _statusSelecionado;
  final TextEditingController _obsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título do item e prazo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  widget.prazo,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Botões de status
            Row(
              children: ['OK', 'NOK', 'NA'].map((status) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ChoiceChip(
                    label: Text(status),
                    selected: _statusSelecionado == status,
                    onSelected: (selected) {
                      setState(() {
                        _statusSelecionado = selected ? status : null;
                      });
                      if (widget.onStatusChanged != null) {
                        widget.onStatusChanged!(_statusSelecionado ?? '');
                      }
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            // Campo de observação se for NOK
            if (_statusSelecionado == 'NOK')
              TextField(
                controller: _obsController,
                onChanged: widget.onObservacaoChanged,
                decoration: const InputDecoration(
                  labelText: 'Observação',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            const SizedBox(height: 8),
            // Botão de foto (placeholder)
            OutlinedButton.icon(
              onPressed: () {
                // Aqui vamos implementar o picker de imagem depois
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Adicionar Foto'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _obsController.dispose();
    super.dispose();
  }
}
