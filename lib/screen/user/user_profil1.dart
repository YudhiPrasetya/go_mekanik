import 'package:flutter/material.dart';

class UserProfile1View extends StatefulWidget {
  final String? userName;
  final String? totalOrders;
  final String? finishedOrders;
  final String? canceledOrders;
  final String? totalPoint;

  const UserProfile1View(
      {required Key key,
      this.userName,
      this.totalOrders,
      this.finishedOrders,
      this.canceledOrders,
      this.totalPoint})
      : super(key: key);

  @override
  _UserProfile1ViewState createState() => _UserProfile1ViewState();
}

class _UserProfile1ViewState extends State<UserProfile1View> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile - ${widget.userName}'),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          _buildCoverImage(screenSize),
          _buildProfileImage(),
          _buildFullName(),
          _buildStatus(),
          _buildProfile()
        ],
      ),
    );
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cover_user_profile.jpg'),
              fit: BoxFit.cover)),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/mechanic.jpg'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(color: Colors.white, width: 10.0)),
      ),
    );
  }

  Widget _buildFullName() {
    return Text(
      '${widget.userName}',
      style: const TextStyle(
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(4.0)),
      child: const Text(
        'Mechanic',
        style: TextStyle(
            fontFamily: 'Spectral',
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _buildProfile() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Total Orders",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${widget.totalOrders}',
                    style: const TextStyle(
                        fontSize: 20.0, color: Colors.pinkAccent),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Finished Orders",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${widget.finishedOrders}',
                    style: const TextStyle(
                        fontSize: 20.0, color: Colors.pinkAccent),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Canceled Orders",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${widget.canceledOrders}',
                    style: const TextStyle(
                        fontSize: 20.0, color: Colors.pinkAccent),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Total Points",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${widget.totalPoint}',
                    style: const TextStyle(
                        fontSize: 20.0, color: Colors.pinkAccent),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
