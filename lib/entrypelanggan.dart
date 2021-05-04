import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pelanggan.dart';

class EntryPelanggan extends StatefulWidget {
  final Pelanggan pelanggan;

  EntryPelanggan(this.pelanggan);
  @override
  EntryPelangganState createState() => EntryPelangganState(this.pelanggan);
}

//class controller
class EntryPelangganState extends State<EntryPelanggan> {
  Pelanggan pelanggan;

  EntryPelangganState(this.pelanggan);

  TextEditingController nameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController nohpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (pelanggan != null) {
      nameController.text = pelanggan.name;
      alamatController.text = pelanggan.alamat;
      nohpController.text = pelanggan.nohp.toString();
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: pelanggan == null ? Text('Tambah') : Text('Ubah'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // nama
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Pelanggan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // harga
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: alamatController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),
            //stock
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nohpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'No HP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            //Tombol button
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  //tombol simpan
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (pelanggan == null) {
                          // tambah data
                          pelanggan = Pelanggan(
                              nameController.text,
                              alamatController.text,
                              int.parse(nohpController.text));
                        } else {
                          // ubah data
                          pelanggan.name = nameController.text;
                          pelanggan.nohp = nohpController.text;
                          pelanggan.alamat = alamatController.text;
                        }
                        //kembali ke layar sebelumnya dengan membawa objek pelanggan
                        Navigator.pop(context, pelanggan);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  //tombol batal
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}