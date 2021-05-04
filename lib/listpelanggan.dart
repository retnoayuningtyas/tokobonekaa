import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:sqlite/dbhelper.dart';
import 'package:sqlite/entrypelanggan.dart';
import 'pelanggan.dart'; 

//pendukung program asinkron

class ListPelanggan extends StatefulWidget {
  @override
  ListPelangganState createState() => ListPelangganState();
}

class ListPelangganState extends State<ListPelanggan> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Pelanggan> pelangganList;
  @override
  Widget build(BuildContext context) {
    if (pelangganList == null) {
      pelangganList = List<Pelanggan>();
    }
      updateListView();
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pelanggan'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Pelanggan"),
              onPressed: () async {
                var pelanggan = await navigateToEntryForm(context, null);
                if (pelanggan != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertPelanggan(pelanggan);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Pelanggan> navigateToEntryForm(BuildContext context, Pelanggan pelanggan) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryPelanggan(pelanggan);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.pelangganList[index].name,
              style: textStyle,
            ),
            subtitle: Text(this.pelangganList[index].alamat),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Pelanggan

                dbHelper.deletePelanggan(this.pelangganList[index].id);
                updateListView();
              },
            ),
            onTap: () async {
              var pelanggan =
                  await navigateToEntryForm(context, this.pelangganList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              if (pelanggan != null){
                dbHelper.updatePelanggan(pelanggan);
                updateListView();
              }
            },
          ),
        );
      },
    );
  }

  //update List pelanggan
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Pelanggan>> pelangganListFuture = dbHelper.getPelangganList();
      pelangganListFuture.then((pelangganList) {
        setState(() {
          this.pelangganList = pelangganList;
          this.count = pelangganList.length;
        });
      });
    });
  }
}