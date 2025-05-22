import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('alunos.db');

  // Criar tabela se não existir
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL
    );
  ''');

  while (true) {
    print('\nEscolha uma opção:');
    print('1 - Adicionar aluno');
    print('2 - Listar alunos');
    print('3 - Sair');
    stdout.write('Opção: ');
    final opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        adicionarAluno(db);
        break;
      case '2':
        listarAlunos(db);
        break;
      case '3':
        db.dispose();
        print('Encerrando...');
        exit(0);
      default:
        print('Opção inválida.');
    }
  }
}

void adicionarAluno(Database db) {
  stdout.write('Digite o nome do aluno: ');
  final nome = stdin.readLineSync();

  if (nome == null || nome.isEmpty || nome.length > 50) {
    print('Nome inválido. Deve ter até 50 caracteres.');
    return;
  }

  final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?)');
  stmt.execute([nome]);
  stmt.dispose();

  print('Aluno adicionado com sucesso!');
}

void listarAlunos(Database db) {
  final ResultSet result = db.select('SELECT * FROM TB_ALUNO');

  print('\nLista de alunos:');
  for (final row in result) {
    print('ID: ${row['id']}, Nome: ${row['nome']}');
  }
}
