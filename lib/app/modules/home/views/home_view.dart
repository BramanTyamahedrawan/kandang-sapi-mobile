import 'dart:io';

import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:crud_flutter_api/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final List<String> imageUrls = [
    'assets/images/eksotik.jpg',
    'assets/images/dkpp.jpg',
    'assets/images/pet.jpg',
    'assets/images/pet2.jpg',
    'assets/images/pet3.jpg',
    'assets/images/logo.png',
  ];

  //final int _currentIndex = 0;
  //final CarouselController _carouselController = CarouselController();

  String get jsonKRB => '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColor.secondary, // Set your primary color here
        statusBarIconBrightness: Brightness
            .light, // Use Brightness.dark if your primary color is light
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      appBar: AppBar(
        title: const Text(
          'TERNAK',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.secondary,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Dinas Ketahanan Pangan Dan Pertanian",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   child: AdWidget(ad: controller.bannerAd),
              //   width: controller.bannerAd.size.width.toDouble(),
              //   height: controller.bannerAd.size.height.toDouble(),
              // ),
              const Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Selamat Datang Di Sistem Manajemen Aplikasi Ternak \n",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
              // Other widgets...

              SizedBox(
                width: double.infinity,
                height: 200,
                child: Obx(() {
                  final beritaContent = controller.beritaNews.value.content;
                  final items = [
                    ...imageUrls.map((url) => {'image': url, 'type': 'image'}),
                    if (beritaContent != null)
                      ...beritaContent
                          .map((news) => {
                                'image':
                                    // "http://192.168.1.9:8081/api/berita/file_1717997839574_c2c85f22-58f7-4374-aedf-e8789f71ca6f.jpg",
                                    "${controller.sharedApi.imageUrl + "berita/"}${news.fotoBerita}",
                                'title': news.judul,
                                'content': news.isiBerita,
                                'type': 'news'
                              })
                          .toList(),
                  ];
                  void _showNewsDialog(String title, String content) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(title),
                          content: SingleChildScrollView(
                            child: Text(content),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Tutup'),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return CarouselSlider.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index, _) {
                      if (items[index]['type'] == 'image') {
                        return Image.asset(
                          items[index]['image']!,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return GestureDetector(
                            onTap: () {
                              _showNewsDialog(
                                items[index]['title']!,
                                items[index]['content']!,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                children: [
                                  Text(
                                    items[index]['title'] as String,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.network(
                                      items[index]['image']!,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      }
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                    ),
                  );
                }),
              ),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Wrap(
                      spacing: 80.0,
                      runSpacing: 20.0,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 30,
                          child: Card(
                            color: const Color(0xff132137),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Text(
                              "Peta Lokasi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                width: double.maxFinite,
                height: 250,
                child: Obx(() {
                  List<Marker> markersTernak = [];
                  List<Marker> markersKandang = [];

                  if (controller.posts1.value.content != null &&
                      controller.posts3.value.content != null) {
                    markersTernak = controller.posts1.value.content!.map((n) {
                      return Marker(
                        width: 15.0,
                        height: 15.0,
                        point: LatLng(
                          double.tryParse(n.latitude ?? '') ?? 00.0,
                          double.tryParse(n.longitude ?? '') ?? 00.0,
                        ),
                        child: Container(
                          child: Image.asset(
                            'assets/images/cow.png', // Ganti dengan path ke gambar Anda
                          ),
                        ),
                      );
                    }).toList();

                    markersKandang = controller.posts3.value.content!.map((n) {
                      return Marker(
                        width: 15,
                        height: 15,
                        point: LatLng(
                          double.tryParse(n.latitude ?? '') ?? 00.0,
                          double.tryParse(n.longitude ?? '') ?? 00.0,
                        ),
                        child: Container(
                          child: Image.asset(
                            'assets/images/house.png', // Ganti dengan path ke gambar Anda
                          ),
                        ),
                      );
                    }).toList();
                  }
                  List<Marker> allMarkers = [
                    ...markersTernak,
                    ...markersKandang
                  ];
                  List<Marker> validMarkers = allMarkers.where((marker) {
                    return marker.point.latitude >= -90.0 &&
                        marker.point.latitude <= 90.0;
                  }).toList();

                  return FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(-8.1351667, 113.2218143),
                      initialZoom: 9,
                      maxZoom: 18,
                      minZoom: 4,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                      ),

                      if (controller.krbBoundary != null)
                        PolygonLayer(
                          polygons: [
                            Polygon(
                              points: controller.krbBoundary!,
                              color: Color.fromARGB(17, 255, 251, 0),
                              borderColor: Color.fromARGB(174, 172, 0, 0),
                              borderStrokeWidth: 2,
                              isFilled: true,
                            ),
                          ],
                        ),

                      PopupScope(
                        child: MarkerClusterLayerWidget(
                          options: MarkerClusterLayerOptions(
                            maxClusterRadius: 45,
                            size: const Size(40, 40),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(50),
                            maxZoom: 15,
                            markers: validMarkers,
                            popupOptions: PopupOptions(
                              popupBuilder:
                                  (BuildContext context, Marker marker) {
                                // HewanModel?
                                //     hewan; // Deklarasikan di luar try-catch
                                KandangModel? kandang;
                                // try {
                                //   hewan = controller.posts1.value.content
                                //       ?.firstWhere(
                                //     (item) =>
                                //         item.latitude ==
                                //             marker.point.latitude.toString() &&
                                //         item.longitude ==
                                //             marker.point.longitude.toString(),
                                //     orElse: () => HewanModel(),
                                //   );
                                // } catch (e) {
                                //   print("Error saat mencari data hewan: $e");
                                // }
                                // try {
                                //   if (controller.posts1.value.content != null &&
                                //       controller
                                //           .posts1.value.content!.isNotEmpty) {
                                //     // Dapatkan data hewan dari indeks yang sesuai
                                //     hewan = controller.posts1.value.content!
                                //         .firstWhere(
                                //             (item) =>
                                //                 item.latitude ==
                                //                     marker.point.latitude
                                //                         .toString() &&
                                //                 item.longitude ==
                                //                     marker.point.longitude
                                //                         .toString(),
                                //             orElse: () =>
                                //                 HewanModel()); // Mengembalikan null jika tidak ditemukan
                                //   }
                                // } catch (e) {
                                //   print("Error saat mencari data: $e");
                                // }
                                // Dapatkan data kandang dari indeks yang sesuai
                                try {
                                  kandang = controller.posts3.value.content
                                      ?.firstWhere(
                                    (item) =>
                                        item.latitude ==
                                            marker.point.latitude.toString() &&
                                        item.longitude ==
                                            marker.point.longitude.toString(),
                                    orElse: () => KandangModel(),
                                  );
                                } catch (e) {
                                  print("Error saat mencari data kandang: $e");
                                }
                                // final kandang =
                                //     controller.posts3.value.content!.firstWhere(
                                //   (item) =>
                                //       item.latitude ==
                                //           marker.point.latitude.toString() &&
                                //       item.longitude ==
                                //           marker.point.longitude.toString(),
                                //   orElse: () =>
                                //       KandangModel(), // Asumsikan ada model KandangModel
                                // );

                                // Tampilkan informasi yang relevan dalam popup
                                return Card(
                                  child: IntrinsicWidth(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // if (hewan?.kodeEartagNasional !=
                                        //     null) // Tampilkan data hewan jika ada
                                        //   ListTile(
                                        //     leading: const Icon(Icons.pets),
                                        //     title: Text(
                                        //       '${hewan?.kodeEartagNasional ?? ''}'
                                        //       '\n'
                                        //       '${hewan?.idPeternak?.namaPeternak ?? ''}'
                                        //       '\n',
                                        //       // '${hewan?.spesies ?? ''}'
                                        //       // '\n'
                                        //       // '${hewan?.desa ?? ''}',
                                        //       style: const TextStyle(
                                        //         fontSize: 16,
                                        //         fontWeight: FontWeight.bold,
                                        //       ),
                                        //       textAlign: TextAlign.center,
                                        //       maxLines: 5,
                                        //       overflow: TextOverflow.ellipsis,
                                        //     ),
                                        //   ),
                                        if (kandang?.idPeternak?.namaPeternak !=
                                            null) // Tampilkan data kandang jika ada
                                          ListTile(
                                            leading: const Icon(Icons.home),
                                            title: Text(
                                              kandang?.idPeternak
                                                      ?.namaPeternak ??
                                                  '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            builder: (context, markers) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    markers.length.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      PopupMarkerLayer(
                        options: PopupMarkerLayerOptions(
                          markers: allMarkers,
                          popupController: controller.popupLayerController,
                          popupDisplayOptions: PopupDisplayOptions(
                            builder: (BuildContext context, Marker marker) {
                              HewanModel?
                                  hewan; // Deklarasikan di luar try-catch
                              KandangModel? kandang;
                              try {
                                hewan =
                                    controller.posts1.value.content?.firstWhere(
                                  (item) =>
                                      item.latitude ==
                                          marker.point.latitude.toString() &&
                                      item.longitude ==
                                          marker.point.longitude.toString(),
                                  orElse: () => HewanModel(),
                                );
                              } catch (e) {
                                print("Error saat mencari data hewan: $e");
                              }
                              // try {
                              //   if (controller.posts1.value.content != null &&
                              //       controller
                              //           .posts1.value.content!.isNotEmpty) {
                              //     // Dapatkan data hewan dari indeks yang sesuai
                              //     hewan = controller.posts1.value.content!
                              //         .firstWhere(
                              //             (item) =>
                              //                 item.latitude ==
                              //                     marker.point.latitude
                              //                         .toString() &&
                              //                 item.longitude ==
                              //                     marker.point.longitude
                              //                         .toString(),
                              //             orElse: () =>
                              //                 HewanModel()); // Mengembalikan null jika tidak ditemukan
                              //   }
                              // } catch (e) {
                              //   print("Error saat mencari data: $e");
                              // }
                              // Dapatkan data kandang dari indeks yang sesuai
                              try {
                                kandang =
                                    controller.posts3.value.content?.firstWhere(
                                  (item) =>
                                      item.latitude ==
                                          marker.point.latitude.toString() &&
                                      item.longitude ==
                                          marker.point.longitude.toString(),
                                  orElse: () => KandangModel(),
                                );
                              } catch (e) {
                                print("Error saat mencari data kandang: $e");
                              }
                              // final kandang =
                              //     controller.posts3.value.content!.firstWhere(
                              //   (item) =>
                              //       item.latitude ==
                              //           marker.point.latitude.toString() &&
                              //       item.longitude ==
                              //           marker.point.longitude.toString(),
                              //   orElse: () =>
                              //       KandangModel(), // Asumsikan ada model KandangModel
                              // );

                              // Tampilkan informasi yang relevan dalam popup
                              return Card(
                                child: IntrinsicWidth(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (hewan?.kodeEartagNasional !=
                                          null) // Tampilkan data hewan jika ada
                                        ListTile(
                                          leading: const Icon(Icons.pets),
                                          title: Text(
                                            '${hewan?.kodeEartagNasional ?? ''}'
                                            '\n',
                                            // '${hewan?.peternak_id?.namaPeternak ?? ''}'
                                            // '\n'
                                            // '${hewan?.spesies ?? ''}'
                                            // '\n'
                                            // '${hewan?.desa ?? ''}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      if (kandang?.idPeternak?.namaPeternak !=
                                          null) // Tampilkan data kandang jika ada
                                        ListTile(
                                          leading: const Icon(Icons.home),
                                          title: Text(
                                            kandang?.idPeternak?.namaPeternak ??
                                                '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // FutureBuilder<List<List<LatLng>>>(
                      //   future: controller.someFunction(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.done) {
                      //       if (snapshot.hasError) {
                      //         return Text('Error: ${snapshot.error}');
                      //       } else {
                      //         // Tampilkan PolygonLayer setelah mendapatkan data
                      //         return PolygonLayer(
                      //           polygons: snapshot.data!.isEmpty
                      //               ? [] // Tambahkan penanganan jika data kosong
                      //               : snapshot.data!.map((polygonPoints) {
                      //                   return Polygon(
                      //                       points: polygonPoints,
                      //                       color:
                      //                           Color.fromARGB(123, 255, 0, 0),
                      //                       borderColor: Colors.red,
                      //                       borderStrokeWidth: 2,
                      //                       isFilled: true);
                      //                 }).toList(),
                      //         );
                      //       }
                      //     } else if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       // Tampilkan loading indicator selama data dimuat
                      //       return const CircularProgressIndicator();
                      //     } else {
                      //       // Tampilkan pesan default jika ada kesalahan lainnya
                      //       return const Text('Data tidak dapat dimuat');
                      //     }
                      //   },
                      // ),
                      // FutureBuilder<List<List<LatLng>>>(
                      //   future: controller.someFunction1(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.done) {
                      //       if (snapshot.hasError) {
                      //         return Text('Error: ${snapshot.error}');
                      //       } else {
                      //         // Tampilkan PolygonLayer setelah mendapatkan data
                      //         return PolygonLayer(
                      //           polygons: snapshot.data!.isEmpty
                      //               ? [] // Tambahkan penanganan jika data kosong
                      //               : snapshot.data!.map((polygonPoints) {
                      //                   return Polygon(
                      //                       points: polygonPoints,
                      //                       color: const Color.fromARGB(
                      //                           103, 255, 136, 0),
                      //                       borderColor: const Color.fromARGB(
                      //                           255, 255, 145, 0),
                      //                       borderStrokeWidth: 2,
                      //                       isFilled: true);
                      //                 }).toList(),
                      //         );
                      //       }
                      //     } else if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       // Tampilkan loading indicator selama data dimuat
                      //       return const CircularProgressIndicator();
                      //     } else {
                      //       // Tampilkan pesan default jika ada kesalahan lainnya
                      //       return const Text('Data tidak dapat dimuat');
                      //     }
                      //   },
                      // ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 3),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildMiniCardWidget(
                          //"assets/images/cow.png",
                          "${controller.countKandangInKRB.value}",
                          "Kawasan Rawan Bencana"),
                      const SizedBox(width: 3),
                    ],
                  )),
              // ElevatedButton(
              //   style: ButtonStyle(
              //       backgroundColor: MaterialStatePropertyAll(Colors.amber)),
              //   onPressed: () async {
              //     // Ganti cara pemanggilan fungsi agar lebih sesuai dengan logika
              //     Directory? selectedDirectory =
              //         await controller.getDirectory();

              //     if (selectedDirectory != null) {
              //       // Perbarui nilai Rx<Directory?>
              //       controller.savePath.value = selectedDirectory;

              //       // Perbarui cara mengakses nilai Rx<Directory?>
              //       controller.downloadDataInKRB(controller.savePath.value);
              //     }
              //   },
              //   child: const Text(
              //     "Download Data KRB",
              //     style: TextStyle(color: Color.fromARGB(255, 104, 0, 81)),
              //   ),
              // ),

              const SizedBox(height: 7),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: Center(
                      child: Wrap(
                        spacing: 80.0,
                        runSpacing: 20.0,
                        children: [
                          SizedBox(
                            width: 250,
                            height: 30,
                            child: Card(
                              color: const Color(0xff132137),
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: const Text(
                                "Informasi Data Peternakan",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),

              // Other widgets...

              // Organize card widgets using a Row and Spacer for spacing.
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCardWidget(
                          "assets/images/cow.png",
                          "${controller.posts1.value.totalElements ?? 0}",
                          "Ternak"),
                      const SizedBox(width: 12),
                      _buildCardWidget(
                          "assets/images/man.png",
                          "${controller.posts2.value.totalElements ?? 0}",
                          "Peternak"),
                    ],
                  )),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCardWidget(
                          "assets/images/people.png",
                          "${controller.posts.value.totalElements ?? 0}",
                          "Petugas"),
                      const SizedBox(width: 12),
                      _buildCardWidget(
                          "assets/images/house.png",
                          "${controller.posts3.value.totalElements ?? 0}",
                          "Kandang"),
                    ],
                  )),

              // Other widgets...
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniCardWidget(String count, String label) {
    return SizedBox(
      width: 300.0,
      height: 70.0,
      child: Card(
        color: const Color(0xff132137),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          // onTap: () => Navigator.pushNamed(
          //     AddHewanController() as BuildContext, '/homePage'),
          child: Column(
            children: [
              // Padding(
              //   padding: EdgeInsets.all(13.0), // Add top padding here
              //   child: Image.asset(
              //     imagePath,
              //     width: 70.0,
              //   ),
              // ),
              const SizedBox(height: 2.0),
              Text(
                count,
                style: const TextStyle(
                  color: Color(0xffF7EBE1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                label,
                style: const TextStyle(
                  color: Color.fromARGB(255, 137, 255, 143),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardWidget(String imagePath, String count, String label) {
    return SizedBox(
      width: 170.0,
      height: 170.0,
      child: Card(
        color: const Color(0xff132137),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          // onTap: () => Navigator.pushNamed(
          //     AddHewanController() as BuildContext, '/homePage'),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0), // Add top padding here
                child: Image.asset(
                  imagePath,
                  width: 70.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                count,
                style: const TextStyle(
                  color: Color(0xffF7EBE1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xffF7EBE1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
