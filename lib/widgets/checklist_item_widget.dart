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

  @override
  void initState() {
    super.initState();
    statusSelecionado = widget.item.status.isEmpty ? null : widget.item.status;
  }

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final imagem = await picker.pickImage(source: ImageSource.camera);
    if (imagem != null) {
      final bytes = await imagem.readAsBytes();
      setState(() {
        widget.item.fotos.add(bytes); // ✅ Agora armazena várias fotos
      });
    }
  }

  void _abrirFoto(Uint8List foto) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Image.memory(foto),
      ),
    );
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
                ],
              ),
              if (widget.item.fotos.isNotEmpty)
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.item.fotos.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final foto = widget.item.fotos[index];
                      return GestureDetector(
                        onTap: () => _abrirFoto(foto),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            foto,
                            width: 100,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
