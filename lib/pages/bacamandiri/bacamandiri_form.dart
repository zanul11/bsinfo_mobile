import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:bsainfo_mobile/photoHero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as dios;
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class BacaMandiriForm extends StatefulWidget {
  @override
  _BacaMandiriFormState createState() => _BacaMandiriFormState();
}

class _BacaMandiriFormState extends State<BacaMandiriForm> {
  final api = Api();
  List<Result> listPelanggan = List.empty();
  String selectedNo = '';
  String namaUser = '', nohpUser = '';
  File _image = File('');
  String _nmImage = '';

  Future getImage(int type) async {
    var image;
    if (type == 0)
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    else
      image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      final tempDir = await getExternalStorageDirectory();
      final path = tempDir!.path;
      var random = Random();
      int randomNumber = random.nextInt(9999);
      print('dir = $path');
      var result = await FlutterImageCompress.compressAndGetFile(
        image.path,
        "$path/BACAMANDIRI_$nohpUser$randomNumber.jpg",
        quality: 50,
        format: CompressFormat.jpeg,
      );
      _nmImage = "BACAMANDIRI_$nohpUser$randomNumber";
      setState(() {
        _image = result!;
      });
      final pict = File(image.path);
      pict.delete();
    } else {
      Navigator.pop(context);
    }
  }

  _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImage(0);

                      Navigator.pop(context);
                    }),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () {
                    getImage(1);

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('nama')) {
        namaUser = prefs.getString('nama')!;
        nohpUser = prefs.getString('nohp')!;
      }
    });
    api.getuserPelanggan().then((value) {
      if (value.message == 'tidak ditemukan') {
        setState(() {
          // countPelanggan = 0;

          listPelanggan = List.empty();
        });
      } else {
        setState(() {
          listPelanggan = value.result;
          if (!prefs.containsKey('selectedNoPel')) {
            prefs.setString('selectedNoPel', listPelanggan[0].noPelanggan);
            selectedNo = listPelanggan[0].noPelanggan;
          } else {
            selectedNo = prefs.getString('selectedNoPel')!;
          }
        });
      }
    });
  }

  final TextEditingController noIdPel = TextEditingController();
  final TextEditingController standMeter = TextEditingController();
  final TextEditingController ket = TextEditingController();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    noIdPel.dispose();
    standMeter.dispose();
    ket.dispose();
    super.dispose();
  }

  bottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ...List.generate(
                listPelanggan.length,
                (index) => ListTile(
                  leading: Icon(
                    (selectedNo == listPelanggan[index].noPelanggan)
                        ? Icons.check_box
                        : Icons.person,
                    color: (selectedNo == listPelanggan[index].noPelanggan)
                        ? Colors.green
                        : Colors.blue,
                  ),
                  title: Text(listPelanggan[index].noPelanggan),
                  subtitle: Text(listPelanggan[index].pelangganDetail.nama),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      selectedNo = listPelanggan[index].noPelanggan;

                      prefs.setString(
                          'selectedNoPel', listPelanggan[index].noPelanggan);
                    });
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  int menu = 0;

  showAlertDialog(BuildContext context, String isi) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: GoogleFonts.openSans(),
      ),
      onPressed: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Perhatian!",
        style: GoogleFonts.openSans(),
      ),
      content: Text(
        "$isi",
        style: GoogleFonts.openSans(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    // ignore: unnecessary_statements
    if (_currentStep < 1) {
      FocusScope.of(context).requestFocus(new FocusNode());
      if (_currentStep == 0) {
        if (_image.path == '') {
          showAlertDialog(context, 'Foto Tidak boleh kosong');
        } else
          setState(() => _currentStep += 1);
      } else {
        setState(() => _currentStep += 1);
      }
    } else {
      print('habis');
    }
  }

  cancel() {
    // ignore: unnecessary_statements
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  doSimpan() async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
        max: 2,
        msg: 'Mengirim Data Baca Mandiri..',
        progressType: ProgressType.valuable,
        backgroundColor: Color(0xff212121),
        progressValueColor: Color(0xff3550B4),
        progressBgColor: Colors.white70,
        msgColor: Colors.white,
        valueColor: Colors.white);

    /// Added to test late loading starts
    await Future.delayed(Duration(milliseconds: 1000));
    dios.FormData data = dios.FormData.fromMap({
      "file": await dios.MultipartFile.fromFile(
        _image.path,
      ),
      "nama": _nmImage,
      "cIdPembaca": 'bacamandiri',
    });
    api
        .bacaMandiri(
            noPelanggan: (menu == 0) ? selectedNo : noIdPel.text,
            stan: standMeter.text,
            foto: '$_nmImage.jpg',
            keterangan: ket.text)
        .then((value) {
      if (value['status']) {
        pd.update(value: 1, msg: 'Kirim Data...');
        dios.Dio dio = dios.Dio();
        dio
            .post("https://api.pudam-bayuangga.id/api/uploadImage", data: data)
            .then((response) async {
          var res = json.decode(response.toString());
          if (response.statusCode == 200) {
            if (res['success']) {
              pd.update(value: 2, msg: 'Selesai...');
              pd.close();
              Fluttertoast.showToast(
                  msg: "Berhasil Baca Mandiri!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/home", (route) => false);
            } else {
              pd.close();
              Fluttertoast.showToast(
                  msg: "Gagal Kirim Gambar,Server Error!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          } else {
            pd.close();
            Fluttertoast.showToast(
                msg: "Gagal Kirim Gambar,Server Error!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }).catchError((onError) {
          pd.close();
          Fluttertoast.showToast(
              msg: "Gagal Kirim Gambar,Server Error!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      } else {
        pd.close();
        Fluttertoast.showToast(
            msg: "${value['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((onError) {
      pd.close();
      Fluttertoast.showToast(
          msg: "Gagal Kirim Data,Server Error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Form Baca Mandiri',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: (_currentStep == 1)
          ? FloatingActionButton.extended(
              onPressed: () async {
                try {
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    if (menu == 0) {
                      if (standMeter.text == '') {
                        showAlertDialog(context, 'Field Tidak boleh kosong');
                      } else {
                        doSimpan();
                      }
                    } else {
                      if (noIdPel.text == '' || standMeter.text == '') {
                        showAlertDialog(context, 'Field Tidak boleh kosong');
                      } else {
                        doSimpan();
                      }
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "Tidak ada jaringan internet!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    print('not connected');
                  }
                } on SocketException catch (_) {
                  Fluttertoast.showToast(
                      msg: "Tidak ada jaringan internet!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  print('not connected');
                }
              },
              label: Text('KIRIM DATA'),
              icon: Icon(Icons.send),
              backgroundColor: Colors.blue,
            )
          : Container(),
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                menu = 0;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(13),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                color: (menu == 0)
                                    ? Colors.green.shade500
                                    : Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  'NO TERDAFTAR',
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      color: (menu == 0)
                                          ? Colors.white
                                          : Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                menu = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(13),
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: (menu == 1)
                                    ? Colors.green.shade500
                                    : Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'INPUT MANUAL',
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      color: (menu == 1)
                                          ? Colors.white
                                          : Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    (menu == 1)
                        ? Container()
                        : GestureDetector(
                            onTap: () => (listPelanggan.length == 0)
                                ? Fluttertoast.showToast(
                                    msg:
                                        'Tambah nomer pelanggan pada menu profile!',
                                    backgroundColor: Colors.orange,
                                    textColor: whiteColor,
                                  )
                                : bottomSheet(),
                            child: Container(
                              margin: EdgeInsets.all(7),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nomor Pelanggan',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        (listPelanggan.length == 0)
                                            ? Text(
                                                'Tambahkan nomor pelanggan',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                ),
                                              )
                                            : Text(
                                                '$selectedNo',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => (listPelanggan.length == 0)
                                        ? Fluttertoast.showToast(
                                            msg:
                                                'Tambah nomer pelanggan pada menu profile!',
                                            backgroundColor: Colors.orange,
                                            textColor: whiteColor,
                                          )
                                        : bottomSheet(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey.shade500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Form Baca Mandiri',
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: _currentStep < 1 ? continued : null,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                        title: Text('Foto Meteran'),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            (_image.path == '')
                                ? Container()
                                : Image.file(_image),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (_image.path == '')
                                    ? Center()
                                    : TextButton.icon(
                                        style: TextButton.styleFrom(
                                            side: BorderSide(
                                                color: Colors.red, width: 1)),
                                        onPressed: () {
                                          print(_nmImage);
                                          _image = File('');
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 18.0,
                                          color: Colors.red,
                                        ),
                                        label: const Text(
                                          'Hapus Foto',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    _settingModalBottomSheet(context);
                                  },
                                  style: TextButton.styleFrom(
                                      side: BorderSide(
                                          color: Colors.blue, width: 1)),
                                  icon: Icon(
                                    Icons.camera_alt,
                                    size: 20.0,
                                  ),
                                  label: Text((_image.path == '')
                                      ? 'Ambil Foto Disini'
                                      : 'Ambil Ulang'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Step(
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                        title: Text('Informasi Pelanggan'),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            (menu == 0)
                                ? Container()
                                : SizedBox(
                                    height: 10,
                                  ),
                            (menu == 0)
                                ? Container()
                                : TextFormField(
                                    style: GoogleFonts.openSans(
                                      fontSize: 14.0,
                                    ),
                                    controller: noIdPel,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'No Pelanggan',
                                      labelStyle: GoogleFonts.openSans(
                                        fontSize: 10.0,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      hintText: 'No Pelanggan',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              style: GoogleFonts.openSans(
                                fontSize: 14.0,
                              ),
                              controller: standMeter,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Angka Meter',
                                labelStyle: GoogleFonts.openSans(
                                  fontSize: 10.0,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.info),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Perhatian!",
                                            style: GoogleFonts.openSans(),
                                          ),
                                          content: Column(
                                            children: [
                                              Text(
                                                "Masukkan hanya angka yang berwarna hitam!",
                                                style: GoogleFonts.openSans(),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (ctx) {
                                                    return PhotoHero(
                                                      photo:
                                                          'assets/angkameter.jpg',
                                                    );
                                                  }));
                                                },
                                                child: Image.asset(
                                                    'assets/angkameter.jpg'),
                                              ),
                                              Text(
                                                '*Tekan gambar untuk melihat lebih jelas!',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Jika seperti contoh gambar di atas, maka nilai yang di-inputkan pada form angka meter adalah nilai 30.",
                                                style: GoogleFonts.openSans(),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text(
                                                "OK",
                                                style: GoogleFonts.openSans(),
                                              ),
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                hintText: 'Angka Meter',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              style: GoogleFonts.openSans(
                                fontSize: 14.0,
                              ),
                              maxLines: 3,
                              controller: ket,
                              decoration: InputDecoration(
                                labelText: 'Keterangan',
                                labelStyle: GoogleFonts.openSans(
                                  fontSize: 10.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                hintText: 'Keterangan (opsional)',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blueAccent,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '*Keterangan bersifat opsional, dapat dikosongkan',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
