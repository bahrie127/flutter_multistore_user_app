import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/categories/categories_bloc.dart';
import 'category_item_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (message) {
            return Center(
              child: Text(message),
            );
          },
          loaded: (model) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 5,
                childAspectRatio: (1 / 1.3),
              ),
              itemCount: model.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const CategoryProductsPage(
                    //       isBrand: false,
                    //       id: '1',
                    //     ),
                    //   ),
                    // );
                  },
                  child: CategoryItemWiget(
                    category: model.data![index],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
