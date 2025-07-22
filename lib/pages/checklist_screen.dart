import 'package:flutter/material.dart';
import 'assinatura_screen.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final int grupoCount = 15; // depois será 15

  @override
  void initState() {
    _tabController = TabController(length: grupoCount, vsync: this);
    super.initState();
  }

  void _proximo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AssinaturaScreen()),
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
            labelColor: Colors.green, // Cor quando está selecionado
            unselectedLabelColor: Colors.white, // Cor quando não está selecionado
            indicatorColor: Colors.green, // Linha de baixo do tab selecionado
            tabs: List.generate(
              grupoCount,
                  (index) => Tab(text: 'Grupo ${index + 1}'),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          grupoCount,
              (index) => Center(child: Text('Itens do Grupo ${index + 1}')),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _proximo,
        icon: const Icon(Icons.check),
        label: const Text('Finalizar Checklist'),
      ),
    );
  }
}
