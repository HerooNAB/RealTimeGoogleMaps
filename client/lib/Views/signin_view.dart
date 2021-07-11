import 'package:client/Services/authentication_service.dart';
import 'package:client/Views/companysignin_view.dart';
import 'package:client/Views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'components/auth_components.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _visibilityText = true;
  Response res;
  String _phone = '', _password = '';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Signin Method + chuyen qua trang homeview sau khi signin
    _submit() async {
      //check validate
      _formKey.currentState.validate();
      _formKey.currentState.save();
      //check response signin
      await AuthService.signInService(_phone, _password).then((res) async {
        if (res == '200') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Signin Successfully!'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
          ));

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Your phone number or password is wrong!'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0))),
          ));
        }
      });
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  height: size.height,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      authenticationComponents(
                          context), //images top1, top2, bottom1, bottom2
                      signinComponents(context), //image topleft
                      //Nut chuyen trang dang nhap
                      Positioned(
                          top: 90,
                          right: 330,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () => null,
                            child: Text(
                              'Sign In',
                              style: TextStyle(fontSize: 15),
                            ),
                          )),
                      //Nut chuyen trang dang ky
                      Positioned(
                          top: 136,
                          right: 326,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                            ),
                            //Xu ly chuyen trang dang ky
                            onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CompanySigninView();
                            })),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 15),
                            ),
                          )),
                      //Form Login
                      Positioned(
                        top: 215,
                        right: 50,
                        child: Image.asset("assets/images/FormLogin.png",
                            width: size.width),
                      ),
                      //Text title
                      Positioned(
                          top: 265,
                          right: 162,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Sign In To Account',
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      //Phonenumber field
                      Positioned(
                          top: 320,
                          right: 145,
                          child: Container(
                            height: 50,
                            width: 240,
                            decoration: BoxDecoration(
                              color: Colors.grey[100].withOpacity(0.4),
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: Container(
                              child: TextFormField(
                                controller: _phoneController,
                                autofocus: false,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    hintText: 'Phone number',
                                    hintStyle: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                    contentPadding: EdgeInsets.only(top: 15),
                                    errorStyle: TextStyle(height: 0),
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Container(
                                        child: Image.asset(
                                          'assets/images/phone.png',
                                          color: Colors.blueAccent.shade200,
                                        ),
                                      ),
                                    )),
                                onChanged: (value) => _phone =
                                    value, //luu value thay doi tren phone textfield
                                //Check validate with blank and phone number format
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "      Phone number can't be blank!";
                                  } else if (value.isNotEmpty) {
                                    bool phoneValid =
                                        RegExp(r'^(?:[+0]9)?[0-9]{10}$')
                                            .hasMatch(value);
                                    return phoneValid
                                        ? null
                                        : "      Phone number is invalid!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          )),
                      //Password Field
                      Positioned(
                        top: 385,
                        right: 145,
                        child: Container(
                          height: 50,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey[100].withOpacity(0.4),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            autofocus: false,
                            obscureText: _visibilityText,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                errorStyle: TextStyle(height: 0),
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                contentPadding: EdgeInsets.only(top: 15),
                                border: InputBorder.none,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: IconButton(
                                    icon: _visibilityText
                                        ? Icon(Icons.visibility_off_outlined)
                                        : Icon(Icons.visibility_outlined),
                                    onPressed: () {
                                      setState(() {
                                        _visibilityText = !_visibilityText;
                                      });
                                    },
                                  ),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 12),
                                  child: Image.asset(
                                    'assets/images/Vector.png',
                                    color: Colors.blueAccent.shade100,
                                  ),
                                )),
                            onChanged: (value) => _password =
                                value, //luu value thay doi tren password textfield
                            //Check validate with blank and password format
                            validator: (value) {
                              if (value.isEmpty) {
                                return "      Password can't be blank!";
                              } else if (value.isNotEmpty) {
                                bool phoneValid = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value);
                                return phoneValid
                                    ? null
                                    : "      Password is invalid!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                      //Login Button
                      Positioned(
                          top: 350,
                          right: 65,
                          child: FloatingActionButton(
                            backgroundColor: Colors.yellow[400],
                            child: Container(
                              height: 54,
                              width: 54,
                              child: Image.asset('assets/images/Group.png'),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  Colors.yellow,
                                  Colors.orange[600]
                                ]),
                              ),
                            ),
                            onPressed: _submit,
                          )),

                      //Forgot Password Button
                      Positioned(
                          top: 435,
                          right: 140,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(fontSize: 15),
                            ),
                          )),

                      //Social Media Buttons
                      Positioned(
                          top: 550,
                          right: 200,
                          child: FloatingActionButton(
                            backgroundColor: Colors.blue[900],
                            child: Container(
                              height: 35,
                              width: 35,
                              child: Image.asset('assets/images/fb.png'),
                            ),
                            onPressed: () => {},
                          )),
                      Positioned(
                          top: 550,
                          right: 119,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            child: Container(
                              height: 35,
                              width: 35,
                              child: Image.asset(
                                'assets/images/G.png',
                                color: Colors.redAccent.shade700,
                              ),
                            ),
                            onPressed: () => {},
                          )),
                      Positioned(
                          top: 550,
                          right: 38,
                          child: FloatingActionButton(
                            backgroundColor: Colors.blue[400],
                            child: Container(
                              height: 35,
                              width: 35,
                              child: Image.asset('assets/images/twitter.png'),
                            ),
                            onPressed: () => {},
                          )),
                    ],
                  ),
                ))));
  }
}
