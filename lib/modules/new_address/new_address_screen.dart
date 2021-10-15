import '/shared/components/reusable/app_bar/secondary_app_bar.dart';
import '/models/app/address_stepper_data.dart';
import '/models/app/stepper/stepper_controller.dart';
import '/models/app/stepper/stepper_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/home_cubit.dart';
import '../../layout/cubit/home_states.dart';
import '../../shared/components/builders/myConditional_builder.dart';
import '../../shared/components/reusable/spaces/spaces.dart';
import '../../styles/constants.dart';
import 'cubit/address_cubit.dart';
import 'cubit/address_states.dart';
import 'stepper/address_stepper.dart';
///REVIEWED
class NewAddressScreen extends StatelessWidget {
  final String heroTag;
  const NewAddressScreen({Key? key,required this.heroTag}) : super(key: key);
  void _newAddressListener(BuildContext context,AddressStates state){
    if (state is AddNewAddressSuccessState){
      if (state.newAddressModel!.status!) DefaultDialogue.showSnackBar(context, state.newAddressModel!.message!, dialogueStates: DialogueStates.SUCCESS);
      HomeCubit.get(context).getAddresses();
      StepperControllers.clear();
      navigateBack(context);
    }
    if (state is AddNewAddressErrorState){
      DefaultDialogue.showSnackBar(context, state.error, dialogueStates: DialogueStates.ERROR);
      StepperControllers.clear();
      navigateBack(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>  AddressCubit(),
        child: BlocConsumer<AddressCubit, AddressStates>(
          listener: (context, state) =>_newAddressListener(context, state),
          builder: (context, state) {
            var addressCubit = AddressCubit.get(context);
            return BlocConsumer<HomeCubit, HomeStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var profile = HomeCubit.get(context).profileModel?.data;
                return Builder(
                    builder: (context) {
                  /// returns List of steps used in the Stepper Widget
                  List <Step> _steps () => AddressStepperData.data.map((item) => Step(
                        state: addressCubit.currentStep > item.index
                            ? StepState.complete
                            : StepState.indexed,
                        isActive: addressCubit.currentStep >= item.index,
                        title: StepperTitle(item.title),
                        subtitle: addressCubit.currentStep == item.index
                            ? StepperSubTitle(item.subTitle)
                            : null,
                        content: item.content,
                      ),).toList();
                  var stepperLength = _steps().length;
                  var isLastStep = addressCubit.currentStep == _steps().length - 1;
                  var isFirst = addressCubit.currentStep == 0;
                  return Scaffold(
                      appBar: SecondaryAppBar(
                        title:'add_new_address'.tr(),
                      ),
                      body: MyConditionalBuilder(
                        condition: profile != null,
                        builder: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            physics:const BouncingScrollPhysics(),
                            child: Stepper(
                              type: StepperType.vertical,
                              physics: const BouncingScrollPhysics(),
                              currentStep: addressCubit.currentStep,
                              controlsBuilder: (context, {onStepContinue,onStepCancel}){
                                return _StepperButtons(
                                    addressCubit: addressCubit,
                                    isLastStep: isLastStep,
                                    isFirst: isFirst,
                                  onStepContinue: onStepContinue,
                                  onStepCancel: onStepCancel,
                                );
                              },
                              onStepTapped: (index) =>
                                  addressCubit.changeStep(index,stepperLength,StepperFormKeys.stepperKeys),
                              onStepContinue: () =>
                                  addressCubit.onStepContinue(stepperLength, StepperFormKeys.stepperKeys),
                              onStepCancel: () => addressCubit.onStepCancel(),
                              steps: _steps(),
                            ),
                          ),
                        ),
                        feedback:const Center(
                          child: kLoadingWanderingCubes,
                        ),
                      ),
                  );
                });
              },
            );
          },
        ),
    );
  }
}

class _StepperButtons extends StatelessWidget {
  const _StepperButtons({
    Key? key,
    required this.addressCubit,
    required this.isLastStep,
    required this.isFirst,
    required this.onStepContinue,
    required this.onStepCancel,
  }) : super(key: key);

  final AddressCubit addressCubit;
  final bool isLastStep;
  final bool isFirst;
  final VoidCallback ? onStepContinue;
  final VoidCallback ? onStepCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
        child:
        addressCubit.currentStep!=3 ?
        Row(
          children: [
               Expanded(
                    child:  ElevatedButton(
                        onPressed:onStepContinue,
                        child: Text(isLastStep
                            ? 'finish'.tr().toUpperCase()
                            : 'next'.tr().toUpperCase()))),
                XSpace.normal,
                if (!isLastStep && !isFirst)
                  Expanded(
                      child: OutlinedButton(
                          onPressed: onStepCancel,
                          child: Text(
                              'back'.tr().toUpperCase()))),
              ],
            )
            : null,
          );
  }
}



