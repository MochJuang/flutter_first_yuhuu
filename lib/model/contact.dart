import 'dart:core';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Contact {
  int id;
  String _nama;
  String _phone;

  Contact(this._nama, this._phone);

  // ubah data ke type map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['nama'] = this._nama;
    map['phone'] = this._phone;
  }

  // ubah dari map ke contact
  Contact.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this._nama = map['name'];
    this._phone = map['phone'];
  }

  // getter
  int getId() => this.id;
  String getName() => this._nama;
  String getPhone() => this._phone;

  // setter
  void set({String name, String phone}) {
    this._nama = name;
    this._phone = phone;
  }
}
