import 'package:realtbox/config/resources/constants/api_constnats.dart';
import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/data/model/property/property_response.dart';
import 'package:realtbox/data/model/self/self_response.dart';
import 'package:realtbox/domain/entity/login/login_request_entity.dart';
import 'package:realtbox/domain/entity/login/login_response.dart';
import 'package:realtbox/domain/entity/otp/token_request_entity.dart';
import 'package:realtbox/domain/entity/otp/token_response.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST(ApiConstants.requestOtp)
  Future<HttpResponse<LoginResponse>> requestOtp(
    @Body() LoginRequest loginRequest,
  );

  @POST(ApiConstants.requestToken)
  Future<HttpResponse<TokenResponse>> token(
    @Body() TokenRequest tokenRequest,
  );

  @GET(ApiConstants.self)
  Future<HttpResponse<SelfResponse>> self();

  @GET(ApiConstants.property)
  Future<HttpResponse<PropertyResponse>> propertyList();

  @POST("${ApiConstants.enquiry}/{id}")
  Future<HttpResponse> enquiry(
    @Path("id") String id,
    @Body() EnquiryRequest enquiryRequest,
  );
}
