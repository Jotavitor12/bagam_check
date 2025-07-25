import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../data/models.dart';

class PdfGenerator {
  static Future<File> generateChecklistPdf(
      String nomeMotorista,
      String placaCavalo,
      String placaCadastrada,
      String r3,
      String transportadora,
      String nomeOperador,
      List<Grupo> grupos,
      Uint8List? assinaturaMotorista,
      Uint8List? assinaturaOperador,
      ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('Checklist Caminhão Tanque - BAGAM', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
          pw.SizedBox(height: 10),
          pw.Text('Motorista: $nomeMotorista', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('Transportadora: $transportadora', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('R3: $r3', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('Placa Cavalo: $placaCavalo', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('Placa Cadastrada: $placaCadastrada', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('Operador: $nomeOperador', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 20),

          // ✅ Apenas itens NOK
          ...grupos.map((grupo) {
            final itensNok = grupo.itens.where((item) => item.status == 'NOK').toList();
            if (itensNok.isEmpty) return pw.Container();

            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(grupo.nome, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
                pw.SizedBox(height: 8),

                ...itensNok.map((item) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('- ${item.nome} (${item.prazoBloqueio})', style: pw.TextStyle(fontSize: 12)),
                    if (item.observacao != null && item.observacao!.isNotEmpty)
                      pw.Text('Obs: ${item.observacao}', style: pw.TextStyle(fontSize: 11)),

                    if (item.fotos.isNotEmpty)
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 5),
                        child: pw.Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: item.fotos.map((foto) {
                            return pw.Container(
                              width: 150, // largura das fotos
                              height: 100,
                              child: pw.Image(pw.MemoryImage(foto), fit: pw.BoxFit.cover),
                            );
                          }).toList(),
                        ),
                      ),
                    pw.SizedBox(height: 12),
                  ],
                )),
                pw.SizedBox(height: 15),
              ],
            );
          }),

          pw.SizedBox(height: 20),
          pw.Text('Assinatura Motorista:'),
          if (assinaturaMotorista != null)
            pw.Image(pw.MemoryImage(assinaturaMotorista), width: 200, height: 80),
          pw.SizedBox(height: 20),
          pw.Text('Assinatura Operador:'),
          if (assinaturaOperador != null)
            pw.Image(pw.MemoryImage(assinaturaOperador), width: 200, height: 80),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/checklist_final.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
