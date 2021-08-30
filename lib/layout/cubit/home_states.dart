abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

/// LAYOUT
// bottom nav bar
class ChangeBottomNavState extends HomeStates {}
// banner Slider
class ChangeBannerSlideState extends HomeStates {}

/// METHODS
// get banners
class GetBannersLoadingState extends HomeStates {}
class GetBannersSuccessState extends HomeStates {}
class GetBannersErrorState extends HomeStates {
 final String error ;
  GetBannersErrorState(this.error);
}
// get Categories
class GetCategoriesLoadingState extends HomeStates {}
class GetCategoriesSuccessState extends HomeStates {}
class GetCategoriesErrorState extends HomeStates {
 final String error ;
 GetCategoriesErrorState(this.error);
}

