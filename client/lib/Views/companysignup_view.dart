import 'package:client/Services/companyauth_service.dart';
import 'package:client/Views/companysignin_view.dart';
import 'package:client/Views/components/auth_components.dart';
import 'package:client/Views/signin_view.dart';
import 'package:flutter/material.dart';


class CompanySignupView extends StatefulWidget {
  @override
  _CompanySignupViewState createState() => _CompanySignupViewState();
}

class _CompanySignupViewState extends State<CompanySignupView> {
  String _name = '', _email = '', _phone = '', _web = '';
  TextEditingController _nameController,
      _webController,
      _emailController,
      _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Signup Method + chuyen qua trang signupview sau khi signup company
   _signup(){
      //check validate
      if (_formKey.currentState.validate()) {
        CompanyAuth.signupCompService(_name, _email, _phone, _web)
            .then((value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Signup Company Successfully!'),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.fixed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))
              ),
            )));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CompanySigninView();
        }));
        _formKey.currentState.save();
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Signup Company Failed!'),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.fixed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))
              ),
            ));
      }
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
                              'Your Company Name',
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
                      //Web Field
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
                            controller: _webController,
                            autofocus: true,
                            decoration: InputDecoration(
                                hintText: 'Website*',
                                hintStyle:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                errorStyle: TextStyle(height: 0),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 15),
                                prefixIcon: Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 20),
                                  child: Image.asset(
                                    'assets/images/Vector.png',
                                    color: Colors.blueAccent.shade100,
                                  ),
                                )),
                            onChanged: (value) => _web = value, //luu value thay doi tren website TextFormField
                            validator: (value) {
                              if (value.isEmpty) {
                                return "    Please enter your company website";
                              }/* else if (value.isNotEmpty) {
                                bool webValid = RegExp(
                                        r'^[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]'*)
                                    .hasMatch(value);
                                return webValid
                                    ? null
                                    : "     Website is invalid!";
                              }*/
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
                            onPressed: _signup,
                          )),
                    ],
                  ),
                ))));
  }
}
