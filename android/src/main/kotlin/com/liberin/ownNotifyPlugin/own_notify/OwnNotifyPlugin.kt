package com.liberin.ownNotifyPlugin.own_notify

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.graphics.Color
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** OwnNotifyPlugin */
class OwnNotifyPlugin: FlutterPlugin, MethodCallHandler, FlutterActivity() {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity

  private lateinit var channel : MethodChannel

  @get:JvmName("getAdapterContext")
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, Definitions.CHANNEL_FLUTTER_PLUGIN)
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method){
      Definitions.CHANNEL_METHOD_INITIALIZE ->{
        Log.d("OWN_NOTIFY_PLUGIN: ", "OwnNotify service initialized")
        result.success(true)
      }
      Definitions.CHANNEL_METHOD_SHOW_PLATFORM_VERSION ->{
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      Definitions.CHANNEL_METHOD_SHOW_SOME_DATA->{
        result.success("this is some dummy data from native: ")
      }
      Definitions.CHANNEL_METHOD_CREATE_NOTIFICATION->{
        createNotificationChannels()
        val title = call.argument<String>("notifyTitle")
        val bodyMsg = call.argument<String>("notifyBody")
        showNotificationOnChannel1(context, bodyMsg.toString(), "sender")
      }

      else->{
        result.notImplemented()
      }
    }
  }

  private fun createNotificationChannels() {
    if(Build.VERSION.SDK_INT >=Build.VERSION_CODES.O){
      val channel1:NotificationChannel = NotificationChannel(
        Definitions.CHANNEL_ID1,
        "channel 1 test",
        NotificationManager.IMPORTANCE_HIGH
      )
      channel1.description="hello channel 1"

      //TODO create other channels below
      ////////////////////
      val manager: NotificationManager = context.getSystemService(NotificationManager::class.java)
      manager.createNotificationChannel(channel1)

    }
  }

  private fun showNotificationOnChannel1(
    context: Context,
    msg: CharSequence,
    type: String
  ) {
    val notification = NotificationCompat.Builder(
      context,
      Definitions.CHANNEL_ID1
    ).setSmallIcon(R.drawable.icon)
      .setContentTitle("hello aks")
      .setContentText("hello long text in notification")
      .setPriority(NotificationCompat.PRIORITY_HIGH)
      .setCategory(NotificationCompat.CATEGORY_MESSAGE)
      .setAutoCancel(true)
      .setOnlyAlertOnce(true)
      .setColor(Color.BLUE)
      .build()

    val notificationManager: NotificationManagerCompat = NotificationManagerCompat.from(context)
      notificationManager.notify(1, notification)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
