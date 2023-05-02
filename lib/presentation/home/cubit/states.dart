abstract class HomeStates {}

abstract class GetDataErrorStates extends HomeStates {
  String errorMessage;
  GetDataErrorStates(this.errorMessage);
}

class HomeInitialState extends HomeStates {}

class GetFeaturedLoadingStates extends HomeStates {}

class GetFeaturedSuccessStates extends HomeStates {}

class GetFeaturedErrorStates extends GetDataErrorStates {
  GetFeaturedErrorStates(super.errorMessage);
}

class GetNewestLoadingStates extends HomeStates {}

class GetNewestSuccessStates extends HomeStates {}

class GetNewestErrorStates extends GetDataErrorStates {
  GetNewestErrorStates(super.errorMessage);
}
