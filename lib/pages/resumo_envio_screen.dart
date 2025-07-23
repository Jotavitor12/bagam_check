import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../data/models.dart';
import '../../core/utils/pdf_generator.dart';
import '../../core/utils/email_helper.dart';

class ResumoEnvioScreen extends StatelessWidget {
  final String placaCavalo;
  final String placaCadastrada;
  final String nomeMotorista;
  final String r3;
  final String transportadora;
  final String nomeOperador;
  final List<Grupo> grupos;
  final Uint8List? assinaturaMotorista;
  final Uint8List? assinaturaOperador;

  const ResumoEnvioScreen({
    super.key,
    required this.placaCavalo,
    required this.placaCadastrada,
    required this.nomeMotorista,
    required this.r3,
    required this.transportadora,
    required this.nomeOperador,
    required this.grupos,
    this.assinaturaMotorista,
    this.assinaturaOperador,
  });

  void _enviarChecklist(BuildContext context) async {
    try {
      final pdf = await PdfGenerator.generateChecklistPdf(
        nomeMotorista,
        placaCavalo,
        placaCadastrada,
        r3,
        transportadora,
        nomeOperador,
        grupos,
        assinaturaMotorista,
        assinaturaOperador,
      );

      final nokResumo = grupos.expand((g) => g.itens).where((i) => i.status == 'NOK').map((i) {
        return '- ${i.nome} (Obs: ${i.observacao ?? "Sem observação"})';
      }).join('\n');

      final body = '''
Checklist realizado para veículo:
Cavalo: $placaCavalo
Cadastrada: $placaCadastrada
Transportadora: $transportadora
R3: $r3
Motorista: $nomeMotorista
Operador: $nomeOperador

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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar e-mail: $e')),
      );
    }
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
            Text('Motorista: $nomeMotorista'),
            Text('Transportadora: $transportadora'),
            Text('R3: $r3'),
            Text('Placa Cavalo: $placaCavalo'),
            Text('Placa Cadastrada: $placaCadastrada'),
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
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                          if (item.observacao != null && item.observacao!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text('Obs: ${item.observacao}'),
                            ),
                          if (item.foto != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: SizedBox(
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(item.foto!.path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
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
