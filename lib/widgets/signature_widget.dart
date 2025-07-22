import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureWidget extends StatelessWidget {
  final String label;
  final SignatureController controller;

  const SignatureWidget({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Signature(
            controller: controller,
            backgroundColor: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => controller.clear(),
              child: const Text("Limpar"),
            ),
          ],
        )
      ],
    );
  }
}
