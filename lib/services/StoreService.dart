import 'package:relaisivoire/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

Store? _store;

Future<Store> getStore() async {
  if (_store != null && !_store!.isClosed()) return _store!;

  final dir = await getApplicationDocumentsDirectory();
  _store = await openStore(directory: '${dir.path}/relais-ivoire-db');

  return _store!;
}

void closeStore() {
  _store?.close();
  _store = null;
}
