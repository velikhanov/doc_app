import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.325,
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(0, 0, 255, 0),
                  child: IconButton(
                    onPressed: null,
                    color: Colors.white,
                    icon: Icon(Icons.dehaze),
                  ),
                ),
                Text('EN'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/home_img.png',
                      width: 75,
                      // height: 100,
                    ),
                    const Text('Сан Саныч'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
