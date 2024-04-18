import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<void> init() async {
//Create a new PDF document.
  final PdfDocument document = PdfDocument();

//Add a new PDF page.
  final PdfPage page = document.pages.add();

//Create signature field.
  final PdfSignatureField signatureField = PdfSignatureField(
    page,
    'Signature',
    signature: PdfSignature(signedName: 'asd', contactInfo: 'dsa'),
    bounds: const Rect.fromLTWH(0, 0, 200, 50),
  );

  signatureField.signature?.addExternalSigner(GostSigner(), <List<int>>[]);

  //Add the signature field to the document.
  document.form.fields.add(signatureField);

//Save and dispose the PDF document
  File('signed.pdf').writeAsBytes(await document.save());
  document.dispose();
}

class GostSigner implements IPdfExternalSigner {
  @override
  DigestAlgorithm get hashAlgorithm => DigestAlgorithm.sha256;

  @override
  Future<SignerResult?> sign(List<int> message) async {
    return SignerResult(<int>[1,2,3]);
  }

  @override
  SignerResult? signSync(List<int> message) {
    throw UnimplementedError();
  }
}
