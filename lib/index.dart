import 'package:flutter/material.dart';
import 'package:sqlite/home.dart';
import 'package:sqlite/listpelanggan.dart';

//pendukung program asinkron

class Index extends StatefulWidget {
  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<Index> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bonekaku'),
      ),
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Daftar Item"),
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                );
              }
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Daftar Pelanggan"),
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListPelanggan()),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }

}