package com.fascode.advertising_info

import android.content.Context
import android.os.AsyncTask
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull;
import com.google.android.gms.ads.identifier.AdvertisingIdClient

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlin.concurrent.thread

/** AdvertisingInfoPlugin */
class AdvertisingInfoPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  private fun onAttachedToEngine(applicationContext: Context, messenger: BinaryMessenger) {
    this.context = applicationContext
    this.channel = MethodChannel(messenger, "advertising_info")
    this.channel.setMethodCallHandler(this);
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    onAttachedToEngine(flutterPluginBinding.applicationContext, flutterPluginBinding.binaryMessenger)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getAdvertisingInfo") {
      thread {
        AdvertisingIdClient.getAdvertisingIdInfo(context)?.let {
          Handler(Looper.getMainLooper()).post {
            result.success(mapOf("id" to it.id, "isLimitAdTrackingEnabled" to it.isLimitAdTrackingEnabled))
          }
        } ?: Handler(Looper.getMainLooper()).post {
          result.error("-1", "Internal Error", "Can not read AdvertisingIdInfo from GMS")
        }
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val instance = AdvertisingInfoPlugin()
      instance.onAttachedToEngine(registrar.context(), registrar.messenger())
    }
  }
}
