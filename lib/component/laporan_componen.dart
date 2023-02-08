import 'package:flutter/material.dart';
import 'package:lapor_in/pages/theme/style.dart';

class LaporanView extends StatelessWidget {
  const LaporanView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
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
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          'https://picsum.photos/seed/picsum/200/300',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
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
                                'ini adalah judul',
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
                                'ini adalah isi laporan yang di persingkat hanya dua baris,hanya-dua-baris,cuma-dua-baris',
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              'selesai',
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
          const Divider()
        ],
      ),
    );
  }
}
