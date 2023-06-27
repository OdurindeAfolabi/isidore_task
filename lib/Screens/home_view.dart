import 'package:flutter/material.dart';
import 'package:isidore_task/Providers/contact_provider.dart';
import 'package:isidore_task/Utils/assets_manager.dart';
import 'package:isidore_task/Utils/color_manager.dart';
import 'package:isidore_task/Utils/font_manager.dart';
import 'package:isidore_task/Utils/helpers.dart';
import 'package:isidore_task/Utils/styles_manager.dart';
import 'package:isidore_task/Utils/values_manager.dart';
import 'package:isidore_task/models/CreateContactRequest.dart';
import 'package:isidore_task/widgets/add_new_contact_bottom_sheet.dart';
import 'package:isidore_task/widgets/custom_contact_card.dart';
import 'package:isidore_task/widgets/d_loader.dart';
import 'package:isidore_task/widgets/update_contact_bottom_sheet.dart';
import 'package:stacked/stacked.dart';
import '../Providers/view_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/error_screen.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactProvider>.reactive(
      viewModelBuilder: () => ContactProvider(),
      onViewModelReady: (v) async {
        v.setBuildContext(context);
        v.getContacts();
      },
      builder: (BuildContext context, ContactProvider viewModel, Widget? child) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(left: AppPadding.p8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi,",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s20)),
                    const SizedBox(height: AppSize.s7,),
                    Text("How are you doing today",style: getRegularStyle(color: ColorManager.isidoreGrey,fontSize: FontSize.s14)),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p24),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: ColorManager.secondaryLight,
                    child: Icon(
                      Icons.notifications,
                      color: ColorManager.black,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: ColorManager.white,
            body: _buildBody(viewModel)
        );
      },
    );
  }

  Widget _buildBody(ContactProvider contactProvider){
    switch (contactProvider.viewState.state) {
      case ResponseState.LOADING:
        return const DLoader();
      case ResponseState.COMPLETE:
        return RefreshIndicator(
          onRefresh: () {
            return contactProvider.getContacts();
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24,vertical: AppPadding.p24),
              child: (contactProvider.viewState.data ?? []).isEmpty ? emptyContactListView(contactProvider) : contactListView(contactProvider)
          ),
        );
      case ResponseState.ERROR:
        return Padding(
          padding: EdgeInsets.only(top: heightSizer(100, context)),
          child: ErrorScreen(
            errorMessage: contactProvider.viewState.exception ?? "Request failed",
            onPressed: () {
              contactProvider.getContacts();
            },
          ),
        );
      case ResponseState.EMPTY:
        return const SizedBox();
    }
  }
  Widget contactListView(ContactProvider contactProvider){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "My Contacts",
                style: getBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s18)
            ),
            InkWell(
              onTap: (){
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    enableDrag: true,
                    isDismissible: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return AddNewContactBottomSheet(
                        onContactAdded: (ContactInput input){
                          contactProvider.addNewContact(
                              createContactRequest: CreateContactRequest(
                                contactInput: ContactInput(
                                    name: input.name,
                                    phone: input.phone,
                                    email: input.email,
                                    address: input.address,
                                    discarded: input.discarded
                                ),
                              ),
                              context: context);
                        },
                      );
                    }
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12,vertical: AppPadding.p8),
                decoration: BoxDecoration(
                    color: ColorManager.secondary,
                    borderRadius: BorderRadius.circular(AppSize.s8)
                ),
                child: Icon(
                  Icons.add,
                  color: ColorManager.white,
                  size: AppSize.s24,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: AppSize.s24,),
        Expanded(
          child: ListView.separated(
              itemCount: (contactProvider.viewState.data ?? []).length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          enableDrag: true,
                          isDismissible: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return UpdateContactBottomSheet(
                              contactDetails: (contactProvider.viewState.data ?? [])[index],
                              onContactUpdated: (ContactInput input){
                                contactProvider.updateContact(
                                    createContactRequest: CreateContactRequest(
                                      contactInput: ContactInput(
                                          id: input.id,
                                          name: input.name,
                                          phone: input.phone,
                                          email: input.email,
                                          address: input.address,
                                          discarded: input.discarded
                                      ),
                                    ),
                                    context: context);
                              },
                            );
                          });
                    },
                    child: CustomContactCard(contactDetails: (contactProvider.viewState.data ?? [])[index]));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: AppSize.s16,);
              }),
        ),
      ],
    );
  }

  Widget emptyContactListView(ContactProvider contactProvider){
    return Column(
      children: [
        SizedBox(height: heightSizer(AppSize.s70, context),),
        Image.asset(ImageAssets.emptyContactImage,height: AppSize.s100,width: AppSize.s100,),
        const SizedBox(height: AppSize.s24,),
        Text("No contacts",style: getSemiBoldStyle(color: ColorManager.secondary,fontSize: FontSize.s20)),
        const SizedBox(height: AppSize.s24,),
        Text("To start adding your contacts, tap on the \"Add\" button below",
            textAlign: TextAlign.center,
            style: getSemiBoldStyle(color: ColorManager.isidoreGrey,fontSize: FontSize.s16)),
        const SizedBox(height: AppSize.s24,),
        SizedBox(
          width: AppSize.s200,
          child: CustomButton(
              onPressed: (){
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    enableDrag: true,
                    isDismissible: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return AddNewContactBottomSheet(
                        onContactAdded: (ContactInput input){
                          contactProvider.addNewContact(
                              createContactRequest: CreateContactRequest(
                                contactInput: ContactInput(
                                    name: input.name,
                                    phone: input.phone,
                                    email: input.email,
                                    address: input.address,
                                    discarded: input.discarded
                                ),
                              ),
                              context: context);
                        },
                      );
                    }
                );
              },
              buttonText: "Add"),
        )
      ],
    );
  }
}
