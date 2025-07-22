import 'package:flutter/material.dart';

class ResumoEnvioScreen extends StatelessWidget {
  const ResumoEnvioScreen({super.key});

  void _enviarChecklist(BuildContext context) {
    // TODO: gerar PDF, enviar por e-mail
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checklist enviado com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo e Envio')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Resumo final do checklist:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Expanded(
              child: Placeholder(), // Aqui virá o resumo real
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
