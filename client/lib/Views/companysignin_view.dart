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
  TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Signup Method + chuyen qua trang signupview sau khi signup company
   _signin() async{
       //check validate
      _formKey.currentState.validate();
        await CompanyAuth.signinCompService(_name).then((res) async{
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
                MaterialPageRoute(builder: (context) => SignUpView()),
                (route) => false);
        }
         else{
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
                      authenticationComponents(context), //components
                      //Form
                      Positioned(
                        top: size.height * 0.36,
                        right: size.width * 0.13,
                        child: Image.asset("assets/images/Company.png",
                            width: size.width),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        right: size.width * 0.87,
                        child: IconButton(
                          icon: Icon(Icons.keyboard_backspace_outlined),
                          iconSize: 33,
                          color: Colors.blue[300],
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      //Text title
                      Positioned(
                          top: size.height * 0.4,
                          right: size.width * 0.34,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'ENTER YOUR COMPANY',
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      //User_name Field
                      Positioned(
                        top: size.height * 0.45,
                        right: size.width * 0.34,
                        child: Container(
                          height: 50,
                          width: 240,
                          decoration: BoxDecoration(
                            color: Colors.grey[100].withOpacity(0.4),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: TextFormField(
                            controller: _nameController,
                            autofocus: false,
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
                      //Signin Company Button
                      Positioned(
                          top: size.height * 0.44,
                          right: size.width * 0.17  ,
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
