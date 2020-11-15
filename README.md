# jariapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




## Build An Android Release Apk

AndroidManifest.xml, located in <app dir>/android/app/src/main 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
uses-permission :
-------------------------------------------
Internet permission:
.......................
<uses-permission android:name="android.permission.INTERNET" />

Google Map permission :
.......................
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />


- Add key google Map to use pluging google :
-------------------------------------------
    
<application...
	 <meta-data android:name="com.google.android.geo.API_KEY" android:value="AIzaSyAJ2jma1d-UAUU8C5vB3OQFc3fafCivohA"/>

c/:projectName> flutter build apk  --build-name=1.0.1 --build-number=2 




how to change App Package name Or Application ID :
=-------------------------------------------------=
use dart package to change Application ID from exp: 
	[ c: projectname> flutter pub run change_app_package_name:main com.new.package.name]
change package="com.example.jaripp" to package="com.danone.jarryApp"  
=-------------------------------------------------=
  change_app_package_name 0.1.2 // affter changing name you can desable this plugin.
=-------------------------------------------------=

ENABLE SDK Maps pour Android/Ios
https://console.cloud.google.com/
