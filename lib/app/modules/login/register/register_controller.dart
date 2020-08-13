import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  HasuraConnect _hasuraConnect =
      HasuraConnect('https://orcamentomestre.herokuapp.com/v1/graphql');

  @observable
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController senhaController = TextEditingController();

  @observable
  TextEditingController nomeController = TextEditingController();

  @observable
  String email;

  @observable
  String tipo;

  @action
  changeEmail(String newEmail) => email = newEmail;

  @observable
  String senha;

  @observable
  String nome;

  @observable
  String telefone;

  @action
  changeTelefone(String newTelefone) => telefone = newTelefone;

  @action
  changeNome(String newNome) => nome = newNome;

  @observable
  bool senhaObscure = true;

  @observable
  bool box1 = true;

  @observable
  bool box2 = false;

  @action
  changeSenha(String newSenha) => senha = newSenha;

  String validate() {
    if (email == null || !email.contains('@')) {
      return 'Mestre, Email inválido';
    } else if (senha == null) {
      return 'Mestre, Senha inválida';
    } else if (email == null && senha == null) {
      return 'Mestre, seu email e senha estão inválidos';
    } else if (senha.length < 6) {
      return 'Mestre, a senha deve conter mais que 6 digitos';
    } else if (nome == null) {
      return 'Nome inválido';
    } else if (telefone == null) {
      return 'Nome inválido';
    } else if (imgUrl == null) {
      return 'Mestre, você esqueceu de por uma foto';
    }
  }

  @computed
  bool get isValid {
    return validate() == null;
  }

  @observable
  bool logoStatus = false;

  @observable
  FirebaseUser user;

  @observable
  FileImage image;

  @observable
  PickedFile imageFile;

  @observable
  ImagePicker picker = ImagePicker();

  @observable
  String imgUrl;

  @action
  Future<PickedFile> getImage() async {
    try {
      final pickedFile = await picker.getImage(
          source: ImageSource.gallery,
          maxHeight: 200,
          maxWidth: 200,
          imageQuality: 85);
      imageFile = pickedFile;
    } catch (e) {}
    (imageFile != null) ? logoStatus = true : logoStatus = false;
    await upImage(imageFile);
    return imageFile;
  }

  @action
  Future<String> upImage(PickedFile image) async {
    String fileName = basename(image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('users/').child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
    var completedTask = await uploadTask.onComplete;
    imgUrl = await completedTask.ref.getDownloadURL();
    return imgUrl;
  }

  @action
  Future<FirebaseUser> register(String nome, String email, String senha,
      String telefone, String imagem) async {
    print(imagem);
    try {
      user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: senha))
          .user;

      Fluttertoast.showToast(msg: 'Registrado com sucesso');
      setUser(email, nome, user.uid, telefone, imagem);
      Modular.to.pushNamed('/login/register/pos');
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Email ou senha inválidos', backgroundColor: Colors.blue);
      print(e);
      Fluttertoast.showToast(msg: e);
    }
    return user;
  }

  @action
  Future<dynamic> setUser(String email, String nome, String id, String telefone,
      String imagem) async {
    var query = """
      mutation setRanking(\$email:String!,\$nome:String!,\$id:String!,\$telefone:String!,\$imagem:String!){
        insert_users(objects: {email: \$email, nome: \$nome, id: \$id, telefone: \$telefone, imagem: \$imagem}) {
          returning {
            created_at
          }
        }
      }
    """;
    var doc = await _hasuraConnect.mutation(query, variables: {
      "email": email,
      "nome": nome,
      "id": id,
      "telefone": telefone,
      "imagem": imagem,
    });
    return doc;
  }
}
