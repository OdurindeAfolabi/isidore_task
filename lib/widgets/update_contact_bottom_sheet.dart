import 'package:flutter/material.dart';
import 'package:isidore_task/Utils/size_config.dart';
import 'package:isidore_task/Utils/values_manager.dart';
import 'package:isidore_task/models/CreateContactRequest.dart';
import 'package:isidore_task/models/GetContactModel.dart';

import '../Utils/color_manager.dart';
import '../Utils/font_manager.dart';
import '../Utils/helpers.dart';
import '../Utils/styles_manager.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';
class UpdateContactBottomSheet extends StatefulWidget {
  final Contacts contactDetails;
  final void Function(ContactInput contactInput) onContactUpdated;
  const UpdateContactBottomSheet({Key? key, required this.onContactUpdated, required this.contactDetails}) : super(key: key);

  @override
  State<UpdateContactBottomSheet> createState() => _UpdateContactBottomSheetState();
}

class _UpdateContactBottomSheetState extends State<UpdateContactBottomSheet> {
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactPhoneNumberController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();
  final TextEditingController contactHomeAddressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactNameController.text = widget.contactDetails.name ?? "";
    contactPhoneNumberController.text = widget.contactDetails.phone ?? "";
    contactEmailController.text = widget.contactDetails.email ?? "";
    contactHomeAddressController.text = widget.contactDetails.address ?? "";
  }
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
            Text("Edit Contact",style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s24)),
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
                    widget.onContactUpdated(
                        ContactInput(
                            id: widget.contactDetails.id,
                            name: contactNameController.text,
                            phone: contactPhoneNumberController.text,
                            email: contactEmailController.text,
                            address: contactHomeAddressController.text,
                            discarded: false
                        )
                    );
                  }
                }, buttonText: "Update Contact"),
          ],
        ),
      ),
    );
  }
}
