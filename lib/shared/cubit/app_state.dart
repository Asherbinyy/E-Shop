abstract class AppStates {}

class AppInitialState extends AppStates {}


class AppChangeThemeModeState extends AppStates {}
class AppChangeThemeModeIconState extends AppStates {}


class ChangeRadioTileState extends AppStates {}

// font size
class ChangeFontSizeState extends AppStates {}
class RestoreFontSizeState extends AppStates {}

//Change App Colors
class ChangeAppColorsSuccessState extends AppStates{}
class ChangeAppColorsErrorState extends AppStates{
  final String error ;

  ChangeAppColorsErrorState(this.error);

}
//Change App Language
class ChangeLanguageSuccessState extends AppStates{}
class ChangeLanguageErrorState extends AppStates{
  final String error ;

  ChangeLanguageErrorState(this.error);

}
