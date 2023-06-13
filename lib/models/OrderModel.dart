import 'CartItemModel.dart';

class OrderModel {
  final List<CartItemModel> items;
  final String orderid;
  final String uid;
  final String recipient;
  final String phoneNo;
  final String address;
  final String payment;
  final String status;
  final String total;
  final String orderDay;
  final bool cancelRequest;

  OrderModel(
      {required this.items,
      required this.orderid,
      required this.uid,
      required this.recipient,
      required this.phoneNo,
      required this.address,
      required this.payment,
      required this.status,
      required this.total,
      required this.orderDay,
      required this.cancelRequest
      });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemJsonList =
        this.items.map((item) => item.toJson()).toList();

    return {
      'items': itemJsonList,
      'orderid': this.orderid,
      'uid': this.uid,
      'recipient': this.recipient,
      'phoneNo': this.phoneNo,
      'address': this.address,
      'payment': this.payment,
      'status': this.status,
      'total': this.total,
      'orderDay': this.orderDay,
      'cancelRequest': this.cancelRequest,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemList = json['items'];
    List<CartItemModel> itemModelList =
        itemList.map((item) => CartItemModel.fromJson(item)).toList();

    return OrderModel(
      items: itemModelList,
      orderid: json['orderid'] ?? '',
      uid: json['uid'] ?? '',
      recipient: json['recipient'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      address: json['address'] ?? '',
      payment: json['payment'] ?? '',
      status: json['status'] ?? '',
      total: json['total'] ?? '',
      orderDay: json['orderDay'] ?? '',
      cancelRequest: json['cancelRequest'] ?? '',
    );
  }
}
