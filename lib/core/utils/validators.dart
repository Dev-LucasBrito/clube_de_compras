import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class Validator {
  static String? email(String? value, [String? errorMessage]) {
    return (value == null || !value.isEmail)
        ? errorMessage ?? 'Email inválido'
        : null;
  }

  static String? name(String? value, [String? errorMessage]) {
    String pattern = r"^[\da-zA-Záâãéêíóôõúç ]+$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorMessage ?? 'Nome inválido';
    } else {
      return null;
    }
  }

  String? passwordConfirm(String? value, String? value2,
      [String? errorMessage]) {
    if (value != value2) {
      return errorMessage ?? 'A senhas não são iguais';
    } else {
      return null;
    }
  }

  static String? noSymbols(String? value, [String? errorMessage]) {
    String pattern = r'^[^<>()[\]\\.,;:@\"*+$%#&]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorMessage ?? 'Obrigatório, não use símbolos!';
    } else {
      return null;
    }
  }

  static String? numberOnly(String? value, [String? errorMessage]) {
    String pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorMessage ?? 'somente números';
    } else {
      return null;
    }
  }

  static String? paymentPrice(String? value, String? valueCashback,
      [String? errorMessage]) {
    if (double.parse(value!.replaceAll('.', '').replaceAll(',', '.')) >
        double.parse(valueCashback!.replaceAll('.', '').replaceAll(',', '.'))) {
      return errorMessage ?? 'Saldo insuficiente';
    } else {
      return null;
    }
  }

  static String? phoneBr(String? value, [String? errorMessage]) {
    String pattern = r'^[+]\d{2}\s{1}[(]\d{2}[)]\s{1}\d{8,9}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorMessage ?? 'Telefone inválido';
    } else {
      return null;
    }
  }

  static String? phonePt(String? value, [String? errorMessage]) {
    String pattern = r'^[(][+]\d{3}[)]\s{1}\d{5}[-]\d{4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorMessage ?? 'Telefone inválido';
    } else {
      return null;
    }
  }

  static String? cpf(String? value, [String? errorMessage]) {
    return (value == null || !value.isCpf)
        ? errorMessage ?? 'CPF inválido'
        : null;
  }

  static String? cnpj(String? value, [String? errorMessage]) {
    return (value == null || !value.isCnpj)
        ? errorMessage ?? 'CNPJ inválido'
        : null;
  }

  ///accepts alphanumeric and alphabet with diacritics and 'ç' chars
  static String? alphaNumericOnly(String? value, [String? errorMessage]) {
    String pattern = r'^[\da-zA-Záâãéêíóôõúç]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorMessage ?? 'Somente números e letras';
    } else {
      return null;
    }
  }

  static String? password(String? value, [String? errorMessage]) {
    String pattern = r'^\S{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorMessage ?? 'Senha deve ter no mínimo 6 caracteres';
    } else {
      return null;
    }
  }

  static String? notEmpty(String? value, [String? errorMessage]) {
    String pattern = r'^(.|\s)*\S(.|\s)*$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return errorMessage ?? 'Campo obrigatório';
    } else {
      return null;
    }
  }

  String getFirstRouteHistory() {
    var history = Modular.to.navigateHistory;

    return history.first.name;
  }

  String? convertSlug(String? value) {
    const diacritics =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËĚèéêëěðČÇçčÐĎďÌÍÎÏìíîïĽľÙÚÛÜŮùúûüůŇÑñňŘřŠšŤťŸÝÿýŽž';
    const nonDiacritics =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEEeeeeeeCCccDDdIIIIiiiiLlUUUUUuuuuuNNnnRrSsTtYYyyZz';

    String slug = value!.replaceAll(' ', '-').replaceAll('/', '-').splitMapJoin(
        '',
        onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char)
            ? nonDiacritics[diacritics.indexOf(char)]
            : char);

    return slug.toLowerCase();
  }
}
