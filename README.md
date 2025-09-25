# GateKeeper - Call Screening App

<p align="center"> <img src="https://img.shields.io/badge/Flutter-3.19-blue?style=flat&logo=flutter" alt="Flutter Version"> <img src="https://img.shields.io/badge/Dart-3.1-blue?style=flat&logo=dart" alt="Dart Version"> <img src="https://img.shields.io/badge/License-MIT-green?style=flat" alt="License"> </p>

 GateKeeper is a smart call screening application built with Flutter for Android that automatically filters incoming calls based on your personalized whitelist and country code blacklist.

 # 🛡️ How GateKeeper Works

📞 Incoming Call Detection

   GateKeeper monitors incoming calls in real-time

   Extracts and analyzes the caller's phone number and country code

✅ Priority Whitelist Check

   Number found in whitelist: Call rings normally (highest priority)

   Number not in whitelist: Proceeds to country code analysis

🌍 Country Code Verification

   Country code allowed: Call rings through

   Country code blacklisted: Call automatically blocked

📊 Smart Tracking

   Blocked calls counter increments automatically

   Visual statistics displayed in the dashboard
