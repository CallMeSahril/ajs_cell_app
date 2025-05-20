import 'package:ajs_cell_app/app/data/banner/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SemuaBannerPage extends StatelessWidget {
  final List<BannerEntities> banners;

  const SemuaBannerPage({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner"),
      ),
      body: ListView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: banner.image ?? '',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.broken_image),
              ),
            ),
          );
        },
      ),
    );
  }
}
