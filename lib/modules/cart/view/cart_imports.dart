import 'package:e_shop/modules/cart/controller/cart_cubit.dart';
import 'package:e_shop/modules/cart/models/get_carts.dart';
import 'package:e_shop/modules/cart/widgets/cart_scaffold.dart';
import 'package:e_shop/shared/components/builders/product_card.dart';

import '../../layout/cubit/home_cubit.dart';
import '../../layout/cubit/home_states.dart';
import '../../../shared/cubits/app_cubit/app_cubit.dart';
import '../../../styles/constants/constants.dart';
import '../../../shared/components/builders/myConditional_builder.dart';
import '../../../shared/components/reusable/app_bar/secondary_app_bar.dart';
import '../../../shared/components/reusable/dialogue/default_dialogue.dart';
import '../../../shared/components/reusable/dialogue/swipe_to_delete_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/widgets_cart_imports.dart';


part 'cart_screen.dart';
part 'cart_wrapper.dart';