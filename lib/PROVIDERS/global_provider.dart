import 'package:GOCart/PROVIDERS/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Processes { waiting, done }

class GlobalProvider extends ChangeNotifier {
  Processes _process = Processes.done;
  Processes get process => _process;

  Map<String, dynamic>? _prodData;
  Map<String, dynamic>? get prodData => _prodData;

  List<String> _history = [];
  List<String> get history => _history;

  setProcess(Processes process) {
    _process = process;
    notifyListeners();
  }

  setLink(String? prodId, BuildContext context) async {
    if (prodId != null && prodId != 'null') {
      await Provider.of<ProductProvider>(context, listen: false)
          .getProductData(prodId)
          .then((value) {
        _prodData = value;
      });
      notifyListeners();
    }
  }

  setHistory(List<String> hist) {
    _history = hist;
    notifyListeners();
  }
}
