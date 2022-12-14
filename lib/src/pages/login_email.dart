import 'package:flutter/material.dart';
import 'package:proyectocorte3/src/models/User.dart';
import 'package:proyectocorte3/src/service/Service_User.dart';

class LoginEmail extends StatefulWidget {
  LoginEmail({Key? key}) : super(key: key);

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var height, width, size;
  TextEditingController _controller_email = new TextEditingController();
  TextEditingController _controller_password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: titulo(), backgroundColor: Colors.deepPurple),
      body: SingleChildScrollView(child: formulario()),
    );
  }

  Widget titulo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [const Text('Iniciar sesión'), logo()],
    );
  }

  Widget logo() {
    return Image.asset(
      'assets/B5.png',
      fit: BoxFit.contain,
      height: height / 15,
    );
  }

  Widget formulario() {
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.07,
          top: height * 0.04,
          right: width * 0.07,
          bottom: height * 0.01),
      child: form(),
    );
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          etiquetaTexto("Inicia esión con tu cuenta para continuar", 17.0,
              FontWeight.bold, Colors.black54, 1),
          SizedBox(
            height: height * 0.058,
          ),
          etiquetInput("Correo electrónico"),
          inputEmail('Email Adress', 2),
          SizedBox(
            height: height * 0.03,
          ),
          etiquetInput("Contraseña"),
          inputPassword('Password', 1),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            child: etiquetaTexto("¿Has olvidado tu contraseña?", 17.0,
                FontWeight.bold, Colors.red, 2),
            onTap: () => Navigator.pushNamed(context, "forgotPass"),
          ),
          SizedBox(height: height * 0.34),
          btnIngresar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              etiquetaTexto("¿Todavía no tienes una cuenta?", 15.0,
                  FontWeight.normal, Colors.black, 1),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'signup');
                  },
                  child: etiquetaTexto(
                      "Regístrate", 15.0, FontWeight.bold, Colors.red, 1)),
            ],
          )
        ],
      ),
    );
  }

  Widget etiquetaTexto(texto, fontSize, fontWeight, colors, posicion) {
    return Row(
      mainAxisAlignment:
          posicion == 1 ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(
          texto,
          style: TextStyle(
              fontWeight: fontWeight, fontSize: fontSize, color: colors),
        )
      ],
    );
  }

  Widget etiquetInput(texto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          texto,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        )
      ],
    );
  }

  Widget inputEmail(texto, bandera) {
    return TextFormField(
      controller: _controller_email,
      decoration: InputDecoration(
          hintText: texto,
          hintStyle: const TextStyle(color: Colors.black26),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: width * 0.015))),
    );
  }

  Widget inputPassword(texto, bandera) {
    return TextFormField(
      controller: _controller_password,
      decoration: InputDecoration(
          suffixIcon: const Icon(Icons.remove_red_eye),
          hintText: texto,
          hintStyle: const TextStyle(color: Colors.black26),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: width * 0.015))),
    );
  }

  Widget btnIngresar() {
    return ElevatedButton(
        onPressed: () async {
          final servico = Service_User();
          final response = await servico.login(
              email: _controller_email.text,
              password: _controller_password.text);
          if (response["code"] == true) {
            final user = response["basicUser"];
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Inicio sesion correctamente")));
            final usuario = User.instance;
            usuario.id = user["idUser"];
            usuario.email = user["email"];
            usuario.name = user["name"];
            usuario.idDevice = user["idDeviceToken"].toString();
            usuario.token = response["token"];
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(response["message"])));
          }
        },
        style: TextButton.styleFrom(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.32, vertical: 10),
          primary: Colors.white,
          backgroundColor: Colors.green,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        child: const Text(
          "Ingresar",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ));
  }
}
