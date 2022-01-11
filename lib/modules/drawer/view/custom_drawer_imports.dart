import 'package:e_shop/helpers/local/shared_pref/cache_helper.dart';
import 'package:e_shop/helpers/local/shared_pref/cached_values.dart';
import 'package:e_shop/modules/auth/login/view/login_imports.dart';
import 'package:e_shop/modules/drawer/widgets/widgets_custom_drawer_imports.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/custom_divider.dart';
import 'package:e_shop/shared/flutter_phoenix.dart';
import '../../email_verification/view/email_verification_screen.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';

part 'custom_drawer_screen.dart';
part 'custom_drawer_wrapper.dart';