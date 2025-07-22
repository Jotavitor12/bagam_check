import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../data/models.dart';

class PdfGenerator {
  static Future<File> generateChecklistPdf(String nomeMotorista, String placaCavalo, List<Grupo> grupos) async {
    final pdf = pw.Document();

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
        ],
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/checklist_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
