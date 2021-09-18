import 'package:e_shop/layout/cubit/home_cubit.dart';
import 'package:e_shop/layout/cubit/home_states.dart';
import 'package:e_shop/models/api/user/profile.dart';
import 'package:e_shop/modules/change_password/change_password_screen.dart';
import 'package:e_shop/modules/landing/landing_screen.dart';
import 'package:e_shop/modules/login/login_screen.dart';
import 'package:e_shop/network/local/cache_helper.dart';
import 'package:e_shop/network/local/cached_values.dart';
import 'package:e_shop/shared/components/methods/navigation.dart';
import 'package:e_shop/shared/components/reusable/buttons/rounded_button.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/components/reusable/text_field/secondary_text_field.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var _nameController = TextEditingController();
var _emailController = TextEditingController();
var _phoneController = TextEditingController();
var _formKey = GlobalKey<FormState>();

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState)
          DefaultDialogue.showSnackBar(context, state.updatedProfile.message!,
              dialogueStates: DialogueStates.SUCCESS);
        if (state is UpdateProfileErrorState)
          DefaultDialogue.showSnackBar(context, state.error,
              dialogueStates: DialogueStates.ERROR);
        if (state is SignOutSuccessState) {
          if (state.signOutModel.status!) {
            CacheHelper.removeData(TOKEN).then((value) {
              if (value) {
                navigateToAndFinish(context, LoginScreen());
              }
            });
          } else {
            DefaultDialogue.showSnackBar(context, state.signOutModel.message!,
                dialogueStates: DialogueStates.ERROR,
                isDark: AppCubit.get(context).isDark);
            Navigator.pop(context);
          }
        }
        if (state is SignOutErrorState) {
          Navigator.pop(context);
          DefaultDialogue.showSnackBar(context, 'Something went Wrong',
              dialogueStates: DialogueStates.ERROR,
              isDark: AppCubit.get(context).isDark);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        bool isDark = AppCubit.get(context).isDark;
        ProfileData? profile = cubit.profileModel?.data;

        _nameController.text = profile?.name ?? '';
        _emailController.text = profile?.email ?? '';
        _phoneController.text = profile?.phone ?? '';

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Profile'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            actions: [_editProfileButton(cubit)],
          ),
          body: MyConditionalBuilder(
            condition: profile != null,
            builder: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is UpdateProfileLoadingState)
                        _loadingProgress(),


                      _ProfileImageStack(profile: profile, cubit: cubit),
                      YSpace.hard,

                      _TextFieldBloc(isDark: isDark, cubit: cubit),
                      if (cubit.isEditableProfile)
                        // change password
                        TextButton(
                          onPressed: () =>
                              navigateTo(context, ChangePasswordScreen()),
                          child: const Text(
                            'Change Password ? ',
                            style:
                                const TextStyle(color: kSecondaryColorDarker),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (cubit.isEditableProfile) _updateButton(isDark, cubit),
                      YSpace.extreme,
                      _signOutButton(isDark, cubit),
                    ],
                  ),
                ),
              ),
            ),
            feedback: const Center(child: kLoadingWanderingCubes),
          ),
        );
      },
    );
  }

  Widget _signOutButton(bool isDark, HomeCubit cubit) => RoundedButton(
        label: 'log out',
        icon: Icons.logout,
        isIcon: true,
        color: isDark ? kSecondaryColorDarker : Colors.white,
        backgroundColor: isDark ? Colors.white : kSecondaryColorDarker,
        onPressed: () {
          cubit.signOut();
        },
      );

  Widget _updateButton(bool isDark, HomeCubit cubit) => RoundedButton(
        label: 'Update Profile',
        icon: Icons.upload_sharp,
        isIcon: true,
        color: isDark ? kSecondaryColorDarker : Colors.white,
        backgroundColor: isDark ? Colors.white : kSecondaryColorDarker,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            cubit.updateProfile(
              email: _emailController.text,
              name: _nameController.text,
              phone: _phoneController.text,
            );
            // sCubit.getProfileData();
          } else
            return null;
        },
      );

  Widget _loadingProgress() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: const LinearProgressIndicator(color: kSecondaryColorDarker),
      );

  Widget _editProfileButton(HomeCubit cubit) => TextButton(
        style: TextButton.styleFrom(primary: kSecondaryColorDarker),
        onPressed: () {
          cubit.toggleEditProfile();
        },
        child: cubit.isEditableProfile
            ? Text('Cancel')
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.edit),
                  XSpace.light,
                  Text('Edit Profile'),
                ],
              ),
      );
}

