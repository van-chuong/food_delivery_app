class StatisticalModel {
  final String id;
  final String day;
  final int ordersTotal;
  final double profit;
  final double sales;

  StatisticalModel({
    required this.id,
    required this.day,
    required this.ordersTotal,
    required this.profit,
    required this.sales,
  });

  factory StatisticalModel.fromJson(Map<String, dynamic> json) {
    return StatisticalModel(
      id: json['id'] as String  ?? '',
      day: json['day'] as String  ?? '',
      ordersTotal: json['ordersTotal'] as int  ?? 0,
      profit: json['profit'].toDouble()  ?? 0.0,
      sales: json['sales'].toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'day': day,
    'ordersTotal': ordersTotal,
    'profit': profit,
    'sales': sales,
  };
}
