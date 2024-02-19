import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/news_app/business/business.dart';
import 'package:newsapp/modules/news_app/science/science.dart';
import 'package:newsapp/modules/news_app/sports/sports.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsIntialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
    // BottomNavigationBarItem(
    //     icon: Icon(
    //       Icons.settings,
    //     ),
    //     label: 'Settings'),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    //SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '1864a1a8635043b3b9723f791ca8ae8e',
    }).then((value) {
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '1864a1a8635043b3b9723f791ca8ae8e',
      }).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        // print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((erorr) {
        // print(erorr.toString());
        emit(NewsGetBusinessErrorState(erorr.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '1864a1a8635043b3b9723f791ca8ae8e',
      }).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        // print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((erorr) {
        // print(erorr.toString());
        emit(NewsGetScienceErrorState(erorr.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetsearchLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '1864a1a8635043b3b9723f791ca8ae8e',
    }).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      // print(search[0]['title']);

      emit(NewsGetsearchSuccessState());
    }).catchError((erorr) {
      // print(erorr.toString());
      emit(NewsGetsearchErrorState(erorr.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewAppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewAppChangeModeState());
      });
    }
  }
}