class _ProfileImageStack extends StatelessWidget {
  const _ProfileImageStack({
    Key? key,
    required this.profile,
    required this.cubit,
  }) : super(key: key);

  final ProfileData? profile;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              backgroundColor: kSecondaryColorDarker.withOpacity(0.3),
              radius: 70,
              child: CircleAvatar(
                radius: 60,
                backgroundColor:kSecondaryColorDarker.withOpacity(0.1),
              ),
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                // image
                Hero(
                  tag: ValueKey<String>('${profile?.id}'),
                  child: MyConditionalBuilder(
                    condition: profile?.image != null,
                    builder: cubit.pickedImage != null
                        ?
                        //TODO try to save pickedImage in shared Preference like token
                        CircleAvatar(
                            backgroundImage: FileImage(cubit.pickedImage!),
                            radius: 50,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage('${profile?.image}'),
                            radius: 50,
                          ),
                    feedback: CircleAvatar(
                      backgroundImage: AssetImage(kDefaultImage),
                      radius: 50,
                    ),
                  ),
                ),
                //editImageIcon
                if (cubit.isEditableProfile)
                  CircleAvatar(
                    backgroundColor: kSecondaryColorDarker,
                    radius: 18,
                    child: IconButton(
                      iconSize: 20,
                      onPressed: () => cubit.pickImage(),
                      // getImage ,
                      icon: Icon(Icons.camera_alt),
                      color: Colors.white,
                    ),
                  ),
              ],
            ),

          ],
        ),
       Column(
         children: [
           Tooltip(
             message:'Credits in you account is ${profile?.credit.toString()} ' ,
             child: Container(
               padding:const EdgeInsetsDirectional.all(10.0),
               decoration: BoxDecoration(
                   color: Colors.amber.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(25.0)
               ),
               child: Column(
                 children: [
                   Row(
                     children: [
                       const Icon(FontAwesomeIcons.coins,color: Colors.amber),
                       XSpace.normal,
                       const Text('Credits',style: TextStyle(color: Colors.amber)),
                     ],
                   ),
                   YSpace.normal,
                   Text('${profile?.credit.toString()} L.E',style: Theme.of(context).textTheme.caption),

                 ],
               ),
             ),
           ),
           YSpace.extreme,
           Tooltip(
             message:'Points in you account is ${profile?.credit.toString()} ' ,
             child: Container(
               padding: EdgeInsetsDirectional.all(10.0),
               decoration: BoxDecoration(
                   color: Colors.lightBlueAccent.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(25.0)),
               child: Column(
                 children: [
                   Row(
                     children: [
                       const Icon(FontAwesomeIcons.solidGem,color: Colors.lightBlueAccent),
                       XSpace.normal,
                       const Text('Points',style: TextStyle(color: Colors.lightBlueAccent)),
                     ],
                   ),
                   YSpace.normal,
                   Text('${profile?.points.toString()}',style: Theme.of(context).textTheme.caption),

                 ],
               ),
             ),
           ),
         ],
       ),
      ],
    );
  }
}

class _TextFieldBloc extends StatelessWidget {
  const _TextFieldBloc({
    Key? key,
    required this.isDark,
    required this.cubit,
  }) : super(key: key);

  final bool isDark;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SecondaryTextField(
            primaryColor: kSecondaryColorDarker,
            isDark: isDark,
            isFilled: cubit.isEditableProfile ? true : false,
            fillColor: isDark ? kDarkSecondaryColor : Colors.grey[100],
            readOnly: cubit.isEditableProfile ? false : true,
            controller: _nameController,
            keyboardType: TextInputType.name,
            label: 'Name',
            prefixIcon: Icons.person,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Name not be empty !';
              } else {
                return null;
              }
            },
          ),
          YSpace.hard,
          SecondaryTextField(
              primaryColor: kSecondaryColorDarker,
              isDark: isDark,
              isFilled: cubit.isEditableProfile ? true : false,
              fillColor: isDark ? kDarkSecondaryColor : Colors.grey[100],
              readOnly: cubit.isEditableProfile ? false : true,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              label: 'Email Address',
              prefixIcon: Icons.email,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'email must not be empty !';
                } else {
                  return null;
                }
              }),
          YSpace.hard,
          SecondaryTextField(
              primaryColor: kSecondaryColorDarker,
              isDark: isDark,
              isFilled: cubit.isEditableProfile ? true : false,
              fillColor: isDark ? kDarkSecondaryColor : Colors.grey[100],
              readOnly: cubit.isEditableProfile ? false : true,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              label: 'Phone Number',
              prefixIcon: Icons.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone Number not be empty !';
                } else {
                  return null;
                }
              }),
        ],
      ),
    );
  }
}
