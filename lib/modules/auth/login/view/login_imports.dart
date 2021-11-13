import 'package:e_shop/modules/auth/login/provider/login_provider.dart';
import 'package:e_shop/modules/auth/register/controller/register_cubit.dart';
import 'package:e_shop/modules/auth/register/view/register_imports.dart';
import 'package:e_shop/modules/change_password/view/change_password_screen.dart';
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/components/reusable/buttons/signing_button.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/components/reusable/text_field/signing_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../helpers/local/shared_pref/cache_helper.dart';
import '../../../../helpers/local/shared_pref/cached_values.dart';
import '../controller/login_cubit.dart';
import '../controller/login_states.dart';
import '../widgets/widgets_login_imports.dart';
import '../../../welcome_message/view/import_welcome_messages.dart';
import '../../../../shared/cubits/app_cubit/app_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../services/routing/navigation.dart';
import '../../../../styles/constants/constants.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';


part 'login_screen.dart';
part 'login_wrapper.dart';