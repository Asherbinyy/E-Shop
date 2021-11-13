import 'package:bloc/bloc.dart';
import '../../../helpers/local/shared_pref/cache_helper.dart';
import '../../../helpers/local/shared_pref/cached_values.dart';
import '../model/landing_model.dart';
import '../../../styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'landing_states.dart';


class LandingCubit extends Cubit<LandingStates> {
  LandingCubit() : super(LandingInitialState());

 static LandingCubit get (BuildContext context) => BlocProvider.of(context);

 /// if true previewer screen is represented instead of welcome screen
 bool isWelcomeDone = false ;
 bool isLangChoosed = false ;
 bool isArabic = false ;
 bool isEnglish = false ;
 String ? languageIs ;

void chooseLanguage (String lang){
  switch (lang){
    case 'ar':
      languageIs = 'ar' ;

      isArabic = true;
      isEnglish=false ;
      emit(ChooseLanguageState());
      break;
      case 'en':
       languageIs = 'en' ;

      isEnglish = true;
      isArabic =false ;
      emit(ChooseLanguageState());
      break;
  }

}

/// This changes the UI from welcomeBuilder to onBoarding previewerBuilder
void switchToPreviewer (BuildContext context)async{
  if (isArabic||isEnglish){
    isLangChoosed = true ;
    isWelcomeDone=true;
    appLanguage=languageIs;
    context.setLocale(Locale(appLanguage!)).then((_) =>
        CacheHelper.saveData(APP_LANGUAGE, languageIs).then((value) {
          if (value && languageIs!=null){
            appLanguage = languageIs ;
            emit(SwitchToPreviewerSuccessState());
          }
        }),
    );
  }
  else {
    isLangChoosed = false ;
    isWelcomeDone=false;
    emit(SwitchToPreviewerErrorState());
  }
}

/// Icon Brand is shown in welcome then its well be shown in Previewer just for
///  1 second as in hideBrandIcon() method
bool showBrandIcon = true ;
void hideBrandIcon(){
  Future.delayed(Duration(seconds: 1)).then((value) {
    showBrandIcon = false ;
    emit(HideBrandIconState());
  });
}

/// shows get started title in the last previewer screen
bool isGetStartedTitleShown = false ;
bool isLastScreen = false ;

void onPageChanged (int index){
  isLastScreen = (index == LandingData.getLandingList.length-1);
 if (isLastScreen) {
   isGetStartedTitleShown = true ;
 }
   else {
   isGetStartedTitleShown = false ;
 }

   emit(OnPageChangedState());
}

/// This shows animation when you finish scrolling
bool playFinishedAnimation = false ;
void onNextChanged (PageController pageController){
  if (isLastScreen) {
    emit(PlayFinishedAnimationState());
  }
  else pageController.nextPage(
    duration: Duration(microseconds: 750),
    curve: Curves.fastLinearToSlowEaseIn,
  );
}

void onSkipChanged ()async{
  isLastScreen = true ;
  emit(PlayFinishedAnimationState());
}
}