// lib/services/storage_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../data/models.dart';

class StorageService {
  static Future<Directory> _getAppDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    return Directory('${dir.path}/checklists');
  }

  static Future<void> saveChecklist(Grupo grupo, String placaCavalo, String placaCadastrada) async {
    final directory = await _getAppDirectory();
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    final id = const Uuid().v4();
    final file = File('${directory.path}/$id.txt');
    final data = StringBuffer();
    data.writeln('Checklist ID: $id');
    data.writeln('Cavalo: $placaCavalo');
    data.writeln('Cadastrada: $placaCadastrada');
    data.writeln('---');
    for (final item in grupo.itens) {
      data.writeln('${item.nome}');
      data.writeln('Status: ${item.status}');
      if (item.observacao != null && item.observacao!.isNotEmpty) {
        data.writeln('Obs: ${item.observacao}');
      }
      data.writeln('');
    }
    await file.writeAsString(data.toString());
  }

  static Future<List<FileSystemEntity>> listSavedChecklists() async {
    final directory = await _getAppDirectory();
    if (await directory.exists()) {
      return directory.listSync();
    }
    return [];
  }

  static Future<void> clearAllChecklists() async {
    final directory = await _getAppDirectory();
    if (await directory.exists()) {
      await for (var file in directory.list()) {
        await file.delete();
      }
    }
  }
}
