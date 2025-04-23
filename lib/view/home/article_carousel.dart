import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/article.dart';

import '../../theme.dart';

// ignore: must_be_immutable
class ArticleCarousel extends StatelessWidget {
  ArticleCarousel({super.key});
    final List<String> defaultImages = [
    'assets/images/penyakit1.webp',
    'assets/images/penyakit2.png',
    'assets/images/penyakit5.jpeg',
  ];

  List<Article> dummyArticles = [
    Article(
      title: "Flutter 3.0 Resmi Dirilis!",
      thumbnail:
          Thumbnail(url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXuKGkKjk5iOALbdyZiHxs_tWTvIg4qr0v1A&s"),
      category: Category(name: "Teknologi"),
    ),
    Article(
      title: "Tips Produktif Bekerja dari Rumah",
      thumbnail: Thumbnail(url: "https://img.freepik.com/free-vector/t-shirt-print-demand-services-promotional-apparel-design-merch-clothing-custom-merchandise-products-merch-design-service-concept_335657-124.jpg?t=st=1740061567~exp=1740065167~hmac=6f60f43feac93a80a28938b2fdf4eded071f7a1b4bf92f162787931d3cd4c959&w=900"),
      category: Category(name: "Lifestyle"),
    ),
    Article(
      title: "Makanan Sehat untuk Keseharianmu",
      thumbnail: Thumbnail(url: "https://img.freepik.com/free-photo/chicken-steak-topped-with-white-sesame-peas-tomatoes-broccoli-pumpkin-white-plate_1150-24766.jpg?t=st=1740061655~exp=1740065255~hmac=f950d14b480b5340daec36e7741e2fc2c566ccc633bfeb709b9dc083abfd800e&w=900"),
      category: Category(name: "Kesehatan"),
    ),
    Article(
      title: "10 Tempat Wisata Tersembunyi di Indonesia",
      thumbnail: Thumbnail(url: "https://img.freepik.com/free-photo/woman-walking-kelingking-beach-nusa-penida-island-bali-indonesia_335224-337.jpg?t=st=1740061712~exp=1740065312~hmac=1376755a6db06e4919a4c7ab3ce4c3f92ab6151723ed8f63be76a056e1407544&w=900"),
      category: Category(name: "Wisata"),
    ),
    Article(
      title: "Cara Mengelola Keuangan dengan Baik",
      thumbnail: Thumbnail(url: "https://img.freepik.com/free-photo/impressed-young-student-girl-wearing-glasses-back-bag-holding-pointing-money-isolated-orange_141793-83840.jpg?t=st=1740061753~exp=1740065353~hmac=d5fc45402f5d0c4969d1e71f53f130d8f682dcf7e3bcd138c0750868643856b8&w=900"),
      category: Category(name: "Keuangan"),
    ),
  ];

  // final articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    // return Obx(
    //   () => articleController.isLoading.value
    //       ? Shimmer.fromColors(
    //           baseColor: Colors.grey[300]!,
    //           highlightColor: Colors.grey[100]!,
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 20),
    //             child: Container(
    //               height: 200,
    //               width: double.infinity,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(10),
    //                 boxShadow: const [
    //                   BoxShadow(
    //                     color: Colors.black26,
    //                     blurRadius: 5.0,
    //                     spreadRadius: 2.0,
    //                     offset: Offset(2.0, 2.0),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         )
    // :
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: dummyArticles.map((article) {
        int index = dummyArticles.indexOf(article);
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      article.thumbnail != null
                          ? Image.network(
                              article.thumbnail?.url ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  defaultImages[index % defaultImages.length],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                );
                              },
                            )
                          : Image.asset(
                              defaultImages[index % defaultImages.length],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                shadows: [
                                  const Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    color: AppTheme.nearlyBlack,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppTheme.primary,
                              ),
                              child: Text(
                                article.category?.name ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
    // );
  }
}
