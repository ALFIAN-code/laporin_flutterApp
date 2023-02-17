import 'package:flutter/material.dart';

import '../pages/theme/style.dart';

class LaporanView extends StatelessWidget {
  const LaporanView(
      {super.key,
      required this.isiLaporan,
      required this.judul,
      required this.path,
      required this.status});

  final String isiLaporan;
  final String path;
  final String judul;
  final String status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: (path.isNotEmpty)
                          ? ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                                path,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
                              child: Text('null'),
                            ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                judul,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: semiBold17.copyWith(fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                isiLaporan,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: regular17.copyWith(fontSize: 12),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('19 Mei 2022'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('17:45'),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 75,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: (status == 'terkirim')
                                    ? Colors.grey
                                    : (status == 'diproses')
                                        ? Colors.yellow[700]
                                        : (status == 'selesai')
                                            ? Colors.green
                                            : Colors.grey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Text(
                              (status == 'terkirim')
                                  ? 'terkirim'
                                  : (status == 'diproses')
                                      ? 'diproses'
                                      : (status == 'selesai')
                                          ? 'selesai'
                                          : 'error',
                              textAlign: TextAlign.center,
                              style: medium12_5.copyWith(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
