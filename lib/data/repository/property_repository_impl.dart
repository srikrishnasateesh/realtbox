import 'dart:io';

import 'package:flutter/material.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/data/datasource/remote/api_service.dart';
import 'package:realtbox/data/model/amenities/amenity-list-dto.dart';
import 'package:realtbox/data/model/category-type/category-list-dto.dart';
import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/data/model/enquiry_list/enquiry_list_dto.dart';
import 'package:realtbox/data/model/property/property_response.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';
import 'package:realtbox/domain/entity/enquiry_list/enquiry_data_model.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';
import 'package:dio/dio.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';

class PropertyRepositoryImplementation extends PropertyRepository {
  final ApiService apiService;

  PropertyRepositoryImplementation({required this.apiService});

  @override
  Future<DataState<List<Property>>> getPropertiesList(
    int skip,
    String? category,
    String? amenity_in,
    String? price_min,
    String? price_max,
    String? sort,
    String? sortDir,
    double? latitude,
    double? longitude,
  ) async {
    try {
      /* return DataSuccess(LoginResponseModel(
          success: true, data: Data(message: "mes", isExists: false))); */
      final httpResponse = await apiService.propertyList(
        skip,
        category,
        amenity_in,
        price_min,
        price_max,
        sort,
        sortDir,
        latitude,
        longitude
        
      );
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
      propertySize: propertyData.propertySize.toString(),
      projectName: propertyData.projectName,
      price: "${propertyData.price}",
      location: propertyData.formattedAddress ?? propertyData.location ?? "",
      images: propertyData.propertyDocs.map((e) => e.objectUrl).toList(),
      amenities: propertyData.advanceFeatures?.amenity ?? List.empty(),
    );
  }

  @override
  Future<DataState> enquiry(EnquiryRequestObject enquiryRequestObject) async {
    final httpResponse = await apiService.enquiry(
        enquiryRequestObject.propertyId, enquiryRequestObject.enquiryRequest);
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSuccess(null);
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
  }

  @override
  Future<DataState<List<EnquiryDataModel>>> enquiryList(
      String propertyId) async {
    final httpResponse = await apiService.enquiryList(propertyId);
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      List<EnquiryData> dataList = httpResponse.data.data ?? List.empty();
      List<EnquiryDataModel> list =
          dataList.map(enquiryDtoToEnquiryModel).toList();
      return DataSuccess(list);
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
  }

  EnquiryDataModel enquiryDtoToEnquiryModel(EnquiryData enquiryData) {
    return EnquiryDataModel(
      message: enquiryData.message ?? "",
      created: enquiryData.created ?? DateTime.now(),
      userName: enquiryData.user?.name ?? "",
      userPhone: enquiryData.phoneNumber ?? "",
      userImageUrl: enquiryData.user?.profileUrl?.objectUrl ?? "",
    );
  }

  @override
  Future<DataState<List<Category>>> categoryList() async {
    final httpResponse = await apiService.categoryList();
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      List<CategoryData> dataList = httpResponse.data.data ?? List.empty();
      List<Category> list = dataList.map(categoryDtoToCatgoryModel).toList();
      return DataSuccess(list);
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
  }

  Category categoryDtoToCatgoryModel(CategoryData categoryData) {
    return Category(
      displayName: categoryData.name ?? "",
      key: categoryData.name ?? "",
    );
  }

  Amenity amenityDtoToAmenityModel(AmenityData amenityData) {
    return Amenity(
      id: amenityData.id ?? "",
      name: amenityData.name ?? "",
    );
  }

  @override
  Future<DataState<List<Amenity>>> amenityList() async {
    final httpResponse = await apiService.amenityList();
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      List<AmenityData> dataList = httpResponse.data.data ?? List.empty();
      List<Amenity> list = dataList.map(amenityDtoToAmenityModel).toList();
      return DataSuccess(list);
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
  }
}
