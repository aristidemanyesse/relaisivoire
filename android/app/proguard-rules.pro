#############################################
# ✅ FLUTTER EMBEDDING
#############################################
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**

#############################################
# ✅ FIREBASE
#############################################
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Crashlytics (pour rapport d'erreurs lisibles)
-keepattributes SourceFile,LineNumberTable
-keep class com.google.firebase.crashlytics.** { *; }

#############################################
# ✅ OBJECTBOX
#############################################
-keep class io.objectbox.** { *; }
-keepclassmembers class * {
  @io.objectbox.annotation.* <methods>;
}
-dontwarn io.objectbox.**

#############################################
# ✅ DIO (HTTP client + Interceptors)
#############################################
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }
-dontwarn okhttp3.**
-dontwarn retrofit2.**
-dontwarn okio.**

#############################################
# ✅ NOTIFICATIONS (FCM / awesome_notifications)
#############################################
-keep class me.carda.awesome_notifications.** { *; }
-dontwarn me.carda.awesome_notifications.**

-keep class com.google.firebase.messaging.** { *; }
-dontwarn com.google.firebase.messaging.**

#############################################
# ✅ JSON SERIALIZATION / REFLECTION (Dart/Flutter)
#############################################
-keep class **.model.** { *; }      # tes modèles
-keep class **.dto.** { *; }
-keepclassmembers class * {
  <init>(...);
}
-keepclassmembers class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

#############################################
# ✅ GETX
#############################################
-keep class ** extends GetxController
-keep class ** extends Bindings
-dontwarn **.get.**

#############################################
# ✅ INTERNATIONALISATION / INTL
#############################################
-keep class org.intl.** { *; }
-dontwarn org.intl.**

#############################################
# ✅ GÉOLOCALISATION / MAPS
#############################################
-keep class com.google.android.gms.maps.** { *; }
-keep class com.google.android.gms.location.** { *; }
-dontwarn com.google.android.gms.**

#############################################
# ✅ GÉNÉRÉ AUTOMATIQUEMENT
#############################################
-keep class com.example.lprdeli.** { *; }  # Ton package Java
