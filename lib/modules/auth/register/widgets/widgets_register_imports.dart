import 'dart:io';

import 'package:e_shop/modules/auth/register/controller/register_cubit.dart';
import 'package:e_shop/modules/auth/register/controller/register_state.dart';
import 'package:e_shop/modules/auth/widgets/auth_imports.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/components/reusable/buttons/custom_rounded_button.dart';
import 'package:e_shop/shared/components/reusable/buttons/custom_text_button.dart';
import 'package:e_shop/shared/components/reusable/container/curved_bottom_sheet_container.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/custom_divider.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/components/reusable/text/custom_text.dart';
import 'package:e_shop/shared/components/reusable/text_field/signing_text_field.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'register_header_builder.dart';
part 'register_form_field_builder.dart';
part 'register_agree_with_me.dart';
part 'register_sign_up_button.dart';