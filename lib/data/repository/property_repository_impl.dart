import 'dart:io';

import 'package:flutter/material.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/data/datasource/remote/api_service.dart';
import 'package:realtbox/data/model/property/property_response.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';
import 'package:dio/dio.dart';

class PropertyRepositoryImplementation extends PropertyRepository {
  final ApiService apiService;

  PropertyRepositoryImplementation({required this.apiService});

  @override
  Future<DataState<List<Property>>> getPropertiesList() async {
    try {
      /* return DataSuccess(LoginResponseModel(
          success: true, data: Data(message: "mes", isExists: false))); */
      final httpResponse = await apiService.propertyList();
      debugPrint(httpResponse.toString());
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.success) {
          List<PropertyData> propertyDataList = response.data;
          List<Property> list =
              propertyDataList.map(convertPropertyDataToProperty).toList();
          return DataSuccess(list);
        } else {
          return DataSuccess(List.empty());
        }
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.unknown,
              requestOptions: httpResponse.response.requestOptions),
          List.empty(),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e, null);
    }
  }

  Property convertPropertyDataToProperty(PropertyData propertyData) {
    return Property(
      propertyId: propertyData.id,
      categoryId: propertyData.category,
      categoryName: propertyData.categoryName,
      subCategoryId: propertyData.subcategory,
      subCategoryName: propertyData.subcategoryName,
      description: propertyData.description,
      assetId: propertyData.asset,
      assetName: propertyData.assetName,
      propertySize: propertyData.propertysize,
      projectName: propertyData.projectName,
      price: "${propertyData.price}",
      location: propertyData.location ?? "",
      images: propertyData.propertyDocs.map((e) => e.objectUrl).toList(),
    );
  }
}
