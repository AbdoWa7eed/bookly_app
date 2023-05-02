abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class GetSearchedDataLoadingState extends SearchStates {}

class GetSearchedDataSuccessState extends SearchStates {}

class GetSearchedDataErrorState extends SearchStates {
  final String errorMessage;
  GetSearchedDataErrorState(this.errorMessage);
}
