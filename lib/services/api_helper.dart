import 'dart:convert';

import 'package:api/constant/constant.dart';
import 'package:api/models/products_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ApiHelper {
  static Future<List<ProductsResponse>> getProduct(BuildContext context) async {
    try {
      var url = Uri.http(kBaseUrl, kProductsUrl);
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      return data
          .map<ProductsResponse>((e) => ProductsResponse.fromJson(e))
          .toList();
    } catch (e) {
      QuickAlert.show(
          // ignore: use_build_context_synchronously
          context: context,
          type: QuickAlertType.error,
          title: "Error",
          text: "Failed to load products : $e",
          confirmBtnText: "OK",
          onConfirmBtnTap: () {
            Navigator.pop(context);
          });
      rethrow;
    }
  }

  static Future<List<String>> getProductCategory(BuildContext context) async {
    try {
      var url = Uri.http(kBaseUrl, kProductsCategoryUrl);
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      return data.map<String>((e) => e.toString()).toList();
    } catch (e) {
      QuickAlert.show(
          // ignore: use_build_context_synchronously
          context: context,
          type: QuickAlertType.error,
          title: "Error",
          text: "Failed to load products : $e",
          confirmBtnText: "OK",
          onConfirmBtnTap: () {
            Navigator.pop(context);
          });
      rethrow;
    }
  }

  static Future<List<ProductsResponse>> getProductBycategoryName(
      BuildContext context, String categoryName) async {
    try {
      String url = "https://fakestoreapi.com/products/category/$categoryName";
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      return data
          .map<ProductsResponse>((e) => ProductsResponse.fromJson(e))
          .toList();
    } catch (e) {
      QuickAlert.show(
          // ignore: use_build_context_synchronously
          context: context,
          type: QuickAlertType.error,
          title: "Error",
          text: "Failed to load products : $e",
          confirmBtnText: "OK",
          onConfirmBtnTap: () {
            Navigator.pop(context);
          });
      rethrow;
    }
  }
}
