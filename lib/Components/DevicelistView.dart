import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Components/deviceCard.dart';

import '../Data.dart';

class GetListView extends StatelessWidget {
  final List<List<String>> devices;
  final Data user;
  final GlobalKey card;
  final Function handler;

  final controller = ScrollController();
  GetListView({this.devices, this.user, this.card, this.handler});
  @override
  Widget build(BuildContext context) {
    final String name = user.name;
    if (devices.isNotEmpty) {
      return Expanded(
        child: Scrollbar(
          controller: controller,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(12),
            controller: controller,
            itemCount: (devices.length) + 1,
            itemBuilder: (BuildContext context, int index) {
              return index != devices.length
                  ? Cards(
                      device: devices[index],
                      user: this.user,
                      card: card,
                      handler: handler,
                    )
                  : Container(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.2,
                      ),
                    );
            },
          ),
        ),
      );
    } else {
      return Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.04,
            horizontal: MediaQuery.of(context).size.width * 0.015,
          ),

          child: Text(
              "Add the unique ID given above in the device !",
            style: TextStyle(
                fontSize: 40.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
            color: Colors.white),
          ));
    }
  }
}
