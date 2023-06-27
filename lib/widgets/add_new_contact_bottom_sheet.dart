import 'package:flutter/material.dart';
import 'package:isidore_task/Utils/size_config.dart';
import 'package:isidore_task/Utils/values_manager.dart';
import 'package:isidore_task/models/CreateContactRequest.dart';

import '../Utils/color_manager.dart';
import '../Utils/font_manager.dart';
import '../Utils/helpers.dart';
import '../Utils/styles_manager.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';
class AddNewContactBottomSheet extends StatefulWidget {
  final void Function(ContactInput contactInput) onContactAdded;
  const AddNewContactBottomSheet({Key? key, required this.onContactAdded}) : super(key: key);

  @override
  State<AddNewContactBottomSheet> createState() => _AddNewContactBottomSheetState();
}

class _AddNewContactBottomSheetState extends State<AddNewContactBottomSheet> {
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactPhoneNumberController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController contactHomeAddressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig.initializeSize(context);
    return Container(
      height: SizeConfig.screenHeight * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24,vertical: AppPadding.p16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text("Add Contact",style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s24)),
            SizedBox(height: getProportionateScreenHeight(AppSize.s45),),
            TxtForm(
              textHeader: Text("Name",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16),),
              editingController: contactNameController,
              textFieldHint: "Contact Name",
              keyboardType: TextInputType.text,
              validator: Validators().isEmpty,),
            const SizedBox(height: AppSize.s24,),
            TxtForm(
              textHeader: Text("Phone",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16),),
              editingController: contactPhoneNumberController,
              textFieldHint: "+234",
              keyboardType: TextInputType.phone,
              validator: Validators().isPhone,),
            const SizedBox(height: AppSize.s24,),
            TxtForm(
              textHeader: Text("Email",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16),),
              editingController: contactEmailController,
              textFieldHint: "example@gmail.com",
              keyboardType: TextInputType.emailAddress,
              validator: Validators().isEmail,),
            const SizedBox(height: AppSize.s24,),
            TxtForm(
              textHeader: Text("Home Address",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s16),),
              editingController: contactHomeAddressController,
              textFieldHint: "Enter address of contact",
              keyboardType: TextInputType.text,
              validator: Validators().isEmpty,),
            const SizedBox(height: AppSize.s24,),
            CustomButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    Navigator.pop(context);
                    widget.onContactAdded(
                      ContactInput(
                        name: contactNameController.text,
                        phone: contactPhoneNumberController.text,
                        email: contactEmailController.text,
                        address: contactHomeAddressController.text,
                        discarded: false
                      )
                    );
                  }
                }, buttonText: "Add Contact"),
          ],
        ),
      ),
    );
  }
}
