class Pelanggan{
  int _id;
  String _name;
  String _alamat;
  int _nohp;


  int get id => _id;

  String get name => this._name;
  set name(String value) => this._name = value;

  get alamat => this._alamat;
  set alamat(String value) => this._alamat = value;


  get nohp => this._nohp;  
  set nohp(value) => this._nohp = value;


  // Konstruktor versi 1
  Pelanggan(this._name, this._alamat,this._nohp);


  // konstruktor versi 2:konversi dari Map ke Pelanggan
  Pelanggan.fromMap(Map<String, dynamic>map){
    this._id = map['id'];
    this._name = map['name'];
    this._alamat = map['alamat'];
    this._nohp = map['nohp'];

  }

  // konversi dari Pelanggan ke Map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['alamat'] = alamat;
    map['nohp'] = nohp;
    return map;
  }

  }