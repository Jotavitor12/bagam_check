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
          pw.Text('Checklist Caminhão Tanque - BAGAM', style: pw.TextStyle(fontSize: 20)),
          pw.SizedBox(height: 10),
          pw.Text('**Motorista:** $nomeMotorista'),
          pw.Text('**Transportadora:** $transportadora'),
          pw.Text('**R3:** $r3'),
          pw.Text('**Placa Cavalo:** $placaCavalo'),
          pw.Text('**Placa Cadastrada:** $placaCadastrada'),
          pw.Text('**Operador:** $nomeOperador'),
          pw.SizedBox(height: 20),

          ...grupos.map((grupo) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(grupo.nome, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ...grupo.itens.map((item) => pw.Column(children: [
                pw.Text('- ${item.nome} [${item.status}] (${item.prazoBloqueio})'),
                if (item.observacao != null && item.observacao!.isNotEmpty)
                  pw.Text('Obs: ${item.observacao}'),
                if (item.foto != null)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 5),
                    child: pw.Image(
                      pw.MemoryImage(item.foto!.readAsBytesSync()),
                      width: 200,
                      height: 120,
                    ),
                  ),
                pw.SizedBox(height: 10),
              ])),
              pw.SizedBox(height: 10),
            ],
          )),

          pw.SizedBox(height: 20),
          pw.Text('Assinatura Motorista:'),
          if (assinaturaMotorista != null)
            pw.Image(pw.MemoryImage(assinaturaMotorista), width: 200, height: 80),
          pw.SizedBox(height: 20),
          pw.Text('Assinatura operador:'),
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
