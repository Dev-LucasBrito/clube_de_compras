import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/models/statement_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:get/get.dart';

class StatementController extends GetxController {
  static StatementController to = Get.find();
  AuthController authController = Get.put(AuthController());

  bool isLoading = true;
  bool valueVisibility = true;

  List<StatementModel> statementModel = [];

  List orderStatementModel = [];

  Map<String, List> orderGrup = {};

  setVisibilityValue() {
    valueVisibility = !valueVisibility;
    update();
  }

  setOrderList() {
    isLoading = true;
    update();

    isLoading = false;
    update();
  }

  setStatementModel() async {
    isLoading = true;
    statementModel =
        await ProviderApi().userMovimentations(cpf: authController.cpf);
    isLoading = true;
    update();
    setOrderList();
    update();
  }

  @override
  void onInit() async {
    await setStatementModel();

    super.onInit();
  }
}



/*

    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime.now(),
        inOrOut: 1),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 1,
        ),
        inOrOut: 2),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 1,
        ),
        inOrOut: 1),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 1,
        ),
        inOrOut: 2),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 2,
        ),
        inOrOut: 1),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 2,
        ),
        inOrOut: 1),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 2,
        ),
        inOrOut: 2),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 2,
        ),
        inOrOut: 1),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 3,
        ),
        inOrOut: 2),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 3,
        ),
        inOrOut: 2),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 3,
        ),
        inOrOut: 1),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 3,
        ),
        inOrOut: 1),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 3,
        ),
        inOrOut: 1),
    StatementModel(
        storeName: 'Cafeteria ria',
        productName: 'Café preto',
        cashback: '10,00',
        cashbackUser: '350,00',
        date: DateTime(
          2022,
          DateTime.now().month,
          DateTime.now().day + 4,
        ),
        inOrOut: 2),
  
 */