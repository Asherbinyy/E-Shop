import 'package:bloc/bloc.dart';
import 'package:e_shop/network/local/cache_helper.dart';
import 'package:e_shop/network/local/cached_values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_state.dart';

class AppCubit extends Cubit <AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);



// // ThemeMode toggling ----------------------------------------------------------
  bool isDark = true ;

//   IconData modeIcon = Icons.dark_mode ;
//   bool  changeAppThemeModeSwitch ({ bool ? isDarkFromSharedPref }){
//
//     if (isDarkFromSharedPref != null ){
//       isDark = isDarkFromSharedPref ;
//       emit(AppChangeThemeModeState());
//       return isDark ;
//     }
//     else {
//       isDark = ! isDark ;
//       // from button press
//       CacheHelper.saveData('isDarkMode', isDark).then((value) {
//         emit(AppChangeThemeModeState());
//       });
//       return isDark ;
//     }
//
//   }
//

  void changeAppThemeMode ({ bool ? isDarkFromSharedPref }) {

    // isDark ? modeIcon = Icons.dark_mode : modeIcon = Icons. light_mode ;
    emit(AppChangeThemeModeState());

    if (isDarkFromSharedPref != null ){
      isDark = isDarkFromSharedPref ;
      emit(AppChangeThemeModeState());
    }
    else {
      isDark = ! isDark ;
      // from button press
      CacheHelper.saveData(DARK_MODE, isDark).then((value) {
        emit(AppChangeThemeModeState());
      });
    }

  }
// // ----------------------------------------------------------------------------
//

}
