import 'package:flutter/material.dart';

import '../../../data/models/categories_response_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';

class CategoryItemWiget extends StatelessWidget {
  final Category category;
  const CategoryItemWiget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.width / 5,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: Theme.of(context).highlightColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: Images.placeholder,
            image: 'https://picsum.photos/20${category.id}',
            imageErrorBuilder: (c, o, s) => Image.asset(
              Images.placeholder,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      Center(
        child: Text(
          category.name ?? '-',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: titilliumRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: ColorResources.getTextTitle(context)),
        ),
      ),
    ]);
  }
}
