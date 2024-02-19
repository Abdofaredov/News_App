import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFromField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (String? value) {
                    NewsCubit.get(context).getSearch(value!);
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Search must be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search),
            ),
            Expanded(
                child: articleBuilderSearch(list, context, isSearch: false)),
          ]),
        );
      },
    );
  }
}
