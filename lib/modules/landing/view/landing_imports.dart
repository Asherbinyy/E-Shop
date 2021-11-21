import 'package:e_shop/modules/auth/register/view/register_imports.dart';
import 'package:e_shop/shared/components/reusable/padding/main_padding.dart';

import '../widgets/widgets_landing_imports.dart';
import '../../../shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../helpers/local/shared_pref/cache_helper.dart';
import '../../../helpers/local/shared_pref/cached_values.dart';
import '../../../services/methods/operating_system_options.dart';
import '../../../services/routing/navigation.dart';
import '../../../shared/components/reusable/play_animation/play_animation.dart';
import '../../../shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../shared/components/builders/myConditional_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/landing_cubit.dart';
import '../cubit/landing_states.dart';

part 'landing_screen.dart';
part 'landing_wrapper.dart';

