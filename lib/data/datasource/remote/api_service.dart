import 'package:flutter/foundation.dart';
import 'package:realtbox/config/resources/constants/api_constnats.dart';
import 'package:realtbox/data/model/amenities/amenity-list-dto.dart';
import 'package:realtbox/data/model/birdview/birdview_dto.dart';
import 'package:realtbox/data/model/category-type/category-list-dto.dart';
import 'package:realtbox/data/model/delete_response/delete_response.dart';
import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/data/model/enquiry_list/enquiry_list_dto.dart';
import 'package:realtbox/data/model/favourite_dto/favourite_dto.dart';
import 'package:realtbox/data/model/property-detail-dto/property_details_dto.dart';
import 'package:realtbox/data/model/property/property_response.dart';
import 'package:realtbox/data/model/self/self_response.dart';
import 'package:realtbox/data/model/user_enquiries/user_enquiries.dart';
import 'package:realtbox/data/model/version/version-dto.dart';
import 'package:realtbox/domain/entity/delete_account/delete_account_request.dart';
import 'package:realtbox/domain/entity/login/login_request_entity.dart';
import 'package:realtbox/domain/entity/login/login_response.dart';
import 'package:realtbox/domain/entity/token/refresh_token_request.dart';
import 'package:realtbox/domain/entity/token/token_request_entity.dart';
import 'package:realtbox/domain/entity/token/token_response.dart';
import 'package:realtbox/domain/entity/version-request/version-request.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST(ApiConstants.versionCheck)
  Future<HttpResponse<VersionDto>> version(
    @Body() VersionRequest versionRequest,
  );

  @POST(ApiConstants.requestOtp)
  Future<HttpResponse<LoginResponse>> requestOtp(
    @Body() LoginRequest loginRequest,
  );

  @POST(ApiConstants.requestToken)
  Future<HttpResponse<TokenResponse>> token(
    @Body() TokenRequest tokenRequest,
  );

  @POST(ApiConstants.refreshToken)
  Future<HttpResponse<TokenResponse>> refreshToken(
    @Body() RefreshTokenRequest tokenRequest,
  );

  @GET(ApiConstants.self)
  Future<HttpResponse<SelfResponse>> self();

  @GET(ApiConstants.property)
  Future<HttpResponse<PropertyResponse>> propertyList(
    @Query('skip') int skip,
    @Query('categoryName') String? categoryName,
    @Query('amenity_in') String? amenity_in,
    @Query('minimumPrice') String? price_min,
    @Query('maximumPrice') String? price_max,
    @Query('sort') String? sort,
    @Query('sortDir') String? sortDir,
    @Query('latitude') double? latitude,
    @Query('longitude') double? longitude,
  );

  @GET(ApiConstants.property)
  Future<HttpResponse<PropertyResponse>> savedPropertyList(
    @Query('skip') int skip,
    @Query('categoryName') String? categoryName,
    @Query('amenity_in') String? amenity_in,
    @Query('minimumPrice') String? price_min,
    @Query('maximumPrice') String? price_max,
    @Query('sort') String? sort,
    @Query('sortDir') String? sortDir,
    @Query('latitude') double? latitude,
    @Query('longitude') double? longitude,
    @Query('onlyFavourites') bool onlyFavourites,
  );

  @GET(ApiConstants.property)
  Future<HttpResponse<PropertyResponse>> lastViewdpropertyList(
    @Query('lastViewed') bool lastViewed,
    @Query('skip') int skip,
    @Query('categoryName') String? categoryName,
    @Query('amenity_in') String? amenity_in,
    @Query('minimumPrice') String? price_min,
    @Query('maximumPrice') String? price_max,
    @Query('sort') String? sort,
    @Query('sortDir') String? sortDir,
    @Query('latitude') double? latitude,
    @Query('longitude') double? longitude,
  );

  @GET("${ApiConstants.propertyDetails}/{id}")
  Future<HttpResponse<PropertyDetailsDto>> propertyDetails(
    @Path("id") String id,
  );

  @POST("${ApiConstants.enquiry}/{id}")
  Future<HttpResponse> enquiry(
    @Path("id") String id,
    @Body() EnquiryRequest enquiryRequest,
  );

  @GET("${ApiConstants.enquiryList}/{id}")
  Future<HttpResponse<EnquiryList>> enquiryList(
    @Path("id") String id,
  );

  @GET(ApiConstants.userEnquiryList)
  Future<HttpResponse<UserEnquiries>> userEnquiryList();

  @GET(ApiConstants.categoryList)
  Future<HttpResponse<CategoryList>> categoryList();

  @GET(ApiConstants.amenityList)
  Future<HttpResponse<AmenityList>> amenityList();

  @POST(ApiConstants.deleteAccount)
  Future<HttpResponse<DeleteResponse>> deleteAccountt(
    @Body() DeleteAccountRequest deleteAccount,
  );

  @GET(ApiConstants.birdView)
  Future<HttpResponse<BirdViewDto>> birdView();

  @POST("${ApiConstants.favProperty}/{id}")
  Future<HttpResponse<FavouriteDto>> toggleFavourite(
    @Path("id") String id,
  );
}
