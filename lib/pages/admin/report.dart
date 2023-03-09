import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Report extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>>? laporanData;
  final DocumentSnapshot<Map<String, dynamic>>? tanggapanData;
  final String namaPetugas;
  const Report(
      {super.key,
      required this.laporanData,
      this.tanggapanData,
      required this.namaPetugas});
  static String routesName = 'report';

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  //laporan data
  String namaPelapor = '';
  String idPelapor = '';
  String idLaporan = '';
  int nikPelapor = 0;
  String alamat = '';
  int telp = 0;
  DateTime tanggal = DateTime.now();
  String judul = '';
  String isiLaporan = '';
  String urlImage = '';
  String status = '';

  //tanggapan data
  String idTanggapan = '';
  String idPetugas = '';
  String isiTanggapan = '';
  DateTime tanggalTanggapan = DateTime.now();

  void getTanggapanData() {
    if (status != 'terkirim') {
      idTanggapan = widget.tanggapanData!['id_tanggapan'];
      idPetugas = widget.tanggapanData!['id_petugas'];
      isiTanggapan = widget.tanggapanData!['isi_tanggapan'];
      tanggalTanggapan =
          (widget.tanggapanData!['tanggal_tanggapan'] as Timestamp).toDate();
    }
  }

  @override
  void initState() {
    //get laporan data
    urlImage = widget.laporanData!['url_image'];
    namaPelapor = widget.laporanData!['nama_pelapor'];
    idPelapor = widget.laporanData!['id_pelapor'];
    idLaporan = widget.laporanData!['id_laporan'];
    nikPelapor = widget.laporanData!['nik_pelapor'];
    alamat = widget.laporanData!['alamat'];
    telp = widget.laporanData!['telp'];
    tanggal = (widget.laporanData!['tanggal'] as Timestamp).toDate();
    judul = widget.laporanData!['judul'];
    isiLaporan = widget.laporanData!['isi_laporan'];
    status = widget.laporanData!['status'];

    //get tanggapan data
    getTanggapanData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //preview pdf
    return PdfPreview(
        pdfFileName: 'laporinApp_$judul\_$idLaporan',
        canChangeOrientation: false,
        canDebug: false,
        build: (format) => generateDocument(format));
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    var _textStyle = pw.TextStyle(font: font1, fontSize: 15);

    final netImage = await networkImage(urlImage);

    doc.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          //first page
          pw.Header(
              child: pw.Text('Laporin-App report',
                  style: pw.TextStyle(
                      font: font2, fontSize: 24, color: PdfColors.white)),
              padding: pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: pw.BoxDecoration(color: PdfColors.deepOrange)),
          pw.SizedBox(height: 20),
          pw.Text('Laporan', style: pw.TextStyle(font: font2, fontSize: 20)),
          pw.SizedBox(height: 10),
          pw.Image(netImage, height: 100),
          pw.SizedBox(height: 10),
          pw.Text('id laporan : $idLaporan', style: _textStyle),
          pw.SizedBox(height: 10),
          pw.Text('nama pelapor : $namaPelapor', style: _textStyle),
          pw.SizedBox(height: 10),
          pw.Text('id pelapor : $idPelapor', style: _textStyle),
          pw.SizedBox(height: 10),
          pw.Text('nik pelapor : $nikPelapor', style: _textStyle),
          pw.SizedBox(height: 10),
          pw.Text('alamat kejadian : $alamat', style: _textStyle),
          pw.SizedBox(height: 10),
          pw.Text('nomor telepon : $telp', style: _textStyle),
          pw.SizedBox(height: 10),
          pw.Text(
              'tanggal kejadian  : ${DateFormat('dd MMMM yyyy, kk:mm').format(tanggal)}',
              style: _textStyle),
          pw.SizedBox(height: 10),
          pw.Text('judul Laporan : $judul', style: _textStyle),
          pw.SizedBox(height: 10),
          pw.Text('isi Laporan : $isiLaporan', style: _textStyle),

          pw.NewPage(),

          //second page
          (status != 'terkirim')
              ? pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // pw.NewPage(),
                    pw.Header(
                        child: pw.Text('Laporin-App report',
                            style: pw.TextStyle(
                                font: font2,
                                fontSize: 24,
                                color: PdfColors.white)),
                        padding: pw.EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration:
                            pw.BoxDecoration(color: PdfColors.deepOrange)),
                    pw.SizedBox(height: 20),
                    pw.Text('Tanggapan',
                        style: pw.TextStyle(font: font2, fontSize: 20)),
                    pw.SizedBox(height: 10),
                    pw.Text('id laporan : $idLaporan', style: _textStyle),
                    pw.SizedBox(height: 10),
                    pw.Text('nama petugas : ${widget.namaPetugas}',
                        style: _textStyle),
                    pw.SizedBox(height: 10),
                    pw.Text('id petugas : $idPetugas', style: _textStyle),
                    pw.SizedBox(height: 10),
                    pw.Text(
                        'tanggal tanggapan  : ${DateFormat('dd MMMM yyyy, kk:mm').format(tanggalTanggapan)}',
                        style: _textStyle),
                    pw.SizedBox(height: 10),
                    pw.Text('isi tanggapan : $isiTanggapan', style: _textStyle)
                  ],
                )
              : pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                      // pw.NewPage(),
                      pw.Header(
                          child: pw.Text('Laporin-App report',
                              style: pw.TextStyle(
                                  font: font2,
                                  fontSize: 24,
                                  color: PdfColors.white)),
                          padding: pw.EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration:
                              pw.BoxDecoration(color: PdfColors.deepOrange)),
                      pw.SizedBox(height: 20),
                      pw.Text('Tanggapan',
                          style: pw.TextStyle(font: font2, fontSize: 20)),
                      pw.SizedBox(height: 20),
                      pw.Center(child: pw.Text('laporan belum ditanggapi'))
                    ]),
        ];
      },
    ));

    return doc.save();
  }
}
