import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../../data/models.dart';

class PdfGenerator {
  static Future<File> generateChecklistPdf(
      String nomeMotorista,
      String placaCavalo,
      List<Grupo> grupos,
      Uint8List? assinaturaMotorista,
      Uint8List? assinaturaOperador,
      ) async {
    final pdf = pw.Document();

    final motoristaSignature = assinaturaMotorista != null ? pw.MemoryImage(assinaturaMotorista) : null;
    final operadorSignature = assinaturaOperador != null ? pw.MemoryImage(assinaturaOperador) : null;

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('Checklist Caminhão Tanque - BAGAM', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 12),
          pw.Text('Motorista: $nomeMotorista'),
          pw.Text('Placa Cavalo: $placaCavalo'),
          pw.SizedBox(height: 16),
          for (final grupo in grupos) ...[
            pw.Text(grupo.nome, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            for (final item in grupo.itens)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('${item.nome} - ${item.status}'),
                  if (item.status == 'NOK' && item.observacao != null)
                    pw.Text('Obs: ${item.observacao}'),
                  pw.SizedBox(height: 4),
                ],
              ),
            pw.SizedBox(height: 12),
          ],
          pw.Divider(),
          pw.Text('Assinaturas:', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 12),
          if (motoristaSignature != null) pw.Text('Motorista:'),
          if (motoristaSignature != null) pw.Image(motoristaSignature, height: 80),
          pw.SizedBox(height: 24),
          if (operadorSignature != null) pw.Text('Operador:'),
          if (operadorSignature != null) pw.Image(operadorSignature, height: 80),
        ],
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/checklist_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
