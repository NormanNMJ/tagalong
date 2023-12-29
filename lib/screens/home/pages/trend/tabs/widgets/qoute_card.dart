
  import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/qoute_model.dart';

Widget quoteCard(QuoteModel quote) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        CachedNetworkImageProvider(quote.profileImage),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${quote.firstName} ${quote.otherName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  const Text('-', style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 8),
                  Text(quote.formattedTimeAgo(),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const Icon(Icons.more_horiz),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            quote.quote,
            style: const TextStyle(fontSize: 16),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite_border_outlined),
                      const SizedBox(width: 4),
                      Text(quote.likesCount.toString()),
                      const SizedBox(width: 16),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.history_edu),
                      const SizedBox(width: 4),
                      Text(quote.commentCount.toString()),
                      const SizedBox(width: 16),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.autorenew),
                      const SizedBox(width: 4),
                      Text(quote.repostCount.toString()),
                      const SizedBox(width: 16),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.share),
                      const SizedBox(width: 4),
                      Text(quote.shareCount.toString()),
                      const SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.star_border_outlined),
                  const SizedBox(width: 4),
                  Text(quote.starCount.toString()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

