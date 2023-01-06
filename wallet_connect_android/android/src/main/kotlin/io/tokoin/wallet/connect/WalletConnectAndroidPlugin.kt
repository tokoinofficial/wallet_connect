package io.tokoin.wallet.connect

import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import java.util.ArrayList
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * WalletConnectAndroidPlugin
 */
class WalletConnectAndroidPlugin : FlutterPlugin, MethodCallHandler {
  private var channel: MethodChannel? = null
  private var mContext: Context? = null
  @Override
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getBinaryMessenger(), "wallet_connect_android")
    channel!!.setMethodCallHandler(this)
    mContext = flutterPluginBinding.getApplicationContext()
  }

  private var mCallbackDispatcherHandle: Long = 0
  @Override
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method.equals("getPlatformName")) {
      result.success("Android")
    } else if (call.method.equals("initializeForBackground")) {
      val args = call.arguments() as ArrayList<*>?
      val callBackHandle = args?.get(0) as Long
      mCallbackDispatcherHandle = callBackHandle
      result.success(null)
      return
    } else if (call.method.equals("callBackgroundService")) {
      val args = call.arguments() as ArrayList<*>?
      val callbackHandle = args?.get(0) as Long
      val i = Intent(mContext, io.tokoin.wallet.connect.MyService::class.java)
      i.putExtra(CALLBACK_HANDLE_KEY, callbackHandle)
      i.putExtra(CALLBACK_DISPATCHER_HANDLE_KEY, mCallbackDispatcherHandle)
      mContext?.startService(i)
      result.success(null)
    } else result.notImplemented()
  }

  @Override
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    this.channel?.setMethodCallHandler(null)
  }

  companion object {
    const val CALLBACK_HANDLE_KEY = "callback_handle_key"
    const val CALLBACK_DISPATCHER_HANDLE_KEY = "callback_dispatcher_handle_key"
  }
}