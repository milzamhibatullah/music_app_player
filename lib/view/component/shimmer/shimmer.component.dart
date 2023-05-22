import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

itemShimmer(context) => Shimmer.fromColors(
  baseColor: Theme.of(context).colorScheme.primary.withOpacity(.1),
  enabled: true,
  direction: ShimmerDirection.ltr,
  highlightColor: Theme.of(context).colorScheme.background,
  child: SizedBox(
    child: ListView.builder(
      shrinkWrap: true,
      physics:const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        height: 60.0,
        padding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        margin: const EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      itemCount: 10,
      scrollDirection: Axis.vertical,
    ),
  ),
);