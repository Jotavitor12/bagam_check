// lib/pages/checklist_screen.dart
import 'package:flutter/material.dart';
import '../data/checklist_data.dart';
import '../widgets/grupo_widget.dart';
import 'assinatura_screen.dart';

class ChecklistScreen extends StatefulWidget {
  final String nomeMotorista;
  final String placaCavalo;
  final String placaCadastrada;
  final String r3;
  final String transportadora;
  final String nomeOperador;

  const ChecklistScreen({
    super.key,
    required this.nomeMotorista,
    required this.placaCavalo,
    required this.placaCadastrada,
    required this.r3,
    required this.transportadora,
    required this.nomeOperador,
  });

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: grupos.length, vsync: this);
  }

  void _proximo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AssinaturaScreen(
          nomeMotorista: widget.nomeMotorista,
          placaCavalo: widget.placaCavalo,
          placaCadastrada: widget.placaCadastrada,
          r3: widget.r3,
          transportadora: widget.transportadora,
          nomeOperador: widget.nomeOperador,
          grupos: grupos,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.green,
          tabs: grupos.map((g) => Tab(text: g.nome)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: grupos.map((grupo) {
          return GrupoWidget(grupo: grupo);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _proximo,
        icon: const Icon(Icons.check),
        label: const Text(''),
      ),
    );
  }
}
