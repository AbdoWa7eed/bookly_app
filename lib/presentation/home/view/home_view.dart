import 'package:bookly_app/app/di.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:bookly_app/presentation/home/cubit/cubit.dart';
import 'package:bookly_app/presentation/home/cubit/states.dart';
import 'package:bookly_app/presentation/resources/assets_manager.dart';
import 'package:bookly_app/presentation/resources/color_manager.dart';
import 'package:bookly_app/presentation/resources/constants_manager.dart';
import 'package:bookly_app/presentation/resources/routes_manager.dart';
import 'package:bookly_app/presentation/resources/strings_managet.dart';
import 'package:bookly_app/presentation/resources/values_manager.dart';
import 'package:bookly_app/presentation/shared/error/error_view.dart';
import 'package:bookly_app/presentation/shared/functions.dart';
import 'package:bookly_app/presentation/shared/loading/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _featuredScrollController = ScrollController();
  final ScrollController _newestScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _featuredScrollController.addListener(_featuredScrollListener);
    _newestScrollController.addListener(_newestScrollListener);
  }

  _featuredScrollListener() async {
    var cubit = instance<HomeCubit>();
    final double maxScroll = _featuredScrollController.position.maxScrollExtent;
    final double currentScroll = _featuredScrollController.position.pixels;
    final double delta = 0.3 * maxScroll;
    if (maxScroll - currentScroll <= delta) {
      if (!cubit.isLoading) {
        cubit.isLoading = true;
        await cubit.getFeaturedBooks(pageNumber: ++cubit.featuredPageNumber);
        await delayAndDo(
            seconds: AppConstants.fetchingDataDelay,
            function: () {
              cubit.isLoading = false;
            });
      }
    }
  }

  _newestScrollListener() async {
    var cubit = instance<HomeCubit>();
    final double maxScroll = _newestScrollController.position.maxScrollExtent;
    final double currentScroll = _newestScrollController.position.pixels;
    final double delta = 0.3 * maxScroll;
    if (maxScroll - currentScroll <= delta) {
      if (!cubit.isLoading) {
        cubit.isLoading = true;
        await cubit.getNewestBooks(pageNumber: ++cubit.newestPageNumber);
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
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = instance<HomeCubit>();
        return _buildScreenWidget(cubit);
      },
      listener: (context, state) {
        var cubit = instance<HomeCubit>();
        if (state is GetDataErrorStates) {
          if (cubit.featuredBooks != null && cubit.newestBooks != null) {
            showSnackBar(AppStrings.noInternetError, context);
          }
        }
      },
    );
  }

  Widget _buildScreenWidget(HomeCubit cubit) {
    return Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        appBar: AppBar(
          title: SvgPicture.asset(ImageAssets.logo,
              width: AppSize.s24, height: AppSize.s24),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.searchRoute);
                },
                child: SvgPicture.asset(ImageAssets.searchIc,
                    width: AppSize.s28, height: AppSize.s28),
              ),
            )
          ],
        ),
        body: _biuldContentWidget(cubit, cubit.state));
  }

  Widget _biuldContentWidget(HomeCubit cubit, HomeStates state) {
    if (state is GetDataErrorStates) {
      if (cubit.featuredBooks == null || cubit.newestBooks == null) {
        return ErrorScreen(
            text: state.errorMessage,
            function: () {
              cubit.getInitialData();
            });
      } else {
        return _buildBodyWidget(cubit);
      }
    }
    if (cubit.featuredBooks == null || cubit.newestBooks == null) {
      return const LoadingView();
    } else {
      return _buildBodyWidget(cubit);
    }
  }

  Widget _buildBodyWidget(cubit) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p12, top: AppPadding.p12),
      child: SingleChildScrollView(
        controller: _newestScrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListViewWidget(cubit),
            const SizedBox(
              height: AppSize.s28,
            ),
            Text(
              AppStrings.newest,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: AppSize.s28,
            ),
            _buildNewestListViewWidget(cubit),
          ],
        ),
      ),
    );
  }

  Widget _buildListViewWidget(
    HomeCubit cubit,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.32,
      child: ListView.separated(
          controller: _featuredScrollController,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildListViewItem(cubit.featuredBooks![index]);
          },
          separatorBuilder: (context, iedBndex) {
            return const SizedBox(
              width: AppSize.s14,
            );
          },
          itemCount: cubit.featuredBooks!.length),
    );
  }

  Widget _buildListViewItem(BookInfoModel bookModel) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.bookDetailsRoute, arguments: bookModel);
      },
      child: AspectRatio(
        aspectRatio: 2.7 / 4,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s14))),
          shadowColor: ColorManager.black,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s12)),
            child: showImage(bookModel.imageLink),
          ),
        ),
      ),
    );
  }

  Widget _buildNewestListViewWidget(HomeCubit cubit) {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.p30),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildNewestItem(cubit.newestBooks![index]);
          },
          separatorBuilder: (context, iedBndex) {
            return const SizedBox(
              height: AppSize.s14,
            );
          },
          itemCount: cubit.newestBooks!.length),
    );
  }

  Widget _buildNewestItem(BookInfoModel bookModel) {
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

  @override
  void dispose() {
    _featuredScrollController.dispose();
    _newestScrollController.dispose();
    super.dispose();
  }

}
