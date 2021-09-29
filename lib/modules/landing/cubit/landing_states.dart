/// reviewed

abstract class LandingStates {}

class LandingInitialState extends LandingStates {}

// switch To Previewer states
class SwitchToPreviewerSuccessState extends LandingStates {}
class SwitchToPreviewerErrorState extends LandingStates {}


class OnPageChangedState extends LandingStates {}
class PlayFinishedAnimationState extends LandingStates {}



class ChooseLanguageState extends LandingStates {}

class HideBrandIconState extends LandingStates {}
