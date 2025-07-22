// lib/pages/checklist_screen.dart
import 'package:flutter/material.dart';
import '../data/checklist_data.dart';
import '../widgets/grupo_widget.dart';
import 'assinatura_screen.dart';

class ChecklistScreen extends StatefulWidget {
  final String nomeMotorista;
  final String placaCavalo;
  final String placa1Semireboque;
  final String r3;
  final String transportadora;

  const ChecklistScreen({
    super.key,
    required this.nomeMotorista,
    required this.placaCavalo,
    required this.placa1Semireboque,
    required this.r3,
    required this.transportadora,
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
          placa1Semireboque: widget.placa1Semireboque,
          r3: widget.r3,
          transportadora: widget.transportadora,
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
        label: const Text('Finalizar Checklist'),
      ),
    );
  }
}
