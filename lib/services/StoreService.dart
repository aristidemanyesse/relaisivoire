import 'package:lpr/objectbox.g.dart';

Store? _store;

Future<Store> getStore() async {
  if (_store != null) return _store!;

  _store = await openStore(directory: 'relais-ivoire-db');
  return _store!;
}

void closeStore() {
  _store?.close();
  _store = null;
}
