import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

Widget scoreBoard(String title, String info){
  return Expanded(
    child: Container(
      margin:EdgeInsets.all(15.0),
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.0),
        ),
        child: Column(
          children: [
            Text(
            title, 
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold
              ),
            ),
            const Gap(5),
            Text(info,style:TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)),
          ],
        ),
    ),
  );
}