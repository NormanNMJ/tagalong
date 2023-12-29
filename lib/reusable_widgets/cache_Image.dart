// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final Color backgroundColor;
  final double radius;
  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.backgroundColor,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor, // Customize the placeholder color
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent, // Customize the error widget color
      ),
    );
  }
}

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Color backgroundColor;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildLoadingIndicator(),
          errorWidget: (context, url, error) => _buildErrorWidget(),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: backgroundColor,
      child: const Center(
        child: Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
    );
  }
}
