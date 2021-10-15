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
                      'https://www.google.co.id/maps/place/Jl.+Hayam+Wuruk+No.5,+Jati,+Kec.+Mayangan,+Kota+Probolinggo,+Jawa+Timur+67217/@-7.7570911,113.2241326,17z/data=!3m1!4b1!4m5!3m4!1s0x2dd7ada59e31334f:0x88fcfd0de770f8ec!8m2!3d-7.7570911!4d113.2263213';
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
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    'Create a beautiful User Profile Page UI in Flutter with profile picture, profile image and cover image by using Circle Avatar, Stack and Positioned widgets in Flutter.',
                    style: TextStyle(fontSize: 16, height: 1.4),
                  )
                ],
              ),
            )
          ],
        ),
      );
}
