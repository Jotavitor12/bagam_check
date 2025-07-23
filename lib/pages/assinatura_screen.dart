// lib/pages/assinatura_screen.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../data/models.dart';
import '../widgets/signature_widget.dart';
import 'resumo_envio_screen.dart';

class AssinaturaScreen extends StatefulWidget {
  final String placaCavalo;
  final String placaCadastrada;
  final String nomeMotorista;
  final String r3;
  final String transportadora;
  final String nomeOperador;
  final List<Grupo> grupos;

  const AssinaturaScreen({
    super.key,
    required this.placaCavalo,
    required this.placaCadastrada,
    required this.nomeMotorista,
    required this.r3,
    required this.transportadora,
    required this.nomeOperador,
    required this.grupos,
  });

  @override
  State<AssinaturaScreen> createState() => _AssinaturaScreenState();
}

class _AssinaturaScreenState extends State<AssinaturaScreen> {
  final SignatureController _motoristaController = SignatureController(penStrokeWidth: 2, penColor: Colors.black);
  final SignatureController _operadorController = SignatureController(penStrokeWidth: 2, penColor: Colors.black);

  @override
  void dispose() {
    _motoristaController.dispose();
    _operadorController.dispose();
    super.dispose();
  }

  Future<void> _irParaResumo() async {
    final motoristaBytes = await _motoristaController.toPngBytes();
    final operadorBytes = await _operadorController.toPngBytes();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResumoEnvioScreen(
          placaCavalo: widget.placaCavalo,
          placaCadastrada: widget.placaCadastrada,
          nomeMotorista: widget.nomeMotorista,
          r3: widget.r3,
          transportadora: widget.transportadora,
          nomeOperador: widget.nomeOperador,
          grupos: widget.grupos,
          assinaturaMotorista: motoristaBytes,
          assinaturaOperador: operadorBytes,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assinaturas')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SignatureWidget(label: 'Assinatura do Motorista', controller: _motoristaController),
            const SizedBox(height: 32),
            SignatureWidget(label: 'Assinatura do Operador', controller: _operadorController),
            const Spacer(),
            ElevatedButton(
              onPressed: _irParaResumo,
              child: const Text('Avançar para Resumo'),
            ),
          ],
        ),
      ),
    );
  }
}
