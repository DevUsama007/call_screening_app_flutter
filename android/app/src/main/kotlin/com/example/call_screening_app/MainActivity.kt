package com.example.call_screening_app

import android.app.role.RoleManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "call_blocker_channel"
    private val REQUEST_ID = 1001

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        // Save channel reference for MyCallScreeningService to use
        MyCallScreeningService.methodChannel = methodChannel

        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                // ✅ Role-related methods
                "requestRole" -> {
                    requestCallScreeningRole()
                    result.success(null)
                }
                "isDefaultCallScreeningApp" -> {
                    result.success(isDefaultCallScreeningApp())
                }

                // ✅ Blocking-related methods
                "setBlockingEnabled" -> {
                     android.util.Log.d("Blockeing enabled", "✅ set blocking enabled log from Kotlin via MethodChannel")
                
                    val enabled = call.argument<Boolean>("enabled") ?: false
                    MyCallScreeningService.isBlockingEnabled = enabled
                    result.success(null)
                }
                "updateWhitelist" -> {
                    val numbers = call.argument<List<String>>("numbers") ?: listOf()
                    MyCallScreeningService.whitelist = numbers
                    result.success(null)
                }
                 "testLog" -> {
                    
                 MyCallScreeningService.testLog()
                 android.util.Log.d("CallBlocker", "✅ Test loglog from Kotlin via MethodChannel")
                 result.success("Log sent")
                }

                else -> result.notImplemented()
            }
        }
    }

    private fun requestCallScreeningRole() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val roleManager = getSystemService(Context.ROLE_SERVICE) as RoleManager
            if (!roleManager.isRoleHeld(RoleManager.ROLE_CALL_SCREENING)) {
                val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_CALL_SCREENING)
                startActivityForResult(intent, REQUEST_ID)
            }
        }
    }

    private fun isDefaultCallScreeningApp(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val roleManager = getSystemService(Context.ROLE_SERVICE) as RoleManager
            roleManager.isRoleHeld(RoleManager.ROLE_CALL_SCREENING)
        } else {
            false
        }
    }
}
