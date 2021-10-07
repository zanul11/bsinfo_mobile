import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nama = '', nohp = '';
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama')!;
      nohp = prefs.getString('nohp')!;
    });
  }

  final TextEditingController noPel = TextEditingController();
  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    noPel.dispose();
    super.dispose();
  }

  bottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('Photo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  bottomSheetAddNoPel() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Tambahkan Nomor Pelanggan',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Masukkan nomor Pelanggan Anda pada kolom dibawah ini ;',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: noPel,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.openSans(
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: 'Nomor pelanggan ',
                      hintStyle: GoogleFonts.openSans(
                        color: Colors.grey,
                      ),
                      labelStyle: GoogleFonts.openSans(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: colorTagihan,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Tambahkan',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTagihan,
        title: Text('Informasi Pengguna & Layanan'),
      ),
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                height: size.height / 2.7,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(7),
                        padding: EdgeInsets.all(20),
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Colors.grey[350],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Text(
                              nama,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(7),
                        padding: EdgeInsets.all(20),
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Colors.grey[350],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Text(
                              nohp,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => bottomSheet(),
                        child: Container(
                          margin: EdgeInsets.all(7),
                          padding: EdgeInsets.all(20),
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Colors.grey[350],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nomor pelanggan',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(
                                      '202004370',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey.shade500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 75,
              width: double.infinity,
              color: Colors.white,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   border: Border(
              //     top: BorderSide(
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: colorTagihan,
                ),
                onPressed: () => bottomSheetAddNoPel(),
                child: Text(
                  'Tambah Nomor Pelanggan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
