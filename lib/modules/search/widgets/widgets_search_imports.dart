import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/modules/product_details/view/product_details.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_state.dart';
import 'package:e_shop/shared/models/api/search/search.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';


part 'search_scaffold.dart';
part 'search_item.dart';
part 'search_item_like_button.dart';
part 'search_item_product_image.dart';
part 'search_item_product_info.dart';
part 'search_no_item_found.dart';
part 'search_builder_results.dart';
part 'search_builder_listview.dart';
part 'search_builder.dart';