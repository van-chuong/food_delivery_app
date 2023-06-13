import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../controllers/user_manage_controller.dart';

class ManageUser extends StatelessWidget {
   ManageUser({Key? key}) : super(key: key);
  final userManageController = Get.put(UserManageController());
  @override
  Widget build(BuildContext context) {
    final isDesktop = context.width > 1000;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users Management',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
        body: Obx(() {
          if (userManageController.isLoading.value) {
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
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio:  isDesktop?4.5:1.8,
                            ),
                            children: [
                              Obx(()=>
                                  Container(
                                    // padding: EdgeInsets.symmetric(),
                                    decoration:
                                    BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(24)),
                                    child: InkWell(
                                      onTap: () {
                                        userManageController.finalUsers.value = userManageController.users;
                                      },
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
                                                  "Total of Users",
                                                  style: AppTextStyles.h2.copyWith(
                                                    fontSize: isDesktop ? 18 : 12,
                                                  ),
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(shape: BoxShape.circle),
                                                    child: Icon(Icons.shopping_bag_rounded, color: AppColors.white,
                                                    ))
                                              ],
                                            ),
                                            Text(
                                              userManageController.users.length.toString(),
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
                                  )
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(),
                                decoration:
                                BoxDecoration(color: AppColors.blueMain, borderRadius: BorderRadius.circular(24)),
                                child: InkWell(
                                  onTap: () {
                                    userManageController.finalUsers.value = userManageController.newUsers;
                                  },
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
                                              "New Users",
                                              style: AppTextStyles.h2.copyWith(
                                                fontSize: isDesktop ? 18 : 12,
                                              ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(shape: BoxShape.circle),
                                                child: Icon(Icons.access_time_filled_rounded, color: AppColors.white,
                                                ))
                                          ],
                                        ),
                                        Text(
                                          userManageController.newUsers.length.toString(),
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
                              )
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0),
                              child: Obx(()=>DataTable(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24)
                                ),
                                dataRowHeight: 120,
                                border: TableBorder.all(borderRadius: BorderRadius.circular(24),color: AppColors.grayMain),
                                columns: [
                                  DataColumn(label: Text('Avatar')),
                                  DataColumn(label: Text( 'Name')),
                                  DataColumn(label: Text('Email')),
                                  DataColumn(label: Text('Gender')),
                                  DataColumn(label: Text('Phone Number')),
                                  DataColumn(label: Text('Created At')),
                                  DataColumn(label: Text('Action')),
                                ],
                                rows: userManageController.finalUsers.map((user) => DataRow(cells: [
                                    DataCell(
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(24),
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: user.photoUrl!=null?Image.network(user.photoUrl??""):Image.network('https://firebasestorage.googleapis.com/v0/b/flutter-food-1a10d.appspot.com/o/images%2Favatar.png?alt=media&token=8d6b1806-bb94-4391-8977-aed51aa9efb5'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(user.fullName!)),
                                    DataCell(Text(user.email!)),
                                    DataCell(user.gender!=null?Text(user.gender!):Text("Not update")),
                                    DataCell(user.phoneNo!=null?Text(user.phoneNo!):Text("Not update")),
                                    DataCell(Text(user.createAt!)),
                                    DataCell(Center(child: Row(
                                      children: [
                                        InkWell(
                                          borderRadius: BorderRadius.circular(24),
                                          child: Icon(
                                            Icons.highlight_remove_rounded,
                                            color: AppColors.red,
                                          ),
                                          onTap: () async {
                                            Get.defaultDialog(
                                                title: 'Notification',
                                                middleText: 'Are you sure want to remove user?',
                                                textConfirm: 'Ok',
                                                textCancel: 'No',
                                                onConfirm: () async {
                                                  Get.back();
                                                },
                                                onCancel: (){Get.back();}
                                            );
                                          },
                                        ),

                                      ],
                                    ),)),
                                  ]),
                                ).toList(),
                              )),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            );
          }
        })
    );
  }
}
