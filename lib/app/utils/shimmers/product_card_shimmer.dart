import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
      const SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 205,
        maxCrossAxisExtent: 300,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: .5,
              color: Colors.grey.withOpacity(.5),
            ),
          ),
          elevation: 5,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
                const Gap(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Placeholder
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                      const Gap(5),
                      // Price Placeholder (Half Width)
                      Container(
                        height: 16,
                        width: 80, // Adjust this width to be half of the title
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        ;
      },
    );
  }
}
