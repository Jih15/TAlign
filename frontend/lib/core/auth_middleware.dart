import 'package:flutter/material.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route){
    final token = LocalStorageService.getToken();
    if (token == null || token.isEmpty){
      print('[AUTH MIDDLEWARE] Akses ditolak, redirect ke login');
      return RouteSettings(name: '/login');
    }
    return null;
  }
}