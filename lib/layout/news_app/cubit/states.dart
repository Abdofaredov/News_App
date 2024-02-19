abstract class NewsState {}

class NewsIntialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class NewsGetBusinessLoadingState extends NewsState {}

class NewsGetBusinessSuccessState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErrorState extends NewsState {
  final String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsState {}

class NewsGetScienceSuccessState extends NewsState {}

class NewsGetScienceErrorState extends NewsState {
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetsearchLoadingState extends NewsState {}

class NewsGetsearchSuccessState extends NewsState {}

class NewsGetsearchErrorState extends NewsState {
  final String error;
  NewsGetsearchErrorState(this.error);
}

class NewAppChangeModeState extends NewsState {}
