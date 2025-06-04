import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

main() async {
  // Configura as credenciais SMTP do Gmail
  final smtpServer = gmail('charlisonsantos181@gmail.com', 'rwwz yoze eyid uudk');

  // Cria uma mensagem de e-mail
  final message = Message()
    ..from = Address('charlisonsantos181@gmail.com', 'Charlison')
    ..recipients.add('francisco.chrlison09@aluno.ifce.edu.br')
    ..subject = 'treino de hoje'
    ..text = 'bom dia caro aluno do ifce, voce ira treinar inferiores ou superiores?';

  try {
    // Envia o e-mail usando o servidor SMTP do Gmail
    final sendReport = await send(message, smtpServer);

    // Exibe o resultado do envio do e-mail
    print('E-mail enviado: ${sendReport}');
  } on MailerException catch (e) {
    // Exibe informações sobre erros de envio de e-mail
    print('Erro ao enviar e-mail: ${e.toString()}');
  }
}