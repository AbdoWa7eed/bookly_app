// ignore_for_file: use_build_context_synchronously

import 'package:bookly_app/app/di.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:bookly_app/presentation/home/cubit/cubit.dart';
import 'package:bookly_app/presentation/resources/color_manager.dart';
import 'package:bookly_app/presentation/resources/font_manager.dart';
import 'package:bookly_app/presentation/resources/routes_manager.dart';
import 'package:bookly_app/presentation/resources/strings_managet.dart';
import 'package:bookly_app/presentation/resources/values_manager.dart';
import 'package:bookly_app/presentation/shared/functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsView extends StatefulWidget {
  const BookDetailsView({super.key});

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  late final BookInfoModel _bookModel;
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      _bookModel = ModalRoute.of(context)?.settings.arguments as BookInfoModel;
      isInitialized = true;
    }
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              _buildBookImage(),
              const SizedBox(
                height: AppSize.s45,
              ),
              _buildBookDetails(),
              const SizedBox(
                height: AppSize.s28,
              ),
              _buildPriceWidget(),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p20),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppStrings.youCanAlsoLike,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s16,
              ),
              _buildRecommendedListViewWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s14))),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s12)),
            child: showImage(_bookModel.imageLink),
          ),
        ),
      ),
    );
  }

  Widget _buildBookDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          Text(
            _bookModel.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: FontSize.s30),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Text(
            _bookModel.author,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: FontSize.s18),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star_rate_rounded,
                  color: ColorManager.yellow, size: AppSize.s28),
              const SizedBox(
                width: AppSize.s4,
              ),
              Text(
                '${_bookModel.averageRating}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: AppSize.s4,
              ),
              Text(
                '(${_bookModel.pageCount})',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPriceWidget() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s20),
                        bottomLeft: Radius.circular(AppSize.s20))),
                height: AppSize.s50,
                child: Center(
                  child: Text(
                    AppStrings.free,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorManager.black,
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  _launchUrl(_bookModel.previewLink);
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: ColorManager.orange,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppSize.s20),
                          bottomRight: Radius.circular(AppSize.s20))),
                  height: AppSize.s50,
                  child: Center(
                    child: Text(AppStrings.freePreview,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildRecommendedListViewWidget() {
    var list = instance<HomeCubit>().getRecommendedList(_bookModel);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: SizedBox(
        height: AppSize.s120,
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _buildRecommendedItem(list[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: AppSize.s14,
              );
            },
            itemCount: list.length),
      ),
    );
  }

  Widget _buildRecommendedItem(BookInfoModel bookModel) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context)
            .popAndPushNamed(Routes.bookDetailsRoute, arguments: bookModel);
      },
      child: Container(
        height: AppSize.s120,
        width: AppSize.s75,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s12)),
        child: showImage(bookModel.imageLink),
      ),
    );
  }

  _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      showSnackBar(AppStrings.invalidLink, context);
    }
  }

}
