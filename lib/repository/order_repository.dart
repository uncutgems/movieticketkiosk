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
//    body['Content-Type'] = 'application/json';
    final AVResponse response =
        await callPOST(path: URL.createOrder, body: body);

    if (response.isOK) {
      print('It works order');
      final Order order =
          Order.fromJson(response.response as Map<String, dynamic>);

      return order;
    } else {
      throw APIException(response);
    }
  }

  Future<QRObject> createQrOrder(int qrId) async{
    final Map<String, dynamic> body = <String, dynamic>{};
    final AVResponse response =
    await callPOST(path: '${URL.createQrOrder}?OrderId=$qrId',body: body);
    if (response.isOK) {
//      print('It works QR');
      final QRObject qrObject =
      QRObject.fromJson(response.response as Map<String, dynamic>);
      return qrObject;
    }
    else{
      throw APIException(response);
    }
  }
  Future<OrderStatus> checkOrder(int orderId) async{
    final Map<String, dynamic> body = <String, dynamic>{};
    final AVResponse response =
    await callPOST(path: '${URL.checkOrder}?orderId=$orderId',body: body);
    if (response.isOK) {
      print('It works QR');
      final OrderStatus orderStatus =
      OrderStatus.fromJson(response.response as Map<String, dynamic>);
      return orderStatus;
    }
    else{
      throw APIException(response);
    }
  }
}
