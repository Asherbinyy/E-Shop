
import 'package:e_shop/modules/auth/register/controller/register_cubit.dart';
import 'package:e_shop/modules/auth/register/controller/register_state.dart';
import 'package:e_shop/modules/auth/register/widgets/widgets_register_imports.dart';
import 'package:e_shop/modules/auth/widgets/auth_imports.dart';
import 'package:e_shop/modules/layout/layout_screen.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_shop/helpers/local/shared_pref/cache_helper.dart';
import 'package:e_shop/helpers/local/shared_pref/cached_values.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/styles/constants/constants.dart';

part 'register_screen.dart';
part 'register_wrapper.dart';