import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/core/url.dart';
import 'package:news_app/data/models/newsmodel.dart';
import 'package:timeago/timeago.dart' as timeago;

Image newsimage(NewsModel news) {
  return Image.network(
    Endpoints.imgbaseurl + news.imageDefault.toString(),
    fit: BoxFit.cover,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: LoadingAnimationWidget.fourRotatingDots(
              color: kredcolor, size: 40),
        );
      }
    },
    errorBuilder: (context, error, stackTrace) {
      return const Center(
        child: Icon(Icons.error, color: kredcolor, size: 40),
      );
    },
  );
}

//
Padding newstime(NewsModel news) {
  return Padding(
    padding: const EdgeInsets.only(left: 11, right: 8, bottom: 8, top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '${timeago.format(news.createdAt)}',
          style: const TextStyle(
            color: kgreycolor,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
