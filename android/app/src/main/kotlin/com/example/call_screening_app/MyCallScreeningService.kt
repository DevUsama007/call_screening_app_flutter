package com.example.call_screening_app
import android.content.Context
import android.telecom.Call
import android.telecom.CallScreeningService
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine

class MyCallScreeningService : CallScreeningService() {
    companion object {
        var isBlockingEnabled = false
        var whitelist: List<String> = listOf()
        var methodChannel: MethodChannel? = null
        fun testLog() {
            Log.d("CallBlocker", "✅ testtestLog() called from Flutter")
            android.util.Log.d("CallBlocker", "✅ testtest log from Kotlin via MethodChannel")

        }
    }
    init {
        android.util.Log.d("CallBlocker", "✅ Test123 log from Kotlin via MethodChannel")
        Log.d("CallBlocker", "⚡ MyCallScreeningService class loaded into memory")
    }
    override fun onCreate() {
        super.onCreate()
        
        android.util.Log.d("CallBlocker", "✅ Testoncreat pr log from Kotlin via MethodChannel")
        Log.d("CallBlocker", "MyCallScreeningService created ✅")
    }
    override fun onDestroy() {
        super.onDestroy()
        Log.d("CallScreeningService", "onDestroy ❌")
    }

    override fun onScreenCall(callDetails: Call.Details) {
        Log.d("CallBlocker", "onScreenCall TRIGGERED ✅ number=${callDetails.handle.schemeSpecificPart}")
        android.util.Log.d("CallBlocker", "✅ Test123 log from Kotlin via MethodChannel")
        Log.d("CallBlocker", "⚡ MyCallScreeningService class loaded into memory")
        val rawNumber = callDetails.handle.schemeSpecificPart ?: ""
        val number =  normalizeNumber(rawNumber)
       

        if (isBlockingEnabled &&
            (number.startsWith("92") || number.startsWith("91")) &&
            !whitelist.contains(number)) {

            val response = CallResponse.Builder()
                .setDisallowCall(true)
                .setRejectCall(true)
                .build()

            respondToCall(callDetails, response)
             val prefs = getSharedPreferences("call_blocker_prefs", Context.MODE_PRIVATE)
            val count = prefs.getInt("blockedCount", 0) + 1
            prefs.edit().putInt("blockedCount", count).apply()
            Log.d("CallBlocker", "Blocked: $number")
            methodChannel?.invokeMethod("onCallBlocked", null)
        } else {
            respondToCall(callDetails, CallResponse.Builder().build())
        }
    }
    private fun normalizeNumber(number: String): String {
    var normalized = number.trim()

    // Remove + sign if exists
    if (normalized.startsWith("+")) {
        normalized = normalized.substring(1)
    }

    // If it starts with "0" (local format in PK/IN), replace with "92" or "91"
    if (normalized.startsWith("0")) {
        // Example for Pakistan (+92)
        normalized = "92" + normalized.substring(1)
    }

    return normalized
}

}
