import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePerusahaanPage extends StatefulWidget {
  @override
  _ProfilePerusahaanPageState createState() => _ProfilePerusahaanPageState();
}

class _ProfilePerusahaanPageState extends State<ProfilePerusahaanPage> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCOverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildCOverImage() => Stack(
        children: [
          Container(
            color: Colors.grey,
            child: Image.asset(
              'assets/profil.jpg',
              width: double.infinity,
              height: coverHeight,
              fit: BoxFit.cover,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            ),
            tooltip: 'Kembali',
          ),
        ],
      );

  Widget buildProfileImage() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                blurRadius: 10, color: Colors.grey.shade300, spreadRadius: 5)
          ],
        ),
        child: CircleAvatar(
          radius: profileHeight / 2,
          backgroundColor: Colors.white,
          // backgroundImage: AssetImage('assets/logos.png', ),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(profileHeight / 2),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/logos.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      );

  Widget buildSocialMediaIcon(IconData icon, Function fungsi) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => fungsi(),
            child: Center(
              child: Icon(
                icon,
                size: 32,
              ),
            ),
          ),
        ),
      );

  Widget buildContent() => Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  'PERUMDA AIR MINUM BAYUANGGA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                Text(
                  'Kota Probolinggo',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildSocialMediaIcon(FontAwesomeIcons.facebook, () async {
                  final url = 'https://www.facebook.com/pdam.probolinggokota';
                  // if (await canLaunch(url)) {
                  await launch(url);
                  // } else {
                  //   print('cant launch');
                  // }
                }),
                SizedBox(
                  width: 12,
                ),
                buildSocialMediaIcon(FontAwesomeIcons.globe, () async {
                  final url = 'https://pdam.probolinggokota.go.id/';
                  // if (await canLaunch(url)) {
                  await launch(url);
                  // } else {
                  //   print('cant launch');
                  // }
                }),
                SizedBox(
                  width: 12,
                ),
                buildSocialMediaIcon(FontAwesomeIcons.phone, () async {
                  final url = 'tel:0335422254';
                  // if (await canLaunch(url)) {
                  await launch(url);
                  // }
                  // print('tel');
                }),
                SizedBox(
                  width: 12,
                ),
                buildSocialMediaIcon(Icons.email, () async {
                  final url =
                      'mailto:pdam.probolinggo@yahoo.co.id?${Uri.encodeFull('Pertanyaan')}&body=${Uri.encodeFull('Hallo PDAM KOta Probolinggo..')}';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                }),
                SizedBox(
                  width: 12,
                ),
                buildSocialMediaIcon(Icons.location_on_rounded, () async {
                  final url =
                      'https://www.google.com/maps/place/PDAM+Kota+Probolinggo+Tirta+Dharma/@-7.7475422,113.2260545,17z/data=!3m1!4b1!4m5!3m4!1s0x2dd7ada574ed65b5:0xbd0cfcbbbb62440a!8m2!3d-7.7475273!4d113.2281324';
                  // if (await canLaunch(url)) {
                  await launch(url);
                }),
                SizedBox(
                  width: 12,
                ),
                buildSocialMediaIcon(FontAwesomeIcons.instagram, () async {
                  final url = 'https://www.instagram.com/perumdambayuangga/';
                  // if (await canLaunch(url)) {
                  await launch(url);
                }),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Alamat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Jl. Hayam Wuruk No.5, Mangunharjo, Probolinggo, Kota Probolinggo, Jawa Timur 67214',
                    style: TextStyle(fontSize: 14, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Telp.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '0335 422254',
                    style: TextStyle(fontSize: 14, height: 1.4),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          ],
        ),
      );
}
