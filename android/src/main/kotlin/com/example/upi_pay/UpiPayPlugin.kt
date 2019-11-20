package com.drenther.upi_pay

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.util.Log
import java.util.Random
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

class UpiPayPlugin internal constructor(registrar:Registrar, channel:MethodChannel):MethodCallHandler, PluginRegistry.ActivityResultListener {
  private val activity:Activity
  private val context:Context
  internal var _result:MethodChannel.Result
  internal var requestCodeNumber = 201119
  init{
    activity = registrar.activity()
    context = registrar.activeContext()
  }
  fun onMethodCall(call:MethodCall, result:Result) {
    _result = result
    if (call.method.equals("initiateTransaction"))
    {
      val app = call.argument("app")
      val pa = call.argument("pa")
      val pn = call.argument("pn")
      val mc = call.argument("mc")
      val tr = call.argument("tr")
      val tn = call.argument("tn")
      val am = call.argument("am")
      val cu = call.argument("cu")
      val url = call.argument("url")
      try
      {
        val uriBuilder = Uri.Builder()
        uriBuilder.scheme("upi").authority("pay")
        uriBuilder.appendQueryParameter("pa", pa)
        uriBuilder.appendQueryParameter("pn", pn)
        uriBuilder.appendQueryParameter("tr", tr)
        uriBuilder.appendQueryParameter("am", am)
        uriBuilder.appendQueryParameter("cu", cu)
        if (mc != null) uriBuilder.appendQueryParameter("mc", mc)
        if (tn != null) uriBuilder.appendQueryParameter("tn", tn)

        val uri = uriBuilder.build()
        val intent = Intent(Intent.ACTION_VIEW)
        intent.setData(uri)
        intent.setPackage(app)
        
        activity.startActivityForResult(intent, requestCodeNumber)
        _result = result
      }
      catch (ex: Exception) {
        result.success("failed_to_open_app")
      }
    }
    else {
      result.notImplemented()
    }
  }
  fun onActivityResult(requestCode:Int, resultCode:Int, data:Intent):Boolean {
    if (requestCodeNumber == requestCode && _result != null)
    {
      if (data != null)
      {
        try
        {
          val response = data.getStringExtra("response")
          _result.success(response)
        }
        catch (ex:Exception) {
          _result.success("invalid_response")
        }
      }
      else
      {
        Log.d("Result", "Data = null (User canceled)")
        _result.success("user_canceled")
      }
    }
    return true
  }
  private fun appInstalledOrNot(uri:String):Boolean {
    val pm = activity.getPackageManager()
    try
    {
      pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES)
      return true
    }
    catch (e:PackageManager.NameNotFoundException) {}
    return false
  }
  companion object {
    /** Plugin registration. */
    fun registerWith(registrar:Registrar) {
      val channel = MethodChannel(registrar.messenger(), "upi_pay")
      val _plugin = FlutterUpiPlugin(registrar, channel)
      registrar.addActivityResultListener(_plugin)
      channel.setMethodCallHandler(_plugin)
    }
  }
}