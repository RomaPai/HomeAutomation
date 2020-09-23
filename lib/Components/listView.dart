import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teco1/Components/Cards.dart';

import '../Data.dart';

class GetListView extends StatelessWidget {
  final List<List<String>> devices;
  final Data user;
  final controller = ScrollController();
  GetListView({this.devices, this.user});
  @override
  Widget build(BuildContext context) {
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
            "Add a device by clicking on the button below",
            style: TextStyle(
                fontSize: 40.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ));
    }
  }
}
