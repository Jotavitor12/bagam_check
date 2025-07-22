import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../data/models.dart';
import '../../core/utils/pdf_generator.dart';
import '../../core/utils/email_helper.dart';

class ResumoEnvioScreen extends StatelessWidget {
  final String placaCavalo;
  final String placa1Semireboque;
  final List<Grupo> grupos;
  final String nomeMotorista;
  final Uint8List? assinaturaMotorista;
  final Uint8List? assinaturaOperador;

  const ResumoEnvioScreen({
    super.key,
    required this.placaCavalo,
    required this.placa1Semireboque,
    required this.nomeMotorista,
    required this.grupos,
    this.assinaturaMotorista,
    this.assinaturaOperador,
  });

  void _enviarChecklist(BuildContext context) async {
    final pdf = await PdfGenerator.generateChecklistPdf(
      nomeMotorista,
      placaCavalo,
      grupos,
      assinaturaMotorista,
      assinaturaOperador,
    );

    final nokResumo = grupos.expand((g) => g.itens).where((i) => i.status == 'NOK').map((i) {
      return '- ${i.nome} (Obs: ${i.observacao ?? "Sem observação"})';
    }).join('\n');

    final body = '''
Checklist realizado para veículo $placaCavalo / $placa1Semireboque

Itens NÃO CONFORMES:
$nokResumo
''';

    await EmailHelper.enviarChecklist(
      body: body,
      pdfAnexo: pdf,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checklist enviado com sucesso!')),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final nokItems = grupos.expand((g) => g.itens).where((i) => i.status == 'NOK').toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo e Envio')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Placa Cavalo: $placaCavalo'),
            Text('Placa 1º SR: $placa1Semireboque'),
            const SizedBox(height: 16),
            const Text('Itens Não Conformes:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: nokItems.isEmpty
                  ? const Text('Nenhum item marcado como NOK.')
                  : ListView.builder(
                itemCount: nokItems.length,
                itemBuilder: (context, index) {
                  final item = nokItems[index];
                  return ListTile(
                    title: Text(item.nome),
                    subtitle: item.observacao != null ? Text(item.observacao!) : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _enviarChecklist(context),
              icon: const Icon(Icons.send),
              label: const Text('Enviar Checklist por E-mail'),
            ),
          ],
        ),
      ),
    );
  }
}
