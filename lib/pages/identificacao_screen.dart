import 'package:flutter/material.dart';
import 'checklist_screen.dart';

class IdentificacaoScreen extends StatefulWidget {
  const IdentificacaoScreen({super.key});

  @override
  State<IdentificacaoScreen> createState() => _IdentificacaoScreenState();
}

class _IdentificacaoScreenState extends State<IdentificacaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _motoristaController = TextEditingController();
  final _placaCavaloController = TextEditingController();
  final _placa1SRController = TextEditingController();
  final _r3Controller = TextEditingController();
  final _transportadoraController = TextEditingController();

  void _avancar() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChecklistScreen(
            nomeMotorista: _motoristaController.text,
            placaCavalo: _placaCavaloController.text,
            placa1Semireboque: _placa1SRController.text,
            r3: _r3Controller.text,
            transportadora: _transportadoraController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identificação')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _motoristaController, decoration: const InputDecoration(labelText: 'Nome do Motorista'), validator: (value) => value!.isEmpty ? 'Preencha este campo' : null),
              TextFormField(controller: _placaCavaloController, decoration: const InputDecoration(labelText: 'Placa Cavalo'), validator: (value) => value!.isEmpty ? 'Preencha este campo' : null),
              TextFormField(controller: _placa1SRController, decoration: const InputDecoration(labelText: 'Placa 1º SR'), validator: (value) => value!.isEmpty ? 'Preencha este campo' : null),
              TextFormField(controller: _r3Controller, decoration: const InputDecoration(labelText: 'R3'), validator: (value) => value!.isEmpty ? 'Preencha este campo' : null),
              TextFormField(controller: _transportadoraController, decoration: const InputDecoration(labelText: 'Transportadora'), validator: (value) => value!.isEmpty ? 'Preencha este campo' : null),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _avancar, child: const Text('Avançar para Checklist')),
            ],
          ),
        ),
      ),
    );
  }
}
