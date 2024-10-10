import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_mekanik/classes/ImagePickerService.dart';
// import 'package:go_mekanik/screen/user/user_profile_picture.dart';
import 'package:go_mekanik/service/baseUrl.dart';
import 'package:go_mekanik/util/ShowToast.dart';

class UserProfile extends StatefulWidget {
  final String? nik;
  final String? userName;
  final String? bagian;
  final String? shift;
  final String? totalOrders;
  final String? finishedOrders;
  final String? canceledOrders;
  final String? totalPoint;
  final String? userImageUrl;

  const UserProfile(
      {Key? key,
      this.nik,
      this.userName,
      this.bagian,
      this.shift,
      this.totalOrders,
      this.finishedOrders,
      this.canceledOrders,
      this.totalPoint,
      this.userImageUrl})
      : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // final String urlImage = BaseUrl.baseUrlMekanikImages + "/${widget.nik}.jpg";
  // String urlImage;

  final String _status = "Mechanic";

  // String _bio =
  //     "Hallo, aku adalah seorang mekanik mesin jahit di PT. Globalindo Intimates";

  var idUserMekanik;

  @override
  void initState() {
    // _getData();
    // _getNIK();
    super.initState();
  }

  // _getNIK() async {
  //   final String nik = await SessionManager().getNIK();
  //   print('nik: $nik');
  //   // final String urlImage = BaseUrl.baseUrlMekanikImages + "/$nik.jpg";
  // }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover_user_profile.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    // final String urlImage = BaseUrl.baseUrlMekanikImages + "/${widget.nik}.jpg";
    // final String urlImage = BaseUrl.baseUrlMekanikImages + "/noimage.jpg";
    // return Center(
    //   child: Container(
    //     width: 140.0,
    //     height: 140.0,
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         // image: AssetImage('assets/images/mechanic.jpg'),
    //         image: NetworkImage(urlImage),
    //         fit: BoxFit.cover,
    //       ),
    //       borderRadius: BorderRadius.circular(80.0),
    //       border: Border.all(
    //         color: Colors.white,
    //         width: 10.0,
    //       ),
    //     ),
    //   ),
    // );

    // return const UserProfilePicture();

    String urlNoImage = BaseUrl.baseUrlMekanikImages + "/noimage.jpg";
    ImagePickerService imagePickerService = ImagePickerService();
    ShowToast showToast = ShowToast();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Pilih gambar profile Anda'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: widget.userImageUrl != null
                    ? NetworkImage(
                        BaseUrl.baseUrlMekanikImages + widget.userImageUrl!)
                    : NetworkImage(urlNoImage),
                backgroundColor: Colors.grey,
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () async {
                    File? image =
                        await imagePickerService.chooseImageFile(context);
                    image == null
                        ? showToast.showToastWarning('Image not picked')
                        : setState(() {});
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      widget.userName!,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: const TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 12.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.only(top: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Total Orders", widget.totalOrders!),
          _buildStatItem("Finished Orders", widget.finishedOrders!),
          _buildStatItem("Canceled Orders", widget.canceledOrders!),
          _buildStatItem("Total Points", '${widget.totalPoint!}')
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    String _bio =
        "Hallo, perkenalkan nama saya ${widget.userName}, saya bekerja di PT. Globalindo Intimates sebagai mekanik mesin jahit. Jabatan saya adalah ${widget.bagian} dan jam kerja saya adalah ${widget.shift}";
    TextStyle bioTextStyle = const TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 14.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: const EdgeInsets.only(top: 4.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile - ${widget.userName}'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Stack(
        children: [
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 10.4),
                  _buildProfileImage(),
                  // const UserProfilePicture(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
