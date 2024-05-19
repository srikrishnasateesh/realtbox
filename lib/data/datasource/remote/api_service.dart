import 'package:realtbox/config/resources/constants/api_constnats.dart';
import 'package:realtbox/domain/authentication/entity/login/login_request_entity.dart';
import 'package:realtbox/domain/authentication/entity/login/login_response.dart';
import 'package:realtbox/domain/authentication/entity/otp/token_request_entity.dart';
import 'package:realtbox/domain/authentication/entity/otp/token_response.dart';
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
}
