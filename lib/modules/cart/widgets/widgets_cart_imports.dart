


import 'package:e_shop/modules/cart/controller/cart_cubit.dart';
import 'package:e_shop/modules/cart/models/get_carts.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/modules/order/view/order_screen.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/components/builders/product_card.dart';
import 'package:e_shop/shared/components/reusable/buttons/custom_text_button.dart';
import 'package:e_shop/shared/components/reusable/text/custom_text.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


part 'cart_expand_collapse_button.dart';
part 'cart_empty.dart';
part 'cart_footer_builder.dart';
part 'cart_builder.dart';