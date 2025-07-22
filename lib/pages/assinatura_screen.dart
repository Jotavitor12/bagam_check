import 'package:flutter/material.dart';
import 'resumo_envio_screen.dart';

class AssinaturaScreen extends StatelessWidget {
  const AssinaturaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assinaturas')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Assinatura do Motorista'),
            const SizedBox(height: 120, child: Placeholder()), // Aqui virá o quadro de assinatura
            const SizedBox(height: 32),
            const Text('Assinatura do Operador'),
            const SizedBox(height: 120, child: Placeholder()), // Aqui também
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ResumoEnvioScreen()),
                );
              },
              child: const Text('Avançar para Resumo'),
            ),
          ],
        ),
      ),
    );
  }
}
