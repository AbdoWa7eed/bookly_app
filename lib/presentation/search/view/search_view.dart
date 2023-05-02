import 'package:bookly_app/app/di.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:bookly_app/presentation/resources/color_manager.dart';
import 'package:bookly_app/presentation/resources/constants_manager.dart';
import 'package:bookly_app/presentation/resources/routes_manager.dart';
import 'package:bookly_app/presentation/resources/strings_managet.dart';
import 'package:bookly_app/presentation/resources/values_manager.dart';
import 'package:bookly_app/presentation/search/cubit/cubit.dart';
import 'package:bookly_app/presentation/search/cubit/states.dart';
import 'package:bookly_app/presentation/shared/functions.dart';
import 'package:bookly_app/presentation/shared/loading/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final TextEditingController _searchController;
  late final ScrollController _searchScrollController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchScrollController = ScrollController();
    _searchScrollController.addListener(_seacrhScrollListener);
  }

  _seacrhScrollListener() async {
    var cubit = instance<SearchCubit>();
    final double maxScroll = _searchScrollController.position.maxScrollExtent;
    final double currentScroll = _searchScrollController.position.pixels;
    final double delta = 0.3 * maxScroll;
    if (maxScroll - currentScroll <= delta) {
      if (!cubit.isLoading) {
        cubit.isLoading = true;
        await cubit.getSearchedData(
            searchedBook: _searchController.text,
            pageNumber: ++cubit.pageNumber);
        await delayAndDo(
            seconds: AppConstants.fetchingDataDelay,
            function: () {
              cubit.isLoading = false;
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if (state is GetSearchedDataErrorState) {
          showSnackBar(state.errorMessage, context);
        }
      },
      builder: (context, state) {
        var cubit = instance<SearchCubit>();
        return _buildScreenWidget(cubit);
      },
    );
  }

  Widget _buildScreenWidget(SearchCubit cubit) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        body: SafeArea(
          child: Column(children: [
            _buildCustomAppBar(cubit),
            const SizedBox(
              height: AppSize.s20,
            ),
            _buildContentWidget(cubit),
          ]),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(SearchCubit cubit) {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                cubit.searchedBooks?.clear();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: ColorManager.white,
              )),
          const SizedBox(
            width: AppSize.s10,
          ),
          Expanded(
            child: TextFormField(
              controller: _searchController,
              style: Theme.of(context).textTheme.labelSmall,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppStrings.mustNotBeEmpty;
                }
                return null;
              },
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  cubit.getSearchedData(searchedBook: value, pageNumber: 0);
                  cubit.pageNumber = 0;
                }
              },
              decoration: const InputDecoration(
                labelText: AppStrings.search,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentWidget(SearchCubit cubit) {
    if (cubit.state is GetSearchedDataLoadingState &&
        cubit.searchedBooks == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (cubit.searchedBooks == null || cubit.searchedBooks!.isEmpty) {
      return __buildEmptyWidget();
    }
    return _buildSearchedListViewWidget(cubit);
  }

  Widget _buildSearchedListViewWidget(SearchCubit cubit) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: AppPadding.p30),
        child: ListView.separated(
            controller: _searchScrollController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildSearchedItemWidget(cubit.searchedBooks![index]);
            },
            separatorBuilder: (context, iedBndex) {
              return const SizedBox(
                height: AppSize.s14,
              );
            },
            itemCount: cubit.searchedBooks!.length),
      ),
    );
  }

  Widget _buildSearchedItemWidget(BookInfoModel bookModel) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.bookDetailsRoute, arguments: bookModel);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppSize.s120,
            width: AppSize.s75,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s12)),
            child: showImage(bookModel.imageLink),
          ),
          const SizedBox(
            width: AppSize.s28,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookModel.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),
                Text(
                  bookModel.author,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: AppSize.s4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.free,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.star_rate_rounded,
                            color: ColorManager.yellow, size: AppSize.s28),
                        const SizedBox(
                          width: AppSize.s4,
                        ),
                        Text(
                          '${bookModel.averageRating}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          width: AppSize.s4,
                        ),
                        Text(
                          '(${bookModel.pageCount})',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget __buildEmptyWidget() {
    return Center(
      child: Text(
        AppStrings.thereIsNoData,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

}
