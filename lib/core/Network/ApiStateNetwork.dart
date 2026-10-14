import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:track_loved/core/Data/BodyModel/ForgetPasswordOtpBodyModel.dart';
import 'package:track_loved/core/Data/BodyModel/ForgotPasswordBodyModel.dart';
import 'package:track_loved/core/Data/BodyModel/LoginBodyModel.dart';
import 'package:track_loved/core/Data/BodyModel/OtpVerifyBodyModel.dart';
import 'package:track_loved/core/Data/BodyModel/RegisterBodyModel.dart';
import 'package:track_loved/core/Data/BodyModel/ResetPasswordBodyModel.dart';
import 'package:track_loved/core/Data/ResponseModel/AddNetworkSearchResModel.dart';
import 'package:track_loved/core/Data/ResponseModel/ForgetPasswordResMode.dart';
import 'package:track_loved/core/Data/ResponseModel/ForgotPasswordOtpResModel.dart';
import 'package:track_loved/core/Data/ResponseModel/LoginResModel.dart';
import 'package:track_loved/core/Data/ResponseModel/NetworkRequestResModel.dart';
import 'package:track_loved/core/Data/ResponseModel/OtpVerifyResModel.dart';
import 'package:track_loved/core/Data/ResponseModel/RegisterResModel.dart';
import 'package:track_loved/core/Data/ResponseModel/ResetPasswordResModel.dart';

part 'ApiStateNetwork.g.dart';

@RestApi(baseUrl: "https://grhdxh1f-3002.inc1.devtunnels.ms")
abstract class ApiStateNetwork {
  factory ApiStateNetwork(Dio dio, {String baseUrl}) = _ApiStateNetwork;

  @POST("/api/v1/auth/login")
  Future<LoginResModel> login(@Body() LoginBodyModel body);

  @POST("/api/v1/auth/register")
  Future<RegisterResModel> register(@Body() RegisterBodyModel body);

  @POST("/api/v1/auth/verify-otp")
  Future<OtpVerifyResModel> otp(@Body() OtpVerifyBodyModel body);

  @POST("/api/v1/auth/forgot-password")
  Future<ForgetPasswordResModel> forgetPassword(
    @Body() ForgetPasswordBodyModel body,
  );

  @POST("/api/v1/auth/verify-reset-otp")
  Future<ForgetPasswordOtpResModel> forgetPasswordOtp(
    @Body() ForgetPasswordOtpBodyModel body,
  );

  @POST("/api/v1/auth/reset-password")
  Future<ResetPasswordResModel> resetPassword(
    @Body() ResetPasswordBodyModel body,
  );

  @GET("/api/v1/auth/searchUsers")
  Future<AddNetworkSearchResModel> getAddNetworkSearch(
    @Query("search") String search,
  );

  @GET("/api/v1/network/requests")
  Future<NetworkRequestResModel> getNetworkRequest();
}
