import 'package:ejercicios_repaso/model/ContadorM.dart';
import 'package:flutter/material.dart';

class ContadorViewModel extends ChangeNotifier {
    final ContadorModel _contador;

    ContadorViewModel(this._contador);

    int get counter => _contador.cantidad;

    void increment () {
      _contador.cantidad++;
      notifyListeners();
    }

    void decrement () {
      _contador.cantidad--;
      notifyListeners();
    }
}