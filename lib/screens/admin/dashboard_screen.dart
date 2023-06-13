import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/themes/app_colors.dart';
import 'package:food_delivery_app/config/themes/app_text_styles.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../controllers/dashboard_controller.dart';
import '../../services/firebase_service.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);
  final dashBoardController = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    List<Data> data =[
      Data(name: "Product",count: 52,color: Colors.blue),
      Data(name: "User",count: 7,color: Colors.yellowAccent),
      Data(name: "Order",count: 23,color: Colors.purple),
      Data(name: "Category",count: 15,color: Colors.green)
    ];
    dashBoardController.touchedIndex.value = -1;
    final isDesktop = context.width > 1000;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Dashboard',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                icon: Icon(
                    Icons.login,
                    color: const Color(0xFF0000FF),
                    size: 34.0),
                onPressed: (){
                  dashBoardController.signOut();
                }
            ),
          ],
        ),
        body: Obx(() {
          if (dashBoardController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          GridView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isDesktop ? 4 : 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: isDesktop ? 2 : 1.8,
                            ),
                            children: [
                              Obx(
                                () => analytic_card(
                                    title: 'Revenue',
                                    data:
                                    '\$${dashBoardController.revenue.value.toStringAsFixed(2)}',
                                    icon: Icons.monetization_on_outlined,
                                    color: AppColors.darkBlue,
                                    isDesktop: isDesktop),
                              ),
                              Obx(() => analytic_card(
                                  title: 'Orders',
                                  data: dashBoardController.orders.value
                                      .toString(),
                                  icon: Icons.shopping_cart_rounded,
                                  color: AppColors.primaryColor,
                                  isDesktop: isDesktop)),
                              Obx(
                                () => analytic_card(
                                    title: 'Products ',
                                    data: dashBoardController.products.value
                                        .toString(),
                                    icon: Icons.shopping_bag_rounded,
                                    color: AppColors.error,
                                    isDesktop: isDesktop),
                              ),
                              Obx(
                                () => analytic_card(
                                    title: 'Users',
                                    data: dashBoardController.users.value
                                        .toString(),
                                    icon: Icons.account_circle_outlined,
                                    color: AppColors.yellow,
                                    isDesktop: isDesktop),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.blueDarkColor,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                          ),
                          child: Center(child: Text(
                            'Sales chart',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),),
                        ),
                        Container(
                          width: double.infinity,
                          height: isDesktop?context.height*0.5:context.height*0.4,
                          decoration: BoxDecoration(
                            color: AppColors.blueDarkColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24),bottomRight: Radius.circular(24))
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: BarChart(
                                BarChartData(
                                  barGroups: _barGroups(),
                                  borderData: FlBorderData(
                                      show: false),
                                  gridData: FlGridData(show: false),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Center(child: Text(
                      'Statistics Pie Chart',
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),),
                  ),
                  Row(
                      children: [
                        Container(
                          width: context.width*0.6,
                          height: context.height*0.5,
                          child: Center(
                            child: Obx(() {
                              return PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions || pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection == null) {
                                        dashBoardController.touchedIndex.value = -1;
                                        return;
                                      }
                                      dashBoardController.touchedIndex.value = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 50,
                                  sections: getSections(dashBoardController.touchedIndex.value),
                                ),
                              );
                            }),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: IndicatorsWidget( value: dashBoardController.dataPie.value),
                            ),
                          ],
                        ),
                      ],
                  )
                ],
              ),
            );
          }
        }));
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );
  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = 'Mn';
          break;
        case 1:
          text = 'Te';
          break;
        case 2:
          text = 'Wd';
          break;
        case 3:
          text = 'Th';
          break;
        case 4:
          text = 'Fr';
          break;
        case 5:
          text = 'Sa';
          break;
        case 6:
          text = 'Su';
          break;
      }
      return Text(
        text,
        style: TextStyle(color: AppColors.white,fontSize: 16),
      );
    },
  );
  List<BarChartGroupData>  _barGroups(){
    List<BarChartGroupData> list = List<BarChartGroupData>.empty(growable: true);
    dashBoardController.statisticalList.sort((a, b) => a.day.compareTo(b.day));
    for (int i = 0; i < dashBoardController.statisticalList.length; i++) {
      list.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(toY: dashBoardController.statisticalList[i].profit.roundToDouble(), color: AppColors.secondColor,width: 18)
      ]));
    }
    return list;
  }
  List<PieChartSectionData> getSections(int touchedIndex) =>dashBoardController.dataPie.value.asMap()
      .map<int, PieChartSectionData>((index,data){
        final isTouched = index == touchedIndex;
        final double fontSize = isTouched ? 25 : 16;
        final double radius = isTouched ? 70 : 50;
        final value = PieChartSectionData(
          color: data.color,
          value: data.count.toDouble(),
          title: data.count.toString(),
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );
        return MapEntry(index, value);
      }).values.toList();
}

class analytic_card extends StatelessWidget {
  analytic_card({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
    required this.color,
    required this.isDesktop,
  });

  final String title;
  final String data;
  final IconData icon;
  final Color color;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: isDesktop
              ? EdgeInsets.all(20.0)
              : EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.toString(),
                    style: AppTextStyles.h2.copyWith(
                      fontSize: isDesktop ? 18 : 12,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Icon(
                        icon,
                        color: AppColors.white,
                      ))
                ],
              ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.h2.copyWith(
                  fontSize: isDesktop ? 20 : 13,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class IndicatorsWidget extends StatelessWidget {
  IndicatorsWidget({
    required this.value,
  });
  final List value;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: value
        .map(
          (data) => Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: buildIndicator(
            color: data.color,
            text: data.name,
            // isSquare: true,
          )),
    )
        .toList(),
  );

  Widget buildIndicator({
    required Color color,
    required String text,
    bool isSquare = false,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) =>
      Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
        ],
      );
}