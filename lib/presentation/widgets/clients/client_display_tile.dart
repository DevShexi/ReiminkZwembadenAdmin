import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/styles.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_loading_indicator.dart';

class ClientDisplayTile extends StatelessWidget {
  const ClientDisplayTile({
    Key? key,
    required this.name,
    required this.email,
    this.imageUrl,
  }) : super(key: key);
  final String name;
  final String email;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 29.0,
            backgroundColor: AppColors.pink,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppStyles.title,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5.0),
                Text(
                  email,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class ClientDisplayTileLoader extends StatelessWidget {
  const ClientDisplayTileLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: 0.4,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Row(
          children: [
            const CustomLoadingIndicator(
              width: 58,
              height: 58,
              radius: 58,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLoadingIndicator(width: width * 0.4, height: 26.0),
                  const SizedBox(height: 5.0),
                  CustomLoadingIndicator(width: width * 0.55, height: 18.0),
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
