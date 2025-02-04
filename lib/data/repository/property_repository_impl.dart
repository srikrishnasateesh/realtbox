import 'dart:io';

import 'package:flutter/material.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/data/datasource/remote/api_service.dart';
import 'package:realtbox/data/model/amenities/amenity-list-dto.dart';
import 'package:realtbox/data/model/birdview/birdview_dto.dart';
import 'package:realtbox/data/model/category-type/category-list-dto.dart';
import 'package:realtbox/data/model/enquiry_list/enquiry_list_dto.dart';
import 'package:realtbox/data/model/favourite_dto/favourite_dto.dart';
import 'package:realtbox/data/model/property/property_response.dart';
import 'package:realtbox/data/model/user_enquiries/user_enquiries.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/domain/entity/birdview.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';
import 'package:realtbox/domain/entity/enquiry_list/enquiry_data_model.dart';
import 'package:realtbox/domain/entity/favourite.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/entity/user_enquiry.dart';
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
      final httpResponse = await apiService.propertyList(skip, category,
          amenity_in, price_min, price_max, sort, sortDir, latitude, longitude);
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
      propertySize:
          ("${propertyData.minimumSize?.value ?? 0} ${propertyData.minimumSize?.unitType ?? ""}"),
      projectName: propertyData.projectName,
      projectBy: propertyData.projectBy ?? "",
      price: (propertyData.minimumPrice ?? 0).toString(),
      location: propertyData.formattedAddress ?? "",
      images: (propertyData.galleryPics?.map((e) => e.objectUrl).toList()) ??
          List.empty(),
      headerImages: (propertyData.headerSectionPhotos
              ?.map((e) => e.objectUrl)
              .toList()) ??
          List.empty(),
      floorImages: (propertyData.floorPlan?.map((e) => e.objectUrl).toList()) ??
          List.empty(),
      buildingPlanImages:
          (propertyData.buildingPlan?.map((e) => e.objectUrl).toList()) ??
              List.empty(),
      brochureImages:
          (propertyData.brochure?.map((e) => e.objectUrl).toList()) ??
              List.empty(),
      amenities: propertyData.advanceFeatures?.amenity ?? List.empty(),
      units: propertyData.units ?? List.empty(),
      geoLocation: propertyData.address?.location ?? List.empty(),
      videos: propertyData.video ?? List.empty(),
      favProperty: propertyData.favProperty ?? false,
      totalPrice: (propertyData.totalPrice ?? 0).toString(),
      minimumSizeUnit: propertyData.minimumSize?.unitType ?? "",
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
      icon: amenityData.icon ?? "",
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

  @override
  Future<DataState<List<UserEnquiry>>> userEnquiryList() async {
    final httpResponse = await apiService.userEnquiryList();
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      List<UserEnquiryData> dataList = httpResponse.data.data ?? List.empty();
      List<UserEnquiry> list =
          dataList.map(userenquiryDtoTUseroEnquiryModel).toList();
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

  UserEnquiry userenquiryDtoTUseroEnquiryModel(UserEnquiryData enquiryData) {
    return UserEnquiry(
        message: enquiryData.message ?? "",
        created: DateTime.parse(enquiryData.created ?? DateTime.now().toString()).toLocal() ,
        userName: enquiryData.user?.name ?? "",
        userPhone: enquiryData.phoneNumber ?? "",
        userImageUrl: enquiryData.user?.profileUrl?.objectUrl ?? "",
        propertyName: enquiryData.propertyId?.projectName ?? "");
  }

  @override
  Future<DataState<List<BirdView>>> birdView() async {
    final httpResponse = await apiService.birdView();
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      List<BirdViewData> dataList = httpResponse.data.data ?? List.empty();
      List<BirdView> list = dataList.map(birdviewDtoToBirdView).toList();
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

  BirdView birdviewDtoToBirdView(BirdViewData data) {
    return BirdView(
      id: data.id ?? "",
      location: data.address?.location ?? List.empty(),
      projectName: data.projectName ?? "",
      minPrice: (data.minimumPrice ?? 0).toString(),
      minSize:
          ("${data.minimumSize?.value ?? 0} ${data.minimumSize?.unitType ?? ""}"),
      image: data.projectImage?.objectUrl ?? "",
      totalPrice: (data.totalPrice ?? 0).toString(),
    );
  }

  @override
  Future<DataState<Property>> getPropertiesDetails(String id) async {
    try {
      final httpResponse = await apiService.propertyDetails(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.success) {
          PropertyData propertyData = response.data;
          return DataSuccess(convertPropertyDataToProperty(propertyData));
        } else {
          return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.unknown,
                requestOptions: httpResponse.response.requestOptions),
            null,
          );
        }
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.unknown,
              requestOptions: httpResponse.response.requestOptions),
          null,
        );
      }
    } on DioException catch (e) {
      return DataFailed(e, null);
    }
  }

  @override
  Future<DataState<Favourite>> toggleFavorite(String id) async {
    try {
      final httpResponse = await apiService.toggleFavourite(id);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final response = httpResponse.data;
        if (response.success) {
          FavouriteData? data = response.data;
          return DataSuccess(Favourite(
            propertyId: data?.propertyId ?? "",
            status: data?.status ?? "",
          ));
        } else {
          return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.unknown,
                requestOptions: httpResponse.response.requestOptions),
            null,
          );
        }
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.unknown,
              requestOptions: httpResponse.response.requestOptions),
          null,
        );
      }
    } on DioException catch (e) {
      return DataFailed(e, null);
    }
  }

  @override
  Future<DataState<List<Property>>> getSavedPropertiesList(
      int skip,
      String? category,
      String? amenitiesIn,
      String? price_min,
      String? price_max,
      String? sort,
      String? sortDir,
      double? latitude,
      double? longitude,
      bool onlyFavourites) async {
    try {
      final httpResponse = await apiService.savedPropertyList(
          skip,
          category,
          amenitiesIn,
          price_min,
          price_max,
          sort,
          sortDir,
          latitude,
          longitude,
          true);
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

  @override
  Future<DataState<List<Property>>> getLastViewedPropertiesList(
      int skip,
      String? category,
      String? amenitiesIn,
      String? price_min,
      String? price_max,
      String? sort,
      String? sortDir,
      double? latitude,
      double? longitude) async {
    try {
      final httpResponse = await apiService.lastViewdpropertyList(
        true,
        skip,
        category,
        amenitiesIn,
        price_min,
        price_max,
        sort,
        sortDir,
        latitude,
        longitude,
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
}
