import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:html';

import '../../services/auth_service.dart';
import '../../services/home_service.dart';
import '../../services/detail_promise_service.dart';
import '../../models/promise_model.dart';

part './home_screen/home_screen.dart';
part './home_screen/detail_promise.dart';
part './login_screen/login_screen.dart';
