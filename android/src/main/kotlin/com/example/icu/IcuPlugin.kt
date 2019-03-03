package com.example.icu

import android.icu.text.BreakIterator
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.Locale
import android.text.TextUtils.substring





class IcuPlugin: MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "icu")
      channel.setMethodCallHandler(IcuPlugin())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getGraphemeList" ) {
      if(call.arguments is String) {
        val args = call.arguments as String
        result.success(getGraphemeList(args))
      }
      else {
        // @todo should provide more info like in SwiftIcuPlugin.swift
        result.error("BAD_ARGS", call.arguments.toString(), null)
      }
    } else {
      result.notImplemented()
    }
  }

  fun getGraphemeList(origin: String): List<String> {
    var boundary = BreakIterator.getCharacterInstance()
    boundary.setText(origin)

    var listR = mutableListOf(boundary.first().toString())

    while (true) {
      var c = boundary.next()
      if (c == BreakIterator.DONE) {
        break
      }
      listR.add(c.toString())
    }

    return listR

  }
}
