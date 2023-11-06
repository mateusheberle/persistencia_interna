import '../database/dao/contact_dao.dart';
import '../models/contact.dart';
import '../screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        // initialData: List<Contact>(),
// _dao.findAll(): retorna uma lista de contatos do tipo 'Contacts'
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
/* ConnectionState: estado de uma conexão assíncrona
  qual interface deve ser mostrada
- none: nenhuma tarefa iniciada
- waiting: tarefa iniciada, mas não finalizada, aguardando uma interação
- active: tarefa ativa, pode ou não estar emetindo novos snapshots
- done: tarefa concluida
*/
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading')
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact>? contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(contact);
                },
                itemCount: contacts!.length,
              );
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const ContactForm(),
                ),
              )
/* then() - "depois disso" 
  no caso, quando a tela de contato for fechada, atualizar a lista de contatos
*/
              .then(
                (value) => setState(() {}),
              );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

/*
  FutureBuilder - Pegar informações que demoram um pouco pra vir (uma única vez)
    future: informação que precisa - TaskDao().findAll()
    builder: (context, snapshot){}
      snapshot - dados que vem

  StreamBuilder - caso as informações venham a todo momento
*/
class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
/*
  ListTile(
    leading: Icon(Icons.person), // Ícone no início
    title: Text('Nome do Contato'), // Texto principal
    subtitle: Text('Informações adicionais'), // Texto secundário
    trailing: Icon(Icons.message), // Ícone no fim
    onTap: () {
      print('ListTile foi tocado!');
    },
  )
*/
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
