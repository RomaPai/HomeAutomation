import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Data.dart';

class SideBar extends StatelessWidget {
  final Data user;

  const SideBar({this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: HexColor("#1A1A1A")),
        width: MediaQuery.of(context).size.width * 0.85,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Flexible(
                flex: 1,
                child: Image(
                  image: AssetImage('assets/teco_log.png'),
                ),

              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: constraints.maxHeight * 0.003,
                  width: constraints.maxWidth,
                  color: Colors.grey[400],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
