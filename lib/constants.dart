import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

// const Color primaryColor = Color(0xFF7B61FF);
// const Color primaryColor = Color(0xFFFDD835) ;
const Color primaryColor = Color(0xFFFDD835);

// String email = '';
String? emailinfo = FirebaseAuth.instance.currentUser?.email;

// SHA1: C2:1F:7F:91:95:D4:8B:28:C5:79:B1:CB:FA:AC:DB:06:64:BE:6D:A7
// SHA256: 23:A1:92:6B:E1:ED:F2:B2:9F:F4:62:B9:36:9F:6A:0F:E8:E0:4B:AC:61:BA:77:00:C3:1A:BB:AA:2A:13:D2:91