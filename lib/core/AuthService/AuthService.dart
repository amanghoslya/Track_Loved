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
import 'package:track_loved/core/Network/ApiStateNetwork.dart';

class Authservice {
  final ApiStateNetwork api;
  Authservice(this.api);

  Future<LoginResModel> loginData({required email, required password}) async {
    try {
      final body = LoginBodyModel(email: email, password: password);
      final response = await api.login(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<RegisterResModel> registerData({
    required email,
    required password,
    required name,
    required phone,
  }) async {
    try {
      final body = RegisterBodyModel(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      final response = await api.register(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<OtpVerifyResModel> otpData({required email, required otp}) async {
    try {
      final body = OtpVerifyBodyModel(email: email, otp: otp);
      final response = await api.otp(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgetPasswordResModel> forgetPasswordData({required email}) async {
    try {
      final body = ForgetPasswordBodyModel(email: email);
      final response = await api.forgetPassword(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgetPasswordOtpResModel> forgetPasswordOtpData({
    required email,
    required otp,
  }) async {
    try {
      final body = ForgetPasswordOtpBodyModel(email: email, otp: otp);
      final response = await api.forgetPasswordOtp(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResetPasswordResModel> resetPasswordData({
    required newPassword,
    required confirmPassword,
  }) async {
    try {
      final body = ResetPasswordBodyModel(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      final response = await api.resetPassword(body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<AddNetworkSearchResModel> addNetworkSearchData({
    required String search,
  }) async {
    try {
      final response = await api.getAddNetworkSearch(search);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<NetworkRequestResModel> getNetworkRequestData() async {
    try {
      final response = await api.getNetworkRequest();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
