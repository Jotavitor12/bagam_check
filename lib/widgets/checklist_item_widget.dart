import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/models.dart';

class ChecklistItemWidget extends StatefulWidget {
  final ChecklistItem item;
  final void Function(String) onStatusChanged;

  const ChecklistItemWidget({
    super.key,
    required this.item,
    required this.onStatusChanged,
  });

  @override
  State<ChecklistItemWidget> createState() => _ChecklistItemWidgetState();
}

class _ChecklistItemWidgetState extends State<ChecklistItemWidget> {
  late String? statusSelecionado;
  Uint8List? _foto;

  @override
  void initState() {
    super.initState();
    statusSelecionado = widget.item.status.isEmpty ? null : widget.item.status;
    _foto = widget.item.foto;
  }

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final imagem = await picker.pickImage(source: ImageSource.camera);
    if (imagem != null) {
      final bytes = await imagem.readAsBytes();
      setState(() {
        _foto = bytes;
        widget.item.foto = bytes;
      });
    }
  }

  void _abrirFoto() {
    if (_foto != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Image.memory(_foto!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Prazo: ${widget.item.prazoBloqueio}'),
            const SizedBox(height: 12),
            Row(
              children: ['OK', 'NOK', 'N/A'].map((status) {
                return Row(
                  children: [
                    Radio<String>(
                      value: status,
                      groupValue: statusSelecionado,
                      onChanged: (value) {
                        setState(() {
                          statusSelecionado = value;
                          widget.onStatusChanged(value!);
                        });
                      },
                    ),
                    Text(status),
                    const SizedBox(width: 12),
                  ],
                );
              }).toList(),
            ),
            if (statusSelecionado == 'NOK') ...[
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Observação (obrigatória se NOK)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  widget.item.observacao = text;
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: _tirarFoto,
                    icon: const Icon(Icons.camera_alt),
                    tooltip: 'Tirar Foto',
                  ),
                  IconButton(
                    onPressed: _abrirFoto,
                    icon: const Icon(Icons.folder),
                    tooltip: 'Visualizar Foto',
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
