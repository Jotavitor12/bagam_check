import 'package:flutter/material.dart';
import '../data/checklist_data.dart';
import '../widgets/grupo_widget.dart';
import 'assinatura_screen.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

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
          placaCavalo: 'ABC1234',
          placa1Semireboque: 'DEF5678',
          nomeMotorista: 'João Vitor',
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
