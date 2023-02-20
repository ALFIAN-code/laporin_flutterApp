import 'package:flutter/material.dart';
import 'package:lapor_in/component/my_button.dart';
import 'package:lapor_in/pages/theme/style.dart';

class DetailLaporan extends StatelessWidget {
  const DetailLaporan({super.key});

  static String routeName = '/detailLaporan';

  @override
  Widget build(BuildContext context) {
    var bodyHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF1F3F4),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: bodyHeight * 0.4,
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/laporin-89b57.appspot.com/o/laporan%2Fbusupiyati69%40gmail.com%2F1676866540654680?alt=media&token=88382828-b36d-462f-922c-12ddebc4c90b',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: bodyHeight * 0.35),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 30),
                      child: Text(
                        'Kecelakaan mobil',
                        style: bold25.copyWith(color: Colors.grey[800]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 30),
                      child: Text(
                        '10 February 2023',
                        style: regular15.copyWith(color: Colors.grey[800]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          'terkirim',
                          textAlign: TextAlign.center,
                          style: medium17.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Pelapor : Bagus Alfian',
                            style: regular15.copyWith(letterSpacing: 0.3),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Nomor Telfon : 081515867972',
                            style: regular15.copyWith(letterSpacing: 0.3),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'alamat : ini adalah alamat',
                            style: regular15.copyWith(letterSpacing: 0.3),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras efficitur tristique velit, vel ullamcorper ligula condimentum at. Aliquam erat volutpat. Morbi porta dapibus tristique. Suspendisse lacinia purus ut ipsum molestie aliquet. Suspendisse et fringilla dui. Cras sed blandit urna. Donec dapibus tincidunt nibh eget gravida. Maecenas nunc ligula, laoreet egestas quam a, tempor interdum dolor. Aliquam vel posuere elit. Etiam et mauris sed magna bibendum commodo. In eleifend lobortis neque a viverra.',
                            style: regular15.copyWith(letterSpacing: 0.3),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, right: 20),
                          child: Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                decoration: const BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Lihat Tanggapan',
                                      style: medium15.copyWith(
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[300]?.withAlpha(100),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Icon(
                        Icons.arrow_back,
                        // weight: 300,

                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
