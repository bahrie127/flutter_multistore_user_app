import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic7_app/bloc/categories/categories_bloc.dart';

import '../../bloc/products/products_bloc.dart';
import '../../utils/color_resources.dart';
import '../../utils/custom_themes.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../base_widgets/title_row.dart';
import 'widgets/banner_widget.dart';
import 'widgets/category_widget.dart';
import 'widgets/product_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(bool reload) async {}

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    context.read<ProductsBloc>().add(const ProductsEvent.getAll());
    context.read<CategoriesBloc>().add(const CategoriesEvent.getCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                title: Image.asset(Images.logoWithNameImage, height: 35),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Stack(clipBehavior: Clip.none, children: [
                        Image.asset(
                          Images.cartArrowDownImage,
                          height: Dimensions.iconSizeDefault,
                          width: Dimensions.iconSizeDefault,
                          color: ColorResources.getPrimary(context),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: ColorResources.red,
                            child: Text(
                              '10',
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeExtraSmall,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                      child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                          vertical: Dimensions.paddingSizeSmall),
                      color: ColorResources.getHomeBg(context),
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: Dimensions.homePagePadding,
                          right: Dimensions.paddingSizeExtraSmall,
                          top: Dimensions.paddingSizeExtraSmall,
                          bottom: Dimensions.paddingSizeExtraSmall,
                        ),
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeExtraSmall),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Search',
                                  style: robotoRegular.copyWith(
                                      color: Theme.of(context).hintColor)),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.paddingSizeExtraSmall))),
                                child: Icon(Icons.search,
                                    color: Theme.of(context).cardColor,
                                    size: Dimensions.iconSizeSmall),
                              ),
                            ]),
                      ),
                    ),
                  ))),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.homePagePadding,
                      Dimensions.paddingSizeSmall,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      const BannerWidget(),
                      const SizedBox(height: Dimensions.homePagePadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraExtraSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: TitleRow(
                          title: 'Categories',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: Dimensions.homePagePadding),
                        child: CategoryWidget(),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: Row(children: [
                          Expanded(child: Text('Products', style: titleHeader)),
                        ]),
                      ),
                      const SizedBox(height: Dimensions.homePagePadding),
                    ],
                  ),
                ),
              ),
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      );
                    },
                    error: (message) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Center(
                                child: Text(message),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      );
                    },
                    loaded: (model) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return ProductItemWidget(
                                product: model.data![index],
                              );
                            },
                            childCount: model.data!.length,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
