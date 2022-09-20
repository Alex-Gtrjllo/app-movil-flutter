// ignore_for_file: file_names

import 'package:dio/dio.dart';

class Service_User {
  Future login({email, password}) async {
    print("Servicio login");
    final response = await Dio()
        .post("http://desarrollovan-tis.dedyn.io:4010/api/User/LogIn", data: {
      "idChannel": 1,
      "email": email,
      "password": password,
      "idPlatform": 2,
      "idRole": 1,
      "idDevice": "1"
    });
    return response.data;
  }

  @override
  Future createUser({name, email, password}) async {
    final response = await Dio().post(
        "http://desarrollovan-tis.dedyn.io:4010/api/User/CreateUser/",
        data: {
          "idUser": 1,
          "email": email,
          "name": name,
          "phoneNumber": "9715421",
          "pass": password,
          "idRole": 1,
          "idPlatform": 2,
          "idChannel": 1,
          "guest": "string",
          "lasName": "string"
        });
    return response.data;
  }

  @override
  Future recoverPass({email}) async {
    print("Servicio recuperar contraseña");
    final response = await Dio().post(
        "http://desarrollovan-tis.dedyn.io:4010/api/User/RecoverPassword",
        data: {"idChannel": 1, "email": email});
    return response.data;
  }

  @override
  Future cambiarPass({idUser, newPassword, token}) async {
    print("Servicio Actualizar contraseña");
    final response = await Dio().post(
        "http://desarrollovan-tis.dedyn.io:4010/api/User/UpdatePassword",
        data: {"idUser": idUser, "newPassword": newPassword},
        options: Options(headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json"
        }));

    return response.data;
  }
}
