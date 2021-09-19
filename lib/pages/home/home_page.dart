import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/pages/home/widgets/berita_card.dart';
import 'package:bsainfo_mobile/pages/home/widgets/menu.dart';
import 'package:bsainfo_mobile/pages/home/widgets/tagihan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var ukuranLayar = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      color: Colors.blue,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://calonpengangguran.com/wp-content/uploads/2019/10/close-up-1-FILEminimizer.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Hallo Zanul..',
                      style: GoogleFonts.poppins(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircleAvatar(
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    backgroundColor: colorTagihan,
                  ),
                ],
              ),
            ),
            tagihanWidget(ukuranLayar),
            menuWidget(ukuranLayar),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Berita',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  beritaCard(ukuranLayar),
                  beritaCard(ukuranLayar),
                  beritaCard(ukuranLayar),
                  beritaCard(ukuranLayar),
                  beritaCard(ukuranLayar),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
