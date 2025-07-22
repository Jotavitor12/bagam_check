import 'dart:io';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'constants.dart';

class EmailHelper {
  static Future<void> enviarChecklist({
    required String body,
    required File pdfAnexo,
  }) async {
    final Email email = Email(
      body: body,
      subject: Constants.assuntoPadrao,
      recipients: [Constants.emailDestino],
      attachmentPaths: [pdfAnexo.path],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}
