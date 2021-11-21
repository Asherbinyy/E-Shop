import 'package:e_shop/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/models/api/user/profile.dart';
import 'package:e_shop/styles/constants/constants.dart';
import '/shared/components/reusable/play_animation/play_animation.dart';
import '/shared/components/builders/myConditional_builder.dart';
import '/shared/components/reusable/buttons/simple_rounded_button.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

part 'forgot_password_screen.dart';