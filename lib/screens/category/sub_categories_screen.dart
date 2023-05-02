import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../controllers/sub_categories_controller.dart';
import '../../models/CategoryModel.dart';

class SubCategoriesScreen extends StatelessWidget {

  static String routerName = '/subCategories_screen';

  const SubCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subCategoriesController = Get.put(SubCategoriesController());
    var isDesktop = context.width >1000;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subCategoriesController.categoryName.value,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() => subCategoriesController.isLoading.value
          ? Center(child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),)
          : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,30,30,0),
                  child: Obx(()=>
                      subCategoriesController.subCategories.length >0
                      ?GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: subCategoriesController.subCategories.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isDesktop ? 4 : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: index % 2 == 1
                                    ? AppColors.lightBlue
                                    : AppColors.lightPurple),
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        14, 14, 0, 0),
                                    child: Text(
                                      subCategoriesController.subCategories[index].name,
                                      style: AppTextStyles.h2
                                          .copyWith(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: isDesktop
                                        ? MediaQuery.of(context).size.width / 4 * 0.7
                                        : MediaQuery.of(context).size.width / 3 * 0.7,
                                    child: Image.network(
                                      subCategoriesController.subCategories[index].image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                      :Center(
                        child: Text(
                        subCategoriesController.categoryName + ' Menu is updating'),
                      ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
