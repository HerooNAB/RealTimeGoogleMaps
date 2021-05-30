import 'package:client/Services/companyauth_service.dart';
import 'package:client/Views/components/auth_components.dart';
import 'package:client/Views/signup_view.dart';
import 'package:flutter/material.dart';


class CompanySigninView extends StatefulWidget {
  @override
  _CompanySigninViewState createState() => _CompanySigninViewState();
}

class _CompanySigninViewState extends State<CompanySigninView> {
  String _name = '';
  TextEditingController _nameController
       = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Signup Method + chuyen qua trang signupview sau khi signup company
   _signin(){
       //check validate
      if (_formKey.currentState.validate()) {
        CompanyAuth.signinCompService(_name)
            .then((value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Signin Company Successfully!'),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.fixed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0))
              ),
            )));
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SignUpView();
        }));
        _formKey.currentState.save();
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Signin Company Failed!'),
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
                      //Form 
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
                              'Enter your company name',
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
                                hintText: 'Company name',
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
                                return "Company name can't be blank!";
                              } else if (value.isNotEmpty) {
                                bool nameValid = RegExp(
                                        r'^(?=[a-zA-Z0-9._ ]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$')
                                    .hasMatch(value);
                                return nameValid
                                    ? null
                                    : "Company name is invalid!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      //Signin Button
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
                            //Xu ly ham signin
                            onPressed: _signin,
                          )),
                    ],
                  ),
                ))));
  }
}
