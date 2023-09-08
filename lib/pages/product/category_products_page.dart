import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic7_app/bloc/products/products_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter_fic7_app/data/models/products_response_model.dart';

import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../base_widgets/custom_app_bar.dart';
import '../home/widgets/product_item_widget.dart';

class CategoryProductsPage extends StatefulWidget {
  const CategoryProductsPage({
    Key? key,
    required this.id,
    this.name,
  }) : super(key: key);

  final int id;
  final String? name;

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(
          ProductsEvent.getByCategory(
            widget.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(title: widget.name),

          const SizedBox(height: Dimensions.paddingSizeSmall),

          // Products
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                loaded: (model) {
                  return Expanded(
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      itemCount: model.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItemWidget(product: model.data![index]);
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
