import 'package:get/get.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/NotificationController.dart';
import 'package:lpr/services/ApiService.dart';
import 'package:lpr/services/StoreService.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class NotificationClient {
  int id = 0;

  @Index()
  String uid;

  String title;
  bool read;
  String message;
  bool priority;
  DateTime? date_creation;

  NotificationClient({
    this.uid = "",
    this.title = "",
    this.read = false,
    this.message = "",
    this.priority = false,
    this.date_creation,
  });

  factory NotificationClient.fromJson(Map<String, dynamic> json) {
    return NotificationClient(
      uid: json['id'],
      title: json['title'],
      read: json['read'],
      message: json['message'],
      priority: json['priority'],
      date_creation: DateTime.tryParse(json['date_creation'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        'read': read,
        'title': title,
        'priority': priority,
        'message': message,
      };

  Future<bool> readIt() async {
    final store = await getStore();
    final notificationBox = store.box<NotificationClient>();
    final response =
        await ApiService.patch("api/notifications/$uid/", {'read': true});
    if (response["status"] && response["data"] != null) {
      read = true;
      notificationBox.put(this);
      final connected = await GeneralController.isConnected();
      if (connected) {
        NotificationController notificationClientController = Get.find();
        notificationClientController.reload();
      }

      return true;
    }
    return false;
  }
}
