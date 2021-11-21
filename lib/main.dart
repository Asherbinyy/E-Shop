import 'services/methods/app_initializer_service.dart';
import 'shared/models/app/cached_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'e_shop.dart';
import 'helpers/local/shared_pref/cache_helper.dart' show CacheHelper;
import 'helpers/local/shared_pref/cached_values.dart';

void main() async {



  await AppInitializer.initializeApp();

  // cached data
  CachedSettingsModel settings = CachedSettingsModel(
    colorIndex: CacheHelper.getData(COLOR_INDEX) ?? 2,
    isDark: CacheHelper.getData(DARK_MODE) ?? false,
    appFontSize: CacheHelper.getData(FONT_SIZE) ?? 1.0,
  );
  runApp(
    Phoenix(
      child: EShop(
        settings: settings,
      ),
    ),
  );
}
