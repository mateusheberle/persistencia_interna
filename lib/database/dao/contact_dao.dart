import '/../models/contact.dart';
import 'package:sqflite/sqflite.dart';
import '/../database/app_database.dart';

class ContactDao {
/* criar tabela 
  tableSql: SQL para criar a tabela no banco de dados 
*/
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

/* método save(): adicionar contato
*/
  Future<int> save(Contact contact) async {
// pega referência do banco de dados
    final Database db = await getDatabase();
// pega o objeto do tipo 'Contact' e transforma em um Map
    Map<String, dynamic> contactMap = _toMap(contact);
// insere o Map no banco de dados na tabela '_tableName'
    return db.insert(_tableName, contactMap);
  }

/* método findAll(): ler todos os contatos
*/
  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase(); // referência
/* consulta no banco de dados na tabela '_tableName'
  salva o resultado em uma lista de Maps
*/
    final List<Map<String, dynamic>> result = await db.query(_tableName);
// transforma a lista de Maps em uma lista de 'Contacts'
    List<Contact> contacts = _toList(result);
// retorna a lista de 'Contacts'
    return contacts;
  }

// método _toMap(): transforma um objeto do tipo 'Contact' em um Map
  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

// método _toList(): transforma uma lista de Maps em uma lista de 'Contacts'
  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
