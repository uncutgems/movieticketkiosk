import 'package:ncckios/base/api_handler.dart';
import 'package:ncckios/base/constant.dart';
import 'package:ncckios/base/url.dart';
import 'package:ncckios/model/entity.dart';

class OrderRepository {
  Future<Order> createOrder(
      int customerId,
      int planScreenId,
      String seatsF1,
      String listChairValueF1,
      String customerFirstName,
      String customerLastName,
      String paymentMethodSystemName) async {
    final Map<String, dynamic> body = <String, dynamic>{};
    body[Constant.customerId] = customerId;
    body[Constant.planScreenId] = planScreenId;
    body[Constant.seatsF1] = seatsF1;
    body[Constant.listChairValueF1] = listChairValueF1;
    body[Constant.customerFirstName] = customerFirstName;
    body[Constant.customerLastName] = customerLastName;
    body[Constant.paymentMethodSystemName] = paymentMethodSystemName;
    final AVResponse response =
        await callPOST(path: URL.createOrder, body: body,header: <String,String>{
          Constant.contentType:'application/json'
        });

    if (response.isOK) {
      print('It works order');
      final Order order =
          Order.fromJson(response.response as Map<String, dynamic>);

      return order;
    } else {
      throw APIException(response);
    }
  }
}
