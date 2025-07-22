import 'package:flutter/material.dart';
import 'checklist_screen.dart';

class IdentificacaoScreen extends StatefulWidget {
  const IdentificacaoScreen({super.key});

  @override
  State<IdentificacaoScreen> createState() => _IdentificacaoScreenState();
}

class _IdentificacaoScreenState extends State<IdentificacaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _placaCavaloController = TextEditingController();
  final _codSapController = TextEditingController();
  final _placa1SemirreboqueController = TextEditingController();
  final _placa2SemirreboqueController = TextEditingController();
  final _condutorController = TextEditingController();
  final _transportadoraController = TextEditingController();

  @override
  void dispose() {
    _placaCavaloController.dispose();
    _codSapController.dispose();
    _placa1SemirreboqueController.dispose();
    _placa2SemirreboqueController.dispose();
    _condutorController.dispose();
    _transportadoraController.dispose();
    super.dispose();
  }

  void _proximo() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ChecklistScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dados do Veículo - Condutor')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _condutorController,
                decoration: const InputDecoration(labelText: 'Nome do Condutor *'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _codSapController,
                decoration: const InputDecoration(labelText: 'Código SAP (R3) *'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _placaCavaloController,
                decoration: const InputDecoration(labelText: 'Placa do Cavalo'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _placa1SemirreboqueController,
                decoration:
                const InputDecoration(labelText: 'Placa do 1º Semirreboque *'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _placa2SemirreboqueController,
                decoration:
                const InputDecoration(labelText: 'Placa do 2º Semirreboque *'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _transportadoraController,
                decoration: const InputDecoration(labelText: 'Transportadora *'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _proximo,
                child: const Text('Avançar para Checklist'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
