import './screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
/* hintColor: 
- dicas de textos em campos de entrada de texto
- ícones e texto de botões desabilitados
*/
        hintColor: Colors.green[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.green[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const Dashboard(),
    );
  }
}
/* Flutter: aplicando persistência interna

  dart: padrão tudo minúsculo
  AndroidX: artefatos novos da plataforma do android
  API 28
  Shift + F6: renomear

  persistencia interna - salvar no dispositivo

  Pacotes:
    SQFLite
    Shared Preferences
    Hive
    ObjectBox

  https://docs.flutter.dev/cookbook/persistence

  Shared Preferences
    Leve
    Ruim com grandes dados

  SQFLite
    Muitas informações
    Não suporta web
    
  pubspec.yaml - guarda as dependências

  path - local no dispositivo onde encontrar o banco de dados

  dao
    objeto de acesso a dados
    separa flutter do back-end

  static - valor para qualquer instância criada da classe

  save() - criar e atualizar
  findAll() - ler tudo
  find() - ler um
  delete() - deletar

  CRUD - Create, Read, Update e Delete

  https://github.com/tekartik/sqflite/blob/master/sqflite/doc/sql.md - resumo SQL de SQFLite

  https://pub.dev/packages/uuid - pacote que gera 'ids'

*/