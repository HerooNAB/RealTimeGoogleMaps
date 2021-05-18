import 'package:client/Services/auth_service.dart';
import 'package:client/Views/signin_view.dart';
import 'package:flutter/material.dart';
import 'components/authentication_components.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _name = '', _email = '', _phone = '', _password = '';
  String _role = "client";
  bool _visibilityText = true;
  TextEditingController _nameController,
      _passwordController,
      _emailController,
      _phoneController = TextEditingController();
  bool _signUpSuccess = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Signup Method + chuyen qua trang signinview sau khi signup
    _submit() {
      //check validate
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      setState(() {
        if(_signUpSuccess){
        AuthService.signupService(_name, _email, _phone, _password, _role);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SignInView();
      }));
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup Successfully')));
      }
      else{
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup Failed')));
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
                      authenticationComponents(context), //components
                      signupComponents(context),
                      //Nut chuyen trang dang nhap
                      Positioned(
                          top: 90,
                          right: 330,
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                            ),
                            //Xu ly ham chuyen trang dang nhap
                            onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignInView();
                            })),
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
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () => null,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 15),
                            ),
                          )),
                      //Form Signup
                      Positioned(
                        top: 155,
                        right: 50,
                        child: Image.asset("assets/images/FormSignup.png",
                            width: size.width),
                      ),
                      //Text title
                      Positioned(
                          top: 205,
                          right: 155,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Create Your Account',
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      //User_name Field
                      Positioned(
                        top: 255,
                        right: 150,
                        child: Container(
                          height: 50,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey[100].withOpacity(0.4),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: TextFormField(
                            controller: _nameController,
                            autofocus: true,
                            decoration: InputDecoration(
                                hintText: 'Username*',
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                errorStyle: TextStyle(height: 0),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(14),
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 10),
                                  child: Image.asset(
                                    'assets/images/UserAvatar.png',
                                    color: Colors.blueAccent.shade100,
                                  ),
                                )),
                            onChanged: (value) => _name =
                                value, //luu value thay doi tren name TextFormField
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Username can't be blank!";
                              } else if (value.isNotEmpty) {
                                bool nameValid = RegExp(
                                        r'^(?=[a-zA-Z0-9._ ]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$')
                                    .hasMatch(value);
                                return nameValid
                                    ? null
                                    : "Username is invalid!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      //Email Field
                      Positioned(
                        top: 320,
                        right: 150,
                        child: Container(
                          height: 50,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey[100].withOpacity(0.4),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            autofocus: true,
                            decoration: InputDecoration(
                                hintText: 'Email*',
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                errorStyle: TextStyle(height: 0),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 10),
                                  child: Image.asset(
                                    'assets/images/Email.png',
                                    color: Colors.blueAccent.shade100,
                                  ),
                                )),
                            onChanged: (value) => _email =
                                value, //luu value thay doi tren email TextFormField
                            //Check validate with blank and email format
                            validator: (value) {
                              if (value.isEmpty) {
                                return "     Email can't be blank!";
                              } else if (value.isNotEmpty) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value);
                                return emailValid
                                    ? null
                                    : "     Email is invalid!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      //Phonenumber field
                      Positioned(
                        top: 385,
                        right: 150,
                        child: Container(
                          height: 50,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey[100].withOpacity(0.4),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneController,
                            autofocus: false,
                            textAlign: TextAlign.start,
                            inputFormatters: [],
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Phone number*',
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                border: InputBorder.none,
                                errorStyle: TextStyle(height: 0),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 15, 0, 0),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 21),
                                  child: Image.asset(
                                    'assets/images/phone.png',
                                    color: Colors.blueAccent.shade200,
                                  ),
                                )),
                            onChanged: (value) => _phone =
                                value, //luu value thay doi tren phone TextFormField
                            //Check validate with blank and phone number format
                            validator: (value) {
                              if (value.isEmpty) {
                                return "  Phone number can't be blank!";
                              } else if (value.isNotEmpty) {
                                bool phoneValid = RegExp(
                                        r'^(?:[+0]9)?[0-9]{10}$')
                                    .hasMatch(value);
                                return phoneValid
                                    ? null
                                    : "  Phone number is invalid!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      //Password Field
                      Positioned(
                        top: 450,
                        right: 150,
                        child: Container(
                          height: 50,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey[100].withOpacity(0.4),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            autofocus: true,
                            obscureText: _visibilityText,
                            decoration: InputDecoration(
                                hintText: 'Password*',
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                errorStyle: TextStyle(height: 0),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 15),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: IconButton(
                                    icon: Icon(Icons.visibility_off_outlined),
                                    onPressed: () {
                                      setState(() {
                                        _visibilityText = !_visibilityText;
                                      });
                                    },
                                  ),
                                ),
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 20),
                                  child: Image.asset(
                                    'assets/images/Vector.png',
                                    color: Colors.blueAccent.shade100,
                                  ),
                                )),
                            onChanged: (value) => _password =
                                value, //luu value thay doi tren password TextFormField
                            validator: (value) {
                              if (value.isEmpty) {
                                return "     Password can't be blank!";
                              } else if (value.isNotEmpty) {
                                bool passValid = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value);
                                return passValid
                                    ? null
                                    : "     Password is invalid!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      //Signup Button
                      Positioned(
                          top: 330,
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
                            //Xu ly ham signup
                            onPressed: _submit,
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
                            //Code
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
                            //Code
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
                            //Code
                            onPressed: () => {},
                          )),
                    ],
                  ),
                ))));
  }
}
