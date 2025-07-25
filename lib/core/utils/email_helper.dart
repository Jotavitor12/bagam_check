// lib/core/utils/email_helper.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share_plus/share_plus.dart';
import 'constants.dart';

class EmailHelper {
  /// Tenta enviar por e-mail. Se não houver cliente de e-mail disponível,
  /// abre o menu de compartilhamento (WhatsApp, Gmail, Telegram, etc).
  static Future<void> enviarChecklistComFallback({
    required String body,
    required File pdfAnexo,
    BuildContext? context,
  }) async {
    final email = Email(
      body: body,
      subject: Constants.assuntoPadrao,
      recipients: [Constants.emailDestino],
      attachmentPaths: [pdfAnexo.path],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Checklist enviado por e-mail com sucesso!')),
        );
      }
    } catch (e) {
      debugPrint('Erro ao enviar por e-mail: $e');

      // Fallback para compartilhamento genérico
      await Share.shareXFiles(
        [XFile(pdfAnexo.path)],
        text: body,
      );

      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'App de e-mail indisponível. Abrindo compartilhamento alternativo...',
            ),
          ),
        );
      }
    }
  }
}
