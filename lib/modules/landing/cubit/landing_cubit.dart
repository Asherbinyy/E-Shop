import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'landing_states.dart';

class LandingCubit extends Cubit<LandingStates> {
  LandingCubit() : super(LandingInitialState());

 static LandingCubit get (BuildContext context) => BlocProvider.of(context);



 bool isFirstDone = false ;
 bool isLangChoosed = false ;
 bool isArabic = false ;
 bool isEnglish = false ;

void chooseLanguage (bool ? newValue,String lang){
  switch (lang){
    case 'ar':
      isArabic = true;
      isEnglish=false ;
      emit(ChooseLanguageState());
      break;
      case 'en':
      isEnglish = true;
      isArabic =false ;
      emit(ChooseLanguageState());
      break;
  }

}
void changeGetStarted (){
  if (isArabic||isEnglish){
    isLangChoosed = true ;
    isFirstDone=true;
    emit(ChangeGetStartedSuccessState());
  }
  else {
    isLangChoosed = false ;
    isFirstDone=false;
    emit(ChangeGetStartedErrorState());
  }
}

bool showBrandIcon = true ;
void hideBrandIcon(){
  showBrandIcon = false ;
  emit(HideBrandIconState());
}

bool isGetStartedTitleShown = true;
void hideGetStartedTitle(String titleIs){
  if (titleIs=='hidden') isGetStartedTitleShown = false  ;
  else isGetStartedTitleShown = true;
  emit(HideGetStartedTitle());
}
bool isLastScreen = false ;

void changeLastScreen (String screenIs){
  switch (screenIs) {
    case 'last':
     isLastScreen = true ;
     emit(ChangeLastScreenState());
     break ;
     case 'notLast':
     isLastScreen = false ;
     emit(ChangeLastScreenState());
     break ;
  }
}












}