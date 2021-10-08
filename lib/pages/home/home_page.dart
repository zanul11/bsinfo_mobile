import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/pages/home/widgets/berita_card.dart';
import 'package:bsainfo_mobile/pages/home/widgets/cardNewUser.dart';
import 'package:bsainfo_mobile/pages/home/widgets/menu.dart';
import 'package:bsainfo_mobile/pages/home/widgets/tagihan_lunas.dart';
import 'package:bsainfo_mobile/pages/home/widgets/tagihanbelumdaftar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool cekLogin = false;
  String namaSUer = '';

  getCekLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('nama')) {
      setState(() {
        cekLogin = true;
        namaSUer = prefs.getString('nama')!;
      });
    }
  }

  @override
  void initState() {
    getCekLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ukuranLayar = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      color: Colors.blue,
                      image: DecorationImage(
                        image: AssetImage('assets/bsinfo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      (!cekLogin) ? 'BS INFO' : 'Halo $namaSUer',
                      style: GoogleFonts.poppins(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (prefs.containsKey('nama')) {
                          Navigator.of(context).pushNamed('/profile');
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/login", (route) => false);
                        }
                      },
                    ),
                    // child: Icon(
                    //   Icons.person,
                    //   color: Colors.white,
                    // ),
                    backgroundColor: colorTagihan,
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Text(
            //     'No Pelanggan Anda',
            //     style: GoogleFonts.poppins(
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     children: [
            //       Text(
            //         '2018082061',
            //         style: GoogleFonts.poppins(
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       Icon(Icons.keyboard_arrow_down_sharp)
            //     ],
            //   ),
            // ),
            (!cekLogin)
                ? cardNewUser(ukuranLayar, context)
                : tagihanBelumDaftar(ukuranLayar, context),
            menuWidget(ukuranLayar),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Berita',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: ukuranLayar.height * 3 / 7,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  beritaCard(ukuranLayar),
                  beritaCard(ukuranLayar),
                  beritaCard(ukuranLayar),
                  beritaCard(ukuranLayar),
                  beritaCard(ukuranLayar),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
