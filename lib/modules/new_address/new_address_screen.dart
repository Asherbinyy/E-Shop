import 'package:e_shop/models/app/address_stepper_data.dart';
import 'package:e_shop/modules/addresses/addresses_screen.dart';
import 'package:e_shop/shared/components/methods/navigation.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/home_cubit.dart';
import '../../layout/cubit/home_states.dart';
import '../../shared/components/builders/myConditional_builder.dart';
import '../../shared/components/reusable/spaces/spaces.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../styles/constants.dart';
import 'cubit/address_cubit.dart';
import 'cubit/address_states.dart';
import 'stepper/address_stepper.dart';

/// returns List of formKeys used in the Stepper Widget
class StepperFormKeys {
  StepperFormKeys._();
  static var step1 = GlobalKey<FormState>(debugLabel: 'step1');
  static var step2 = GlobalKey<FormState>(debugLabel: 'step2');
  static List<GlobalKey<FormState>> stepperKeys = [
    step1,
    step2,
  ];
}

/// returns List of controllers used in the Stepper Widget
class StepperControllers {
  StepperControllers._();
  static final TextEditingController name = TextEditingController();
  static final TextEditingController phone = TextEditingController();
  static final TextEditingController city = TextEditingController();
  static final TextEditingController details = TextEditingController();
  static final TextEditingController region = TextEditingController();
  static final TextEditingController notes = TextEditingController();
  static void clear() {
    name.clear();
    phone.clear();
    city.clear();
    details.clear();
    region.clear();
    notes.clear();
  }
}

class NewAddressScreen extends StatelessWidget {
  final heroTag;
  const NewAddressScreen(this.heroTag, {Key? key}) : super(key: key);
  void _newAddressListener(BuildContext context,AddressStates state){
    if (state is AddNewAddressSuccessState){
      if (state.newAddressModel!.status!) DefaultDialogue.showSnackBar(context, state.newAddressModel!.message!, dialogueStates: DialogueStates.SUCCESS);
      HomeCubit.get(context).getAddresses();
      StepperControllers.clear();
      navigateFrom(context);
    }
    if (state is AddNewAddressErrorState){
      DefaultDialogue.showSnackBar(context, state.error, dialogueStates: DialogueStates.ERROR);
      StepperControllers.clear();
      navigateFrom(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddressCubit(),
        child: BlocConsumer<AddressCubit, AddressStates>(
          listener: (context, state) =>_newAddressListener(context, state),
          builder: (context, state) {
            AddressCubit addressCubit = AddressCubit.get(context);
            return BlocConsumer<HomeCubit, HomeStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var profile = HomeCubit.get(context).profileModel?.data;
                return Builder(builder: (context) {

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

                  bool isDark = AppCubit.get(context).isDark;
                  int stepperLength = _steps().length;
                  bool isLastStep = addressCubit.currentStep == _steps().length - 1;
                  bool isFirst = addressCubit.currentStep == 0;


                  return Scaffold(
                      appBar: AppBar(
                        title: const Text('Add New Address'),
                      ),
                      body: MyConditionalBuilder(
                        condition: profile != null,
                        builder: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Stepper(
                              type: StepperType.vertical,
                              physics: const BouncingScrollPhysics(),
                              currentStep: addressCubit.currentStep,
                              controlsBuilder: (context, {onStepContinue,onStepCancel}){
                                return
                                  Container(
                                    child: addressCubit.currentStep!=3 ?Row(
                                          children: [
                                           Expanded(
                                                child: ElevatedButton(
                                                    onPressed:onStepContinue,
                                                    child: Text(isLastStep
                                                        ? 'Finish'.toUpperCase()
                                                        : 'Next'.toUpperCase()))),
                                            XSpace.normal,
                                            if (!isLastStep && !isFirst)
                                              Expanded(
                                                  child: OutlinedButton(
                                                      onPressed: onStepCancel,
                                                      child: Text(
                                                          'Back'.toUpperCase()))),
                                          ],
                                        ):null,
                                      );
                              },
                              onStepTapped: (index) =>
                                  addressCubit.changeStep(index,stepperLength,StepperFormKeys.stepperKeys),
                              onStepContinue: () => addressCubit.onStepContinue(
                                  stepperLength, StepperFormKeys.stepperKeys),
                              onStepCancel: () => addressCubit.onStepCancel(),
                              steps: _steps(),
                            ),
                          ),
                        ),
                        feedback:const Center(
                          child: kLoadingWanderingCubes,
                        ),
                      ));
                });
              },
            );
          },
        ));
  }
}



