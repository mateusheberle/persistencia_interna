import '../database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// pega referência do banco de dados
Future<Database> getDatabase() async {
/* 
  join(): concatena todos os elementos da lista em uma string
  getDatabasesPath: retorna o caminho onde o banco de dados será salvo (função sqflite)
*/
  final String path = join(await getDatabasesPath(), 'bytebank.db');
/*
  openDatabase: abrir uma conexao com o banco (função sqflite)
  se o banco não existir, ele será criado
*/
  return openDatabase(
    path,
/* 
  onCreate: método chamado quando o banco é criado pela primeira vez
  usado para criar as tabelas do banco
*/
    onCreate: (db, version) {
      db.execute(ContactDao.tableSql);
    },
    version: 1,
  );
}
