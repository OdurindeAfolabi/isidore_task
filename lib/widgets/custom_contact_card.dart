import 'package:flutter/material.dart';
import 'package:isidore_task/Utils/color_manager.dart';
import 'package:isidore_task/Utils/font_manager.dart';
import 'package:isidore_task/Utils/size_config.dart';
import 'package:isidore_task/Utils/string_methods.dart';
import 'package:isidore_task/Utils/styles_manager.dart';
import 'package:isidore_task/Utils/values_manager.dart';
import 'package:isidore_task/models/GetContactModel.dart';
class CustomContactCard extends StatelessWidget {
  final Contacts contactDetails;
  const CustomContactCard({Key? key, required this.contactDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.initializeSize(context);
    return Container(
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: ColorManager.white,
          border: Border.all(color: ColorManager.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          // color: AppColors.primaryColor,
        ),
        width: SizeConfig.screenWidth,
        // height: 100,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ColorManager.orangeLight,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  // color: AppColors.primaryColor,
                ),
                // height: 40,
                width: SizeConfig.screenWidth,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          contactDetails.name.addOverFlow,
                          style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16)
                        ),
                        const Icon(
                          Icons.more_vert,
                          size: AppSize.s24,
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone,
                                size: 20,
                                color: ColorManager.grey4,
                              ),
                              const SizedBox(width: 5,),
                              Text(contactDetails.phone ?? "",style: getRegularStyle(color: ColorManager.contactCardTextColor,fontSize: FontSize.s16))
                            ],
                          ),
                          const SizedBox(width: 16,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 20,
                                color: ColorManager.grey4,
                              ),
                              const SizedBox(width: 5,),
                              Text(contactDetails.email ?? "",style: getRegularStyle(color: ColorManager.contactCardTextColor,fontSize: FontSize.s16))
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: ColorManager.grey4,
                        ),
                        const SizedBox(width: 5,),
                        Expanded(child: Text(contactDetails.address ?? "",style: getRegularStyle(color: ColorManager.contactCardTextColor,fontSize: FontSize.s16)))
                      ],
                    )
                  ],
                ),
              )
            ]));
  }
}
