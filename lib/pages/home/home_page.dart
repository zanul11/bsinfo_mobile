import 'package:bsainfo_mobile/api.dart';
import 'package:bsainfo_mobile/constant/color_constant.dart';
import 'package:bsainfo_mobile/koneksi.dart';
import 'package:bsainfo_mobile/models/user_pelanggan_model.dart';
import 'package:bsainfo_mobile/pages/home/widgets/berita_card.dart';
import 'package:bsainfo_mobile/pages/home/widgets/cardNewUser.dart';
import 'package:bsainfo_mobile/pages/home/widgets/menu.dart';
import 'package:bsainfo_mobile/pages/home/widgets/tagihan.dart';
import 'package:bsainfo_mobile/pages/home/widgets/tagihan_lunas.dart';
import 'package:bsainfo_mobile/pages/home/widgets/tagihanbelumdaftar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool cekLogin = false;
  String namaSUer = '', nohp = '';
  bool loadWidget = false;
  bool isLunas = false;
  String tagihanRekening = '0';

  getCekLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('nama')) {
      setState(() {
        cekLogin = true;
        namaSUer = prefs.getString('nama')!;
        nohp = prefs.getString('nohp')!;
        if (prefs.containsKey('selectedNoPel')) {
          selectedNo = prefs.getString('selectedNoPel')!;
          api
              .getTagihanUserBulanan(nopel: prefs.getString('selectedNoPel')!)
              .then((value) {
            isLunas = false;
            if (value['status']) {
              setState(() {
                isLunas = true;
                tagihanRekening = value['result'].toString();
              });
            } else {
              setState(() {
                isLunas = false;
              });
            }
          }).catchError((onError) {
            setState(() {
              isLunas = false;
            });
          });
        }
      });
      getUser();
    } else {
      setState(() {
        loadWidget = true;
      });
    }
  }

  @override
  void initState() {
    KoneksiInternet().koneksi().then((value) {
      if (value) {
        getCekLogin();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  final api = Api();
  List<Result> listPelanggan = List.empty();
  String selectedNo = '';
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    api.getuserPelanggan().then((value) {
      if (value.message == 'tidak ditemukan') {
        setState(() {
          listPelanggan = List.empty();
          loadWidget = true;
        });
      } else {
        setState(() {
          listPelanggan = value.result;
          if (!prefs.containsKey('selectedNoPel')) {
            selectedNo = listPelanggan[0].noPelanggan;
            api
                .getTagihanUserBulanan(nopel: listPelanggan[0].noPelanggan)
                .then((value) {
              isLunas = false;
              if (value['status']) {
                setState(() {
                  isLunas = true;
                  tagihanRekening = value['result'].toString();
                });
              } else {
                setState(() {
                  isLunas = false;
                });
              }
            }).catchError((onError) {
              setState(() {
                isLunas = false;
              });
            });
          }
          loadWidget = true;
        });
      }
    });
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
                      setState(() {
                        loadWidget = false;
                      });
                      getCekLogin();
                    });
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      loadWidget = false;
      cekLogin = false;
      namaSUer = '';
      nohp = '';
    });
    await Future.delayed(Duration(milliseconds: 1000));
    getCekLogin();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    var ukuranLayar = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          enablePullUp: false,
          enablePullDown: true,
          onRefresh: _onRefresh,
          controller: _refreshController,
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
              (!loadWidget)
                  ? Container()
                  : (selectedNo == '')
                      ? Container()
                      : SizedBox(
                          height: 20,
                        ),
              (!loadWidget)
                  ? Container()
                  : (selectedNo == '')
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'No Pelanggan Anda',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
              (!loadWidget)
                  ? Container()
                  : (selectedNo == '')
                      ? Container()
                      : SizedBox(
                          height: 5,
                        ),
              (!loadWidget)
                  ? Container()
                  : (selectedNo == '')
                      ? Container()
                      : GestureDetector(
                          onTap: () => bottomSheet(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                                  '$selectedNo',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down_sharp)
                              ],
                            ),
                          ),
                        ),
              (!loadWidget)
                  ? tagihanShimmerWidget(ukuranLayar)
                  : ((!cekLogin)
                      ? cardNewUser(ukuranLayar, context)
                      : (listPelanggan.length == 0)
                          ? tagihanBelumDaftar(ukuranLayar, context)
                          : (isLunas)
                              ? tagihanWidget(ukuranLayar, tagihanRekening,
                                  selectedNo, context)
                              : tagihanLunas(ukuranLayar, selectedNo, context)),
              menuWidget(ukuranLayar, context),
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
      ),
    );
  }
}
