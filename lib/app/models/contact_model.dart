import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  String? nome;
  String? telefone1;
  String? telefone2;
  String? email;
  String? imagem;
  String? logradouro;
  String? cep;
  String? cidade;
  String? numero;
  String? uf;
  String? dataLembrete;
  String? complemento;
  DocumentReference? reference;

  ContactModel(
      {this.nome,
      this.telefone1,
      this.telefone2,
      this.email,
      this.imagem,
      this.logradouro,
      this.cep,
      this.cidade,
      this.numero,
      this.uf,
      this.dataLembrete,
      this.complemento,
      this.reference});

  factory ContactModel.fromDocument(DocumentSnapshot doc) {
    return ContactModel(
      nome: doc.data().toString().contains('nome') ? doc.get('nome') : '',
      telefone1: doc.data().toString().contains('telefone_1')
          ? doc.get('telefone_1')
          : '',
      telefone2: doc.data().toString().contains('telefone_2')
          ? doc.get('telefone_2')
          : '',
      email: doc.data().toString().contains('email') ? doc.get('email') : '',
      imagem: doc.data().toString().contains('imagem') ? doc.get('imagem') : '',
      logradouro: doc.data().toString().contains('logradouro')
          ? doc.get('logradouro')
          : '',
      cep: doc.data().toString().contains('cep') ? doc.get('cep') : '',
      cidade: doc.data().toString().contains('cidade') ? doc.get('cidade') : '',
      numero: doc.data().toString().contains('numero') ? doc.get('numero') : '',
      uf: doc.data().toString().contains('uf') ? doc.get('uf') : '',
      complemento: doc.data().toString().contains('complemento')
          ? doc.get('complemento')
          : '',
      dataLembrete: doc.data().toString().contains('dataLembrete')
          ? doc.get('dataLembrete')
          : '',
      reference: doc.reference,
    );
  }
}
