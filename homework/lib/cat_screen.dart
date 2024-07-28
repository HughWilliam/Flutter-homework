// main.dart
import 'cat_model.dart';
import 'cat_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatImagePage extends StatefulWidget {
  const CatImagePage({super.key});

  @override
  _CatImagePageState createState() => _CatImagePageState();
}

class _CatImagePageState extends State<CatImagePage> {
  final CatService _catService = CatService();
  List<Cat> _catImages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCatImages();
  }

  Future<void> _fetchCatImages() async {
    try {
      List<Cat> images = await _catService.fetchCatImages();
      setState(() {
        _catImages = images;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error appropriately
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemCount: _catImages.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: _catImages[index].url,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                fit: BoxFit.cover,
              );
            },
          );
  }
}
