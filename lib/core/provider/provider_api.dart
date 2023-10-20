import 'dart:convert';
import 'package:cashback/core/components/snacks/snacks.dart';
import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/models/banners_model.dart';
import 'package:cashback/core/models/mural_model.dart';
import 'package:cashback/core/models/parterns_cashback_model.dart';
import 'package:cashback/core/models/promotions_model.dart';
import 'package:cashback/core/models/statement_model.dart';
import 'package:cashback/core/models/user_model.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/payment/pages/payment_checkout_page.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProviderApi {
  static const baseApiUrl = 'https://clubedecompras.app.br';

  Future<bool> deleteAccount({
    required int id,
    required String password,
    required context,
  }) async {
    String url = '$baseApiUrl/API/Clientes/Delete';

    http.Response response = await http.post(Uri.parse(url),
        body: {'id': id.toString(), 'senha': password.toString()});

    if (response.statusCode == 200) {
      Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;

      String status = body['status'];

      if (status == "ERROR") {
        CashbackSnackBar.snackbarCustom(
            title: 'Error',
            description: 'Erro inesperado, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return false;
      } else if (status == "CLIENT_NOT_FOUND") {
        CashbackSnackBar.snackbarCustom(
            title: 'Error',
            description: 'Atenção, cliente nao encontrado, tente novamente',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return false;
      } else if (status.isEmpty) {
        CashbackSnackBar.snackbarCustom(
            title: 'Error',
            description:
                'Um erro inesperado aconteceu, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return false;
      } else {
        CashbackSnackBar.snackbarCustom(
            title: 'Sucessp',
            description: 'Conta deletada com sucesso',
            context: context,
            bgColor: CashbackThemes.success,
            textColor: CashbackThemes.whiteCashback,
            iconType: 2);
        return true;
      }
    } else {
      CashbackSnackBar.snackbarCustom(
          title: 'Error',
          description:
              'Um erro inesperado aconteceu, tente novamente mais tarde',
          context: context,
          bgColor: CashbackThemes.error,
          textColor: CashbackThemes.whiteCashback,
          iconType: 3);
      return false;
    }
  }

  Future<UserModel> signUp({
    required String mail,
    required String name,
    required String password,
    required String cpf,
    required context,
  }) async {
    String url = '$baseApiUrl/API/Clientes/Register';
    // print(md5.convert(utf8.encode(password)).toString());
//
    // print(name);
    // print(cpf);
    // print(mail);
    // print(md5.convert(utf8.encode(password)).toString());

    http.Response response = await http.post(Uri.parse(url), body: {
      'nome': name,
      'documento': cpf,
      'email': mail,
      'senha': md5.convert(utf8.encode(password)).toString()
    });

    if (response.statusCode == 200) {
      //print('entrei aqui no status - ${response.body}');
      //print(response.body);

      Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;

      String status = body['status'];

      if (status == "ERROR") {
        CashbackSnackBar.snackbarCustom(
            title: 'Error',
            description:
                'Um erro inesperado aconteceu, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else if (status == "DOCUMENT_IN_USE") {
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Atenção, esse documento já esta vinculado a uma outra conta',
            context: context,
            bgColor: CashbackThemes.primaryRegular,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else if (status.isEmpty) {
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Um erro inesperado aconteceu, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else {
        UserModel userId = UserModel(
            clientId: body['clienteId'],
            name: name,
            email: mail,
            cpf: cpf,
            token: md5.convert(utf8.encode(password)).toString());

        CashbackSnackBar.snackbarCustom(
            title: 'Sucesso',
            description: 'Conta criada com sucesso',
            context: context,
            bgColor: CashbackThemes.success,
            textColor: CashbackThemes.whiteCashback,
            iconType: 2);

        return userId;
      }
    } else {
      CashbackSnackBar.snackbarCustom(
          title: 'Atenção',
          description:
              'Não foi possivel criar uma conta, tente novamente mais tarde',
          context: context,
          bgColor: CashbackThemes.error,
          textColor: CashbackThemes.whiteCashback,
          iconType: 3);
      return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
    }
  }

  Future<String> recoveryPassword({
    required String cpf,
    required  context,
  }) async {
    String url = '$baseApiUrl/API/Clientes/RestorePassword';

    http.Response response = await http.post(Uri.parse(url), body: {
      'cpf': cpf,
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print('entrei aqui no status - ${response.body}');
      //print(response.body);

      Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;

      String status = body['status'];

      if (status == "ERROR") {
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Um erro inesperado aconteceu, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return '';
      } else if (status == "DOCUMENT_NOT_FOUND") {
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description: 'CPF não encontrado',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return '';
      } else if (status == "EMAIL_NOT_SENT") {
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Um erro inesperado aconteceu, não conseguimos enviar o email tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return '';
      } else if (status.isEmpty) {
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Um erro inesperado aconteceu, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);
        return '';
      } else {
        String token = body['token'];
        return token;
      }
    } else {
      CashbackSnackBar.snackbarCustom(
          title: 'Atenção',
          description:
              'Um erro inesperado aconteceu, tente novamente mais tarde',
          context: context,
          bgColor: CashbackThemes.error,
          textColor: CashbackThemes.whiteCashback,
          iconType: 3);

      return '';
    }
  }

  Future<bool> changePassword(
      {required String cpf,
      required String token,
      required String novaSenha,
      required  context}) async {
    String url = '$baseApiUrl/API/Clientes/ChangePassword';

    http.Response response = await http.post(Uri.parse(url), body: {
      'cpf': cpf,
      'token': token,
      'novaSenha': md5.convert(utf8.encode(novaSenha)).toString()
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print('entrei aqui no status - ${response.body}');
      //print(response.body);

      Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;

      String status = body['status'];
    

      if (status == "ERROR") {
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Um erro inesperado aconteceu, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return false;
      } else if (status == "TOKEN_NOT_FOUND") {
        Modular.to.pop();
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Não conseguimos validar seu código, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.primaryRegular,
            textColor: CashbackThemes.whiteCashback,
            iconType: 1);

        return false;
      } else if (status == "TOKEN_EXPIRED") {
        Modular.to.pop();
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Seu código expirou, ele dura apenas 15 minutos para sua segurança',
            context: context,
            bgColor: CashbackThemes.primaryRegular,
            textColor: CashbackThemes.whiteCashback,
            iconType: 1);

        return false;
      } else if (status.isEmpty) {
        CashbackSnackBar.snackbarCustom(
            title: 'Atenção',
            description:
                'Um erro inesperado aconteceu, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return false;
      } else if (status == "SUCCESS") {
        Modular.to.pop();
        CashbackSnackBar.snackbarCustom(
            title: 'Sucesso',
            description:
                'Sua senha foi alterada com sucesso, agora você já pode entrar na sua conta!',
            context: context,
            bgColor: CashbackThemes.success,
            textColor: CashbackThemes.whiteCashback,
            iconType: 2);

        return true;
      } else {
        Modular.to.pop();
        CashbackSnackBar.snackbarCustom(
            title: 'Erro',
            description:
                'Seu código expirou, ele dura apenas 15minutos para sua segurança',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return false;
      }
    } else {
      Modular.to.pop();
      CashbackSnackBar.snackbarCustom(
          title: 'Erro',
          description:
              'Não foi possivel enviar o email, tente novamente mais tarde',
          context: context,
          bgColor: CashbackThemes.error,
          textColor: CashbackThemes.whiteCashback,
          iconType: 3);
      return false;
    }
  }

  Future<UserModel?> signIn(
      String cpf, String password,  context) async {
    String url = 'https://clubedecompras.app.br/API/Clientes/Login';

    http.Response response = await http.post(Uri.parse(url), body: {
      'cpf': cpf,
      'senha': md5.convert(utf8.encode(password)).toString()
    });

    // print(response.statusCode);
    if (response.statusCode == 200) {
      // print(response.body);
      final body = await jsonDecode(response.body);

      String status = body['status'];
      //print(status);

      if (status == "EMAIL_NOT_FOUND") {
        CashbackSnackBar.snackbarCustom(
            title: 'Atencão',
            description: 'Email não encontrado',
            context: context,
            bgColor: CashbackThemes.primaryRegular,
            textColor: CashbackThemes.whiteCashback,
            iconType: 1);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else if (status == "INVALID_PASSWORD") {
        CashbackSnackBar.snackbarCustom(
            title: 'Erro',
            description: 'Senha invalida',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else if (status.isEmpty || status == "ERROR") {
        CashbackSnackBar.snackbarCustom(
            title: 'Erro',
            description:
                'Não foi possivel enviar o email, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else if (status == "NULL_REQUIRED_FIELDS") {
        CashbackSnackBar.snackbarCustom(
            title: 'Erro',
            description: 'Verifique se todos os campos estão preenchidos',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else if (status == "DOCUMENT_NOT_FOUND") {
        CashbackSnackBar.snackbarCustom(
            title: 'Erro',
            description: 'CPF não encontrado',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else if (status.isNotEmpty && status != "SUCCESS") {
        CashbackSnackBar.snackbarCustom(
            title: 'Erro',
            description:
                'Erro inesperado, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      } else if (status == "SUCCESS") {
        UserModel userId = UserModel.fromJson(body);

        return userId;
      } else {
        CashbackSnackBar.snackbarCustom(
            title: 'Erro',
            description:
                'Não foi possivel enviar o email, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);
        return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
      }
    } else {
      CashbackSnackBar.snackbarCustom(
          title: 'Erro',
          description:
              'Não foi possivel enviar o email, tente novamente mais tarde',
          context: context,
          bgColor: CashbackThemes.error,
          textColor: CashbackThemes.whiteCashback,
          iconType: 3);
      return UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');
    }
  }

  Future<List<PromotionsModel>> listPromotionsHome() async {
    String url =
        '$baseApiUrl/API/Promocoes/ListHome?pessoaId=${Get.find<AuthController>().user!.clientId.toString()}';

    http.Response response = await http.get(Uri.parse(url), headers: {
      'pessoaId': Get.find<AuthController>().user!.clientId.toString(),
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final body = await jsonDecode(response.body);

      List<PromotionsModel> mural;
      mural = (body as List).map((item) {
        return PromotionsModel.fromJson(item);
      }).toList();

      return mural;
    } else {
      return [];
    }
  }

  Future<List<PromotionsModel>> listPromotions() async {
    String url = '$baseApiUrl/API/Promocoes/List';

    http.Response response = await http.get(Uri.parse(url), headers: {
      'pessoaId': Get.find<AuthController>().user!.clientId.toString(),
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final body = await jsonDecode(response.body);

      List<PromotionsModel> mural;
      mural = (body as List).map((item) {
        return PromotionsModel.fromJson(item);
      }).toList();

      return mural;
    } else {
      return [];
    }
  }

  Future<List<BannersModel>> listBannersHome() async {
    String url = '$baseApiUrl/API/Banners/ListHome';

    http.Response response = await http.get(Uri.parse(url), headers: {
      'pessoaId': Get.find<AuthController>().user!.clientId.toString(),
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      final body = await jsonDecode(response.body);

      List<BannersModel> mural;
      mural = (body as List).map((item) {
        return BannersModel.fromJson(item);
      }).toList();

      return mural;
    } else {
      return [];
    }
  }

  Future<List<MuralModel>> listMuralHome() async {
    String url = '$baseApiUrl/API/Mural/ListHome';

    http.Response response = await http.get(Uri.parse(url), headers: {
      'pessoaId': Get.find<AuthController>().user!.clientId.toString(),
    });

    // print(response.statusCode);
    if (response.statusCode == 200) {
      final body = await jsonDecode(response.body);

      List<MuralModel> mural;
      mural = (body as List).map((item) {
        return MuralModel.fromJson(item);
      }).toList();

      return mural;
    } else {
      return [];
    }
  }

  Future<List<MuralModel>> listMural() async {
    String url = '$baseApiUrl/API/Mural/List';

    http.Response response = await http.get(Uri.parse(url), headers: {
      'pessoaId': Get.find<AuthController>().user!.clientId.toString(),
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      //  print(response.body);
      final body = await jsonDecode(response.body);

      if (body.toString().isEmpty) {
        return [];
      } else {
        List<MuralModel> mural;
        mural = (body as List).map((item) {
          return MuralModel.fromJson(item);
        }).toList();

        return mural;
      }
    } else {
      return [];
    }
  }


  Future<List<ParternsCashbackModel>> listAssociadosMuralHome() async {
    String url = '$baseApiUrl/API/Associados/ListHome';

    http.Response response = await http.get(Uri.parse(url), headers: {
      'pessoaId': Get.find<AuthController>().user!.clientId.toString(),
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      //  print(response.body);
      final body = await jsonDecode(response.body);

      if (body.isEmpty) {
        return [];
      } else {
        List<ParternsCashbackModel> mural;
        mural = (body as List).map((item) {
          return ParternsCashbackModel.fromJson(item);
        }).toList();

        mural.sort(((a, b) => a.status!.compareTo(b.status!)));

        return mural;
      }
    } else {
      return [];
    }
  }

  Future<List<ParternsCashbackModel>> listAssociadosMural() async {
    String url = '$baseApiUrl/API/Associados/List';

    http.Response response = await http.get(Uri.parse(url), headers: {
      'pessoaId': Get.find<AuthController>().user!.clientId.toString(),
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      //  print(response.body);
      final body = await jsonDecode(response.body);

      if (body.isEmpty) {
        return [];
      } else {
        List<ParternsCashbackModel> mural;
        mural = (body as List).map((item) {
          return ParternsCashbackModel.fromJson(item);
        }).toList();

        mural.sort(((a, b) => a.status!.compareTo(b.status!)));

        return mural;
      }
    } else {
      return [];
    }
  }

  Future<ParternsCashbackModel> associadoDetail({
    required int idAssociado,
  }) async {
    String url = '$baseApiUrl/API/Associados/Details?id=$idAssociado';

    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final body = await jsonDecode(utf8.decode(response.bodyBytes));

      if (body.isEmpty) {
        Modular.to.pop();
        return ParternsCashbackModel(title: '', cashback: '', img: '', id: 0);
      } else {
        ParternsCashbackModel parternsCashbackModel;
        parternsCashbackModel = ParternsCashbackModel.fromJson(body);

        return parternsCashbackModel;
      }
    } else {
      return ParternsCashbackModel(title: '', cashback: '', img: '', id: 0);
    }
  }

  Future<ParternsCashbackModel> associadoDetailPayment({
    required String cnpj,
  }) async {
    String url = '$baseApiUrl/API/Associados/GetByDocument?documento=$cnpj';

    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      if (response.body.length < 30) {
        return ParternsCashbackModel(title: '', cashback: '', img: '', id: 0);
      } else {
        final body = await jsonDecode(utf8.decode(response.bodyBytes));
        ParternsCashbackModel parternsCashbackModel;
        parternsCashbackModel = ParternsCashbackModel.fromJson(body);

        return parternsCashbackModel;
      }
    } else {
      return ParternsCashbackModel(title: '', cashback: '', img: '', id: 0);
    }
  }

  Future<Map<String, dynamic>> userCashback({
    required String cpf,
  }) async {
    String url = '$baseApiUrl/API/Movimentacoes/Statement?documento=$cpf';

    //Map<String, String> header = {'documento': cpf};

    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final body = await jsonDecode(utf8.decode(response.bodyBytes));

      if (body['status'] == 'NOT_FOUND') {
        return {'status': body['status'], 'saldo': 0};
      } else if (body['status'] == 'INVALID_DOCUMENT') {
        return {'status': body['status'], 'saldo': 0};
      } else if (body['status'] == 'SUCCESS') {
        return {
          'status': body['status'],
          'saldo': double.parse(body['saldo'].toString())
        };
      } else {
        return {'status': 'ERROR 200', 'saldo': 0};
      }
    } else {
      return {'status': 'ERROR', 'saldo': 0};
    }
  }

  Future<bool> userEditData({
    required int id,
    required String senhaMd5,
    String? newPasswordMd5,
    String? name,
    String? email,
    required context,
  }) async {
    String url = '$baseApiUrl/API/Clientes/Update';

    //Map<String, String> header = {'documento': cpf};

    http.Response response = await http.post(Uri.parse(url), body: {
      'id': id.toString(),
      'senha': senhaMd5, //string (criptografada),
    });

    if (response.statusCode == 200) {
      final body = await jsonDecode(utf8.decode(response.bodyBytes));

      if (body['status'] == 'SUCCESS') {
        return true;
      } else {
        return false;
      }
    } else {
      CashbackSnackBar.snackbarCustom(
          title: 'Erro',
          description: 'Não foi possivel editar os dados, tente novamente',
          context: context,
          bgColor: CashbackThemes.error,
          textColor: CashbackThemes.whiteCashback,
          iconType: 3);
      return false;
    }
  }

  Future<List<StatementModel>> userMovimentations({
    required String cpf,
  }) async {
    String url = '$baseApiUrl/API/Movimentacoes/Balance?documento=$cpf';

    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final body = await jsonDecode(utf8.decode(response.bodyBytes));

      if (body.toString().length == 20) {
        return [];
      } else {
        List<StatementModel> statementModel;
        statementModel = (body as List).map((item) {
          return StatementModel.fromJson(item);
        }).toList();

        return statementModel;
      }
    } else {
      return <StatementModel>[];
    }
  }

  Future<StatementModel?> userMovimentationDetail({
    required String cpf,
    required int id,
  }) async {
    String url = '$baseApiUrl/API/Movimentacoes/Details?id=$id&documento=$cpf';

    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final body = await jsonDecode(utf8.decode(response.bodyBytes));

      if (body.isEmpty) {
        return null;
      } else {
        StatementModel statementModel;

        statementModel = StatementModel.fromJson(body);

        return statementModel;
      }
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> payment({
    required double valor,
    required String cpf,
    required String cnpj,
  }) async {
    String url = '$baseApiUrl/API/Movimentacoes/Pay';

    http.Response response = await http.post(Uri.parse(url), body: {
      'valor': valor.toString(),
      'origemDocumento': cpf,
      'destinoDocumento': cnpj,
    });
    // print(response.body);
    if (response.statusCode == 200) {
      //print('entrei aqui no status - ${response.body}');
      //print(response.body);

      Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;

      String status = body['status'];

      if (status == "ERROR") {
        return {'status': StatusPayment.reject};
      } else if (status == "INVALID_ORIGIN") {
        return {'status': StatusPayment.reject};
      } else if (status == "DESTINATION_NOT_FOUND") {
        return {'status': StatusPayment.reject};
      } else if (status == "SUCCESS") {
        return {'status': StatusPayment.approved, 'id': body['id']};
      } else if (status.isEmpty) {
        return {'status': StatusPayment.reject};
      } else {
        return {'status': StatusPayment.reject};
      }
    } else {
      return {'status': StatusPayment.reject};
    }
  }
}
