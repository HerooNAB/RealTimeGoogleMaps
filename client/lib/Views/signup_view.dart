import 'package:client/Services/auth_service.dart';
import 'package:client/Views/signin_view.dart';
import 'package:flutter/material.dart';
import 'components/authentication_components.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>{
  String _name, _email, _phone, _password;
  TextEditingController _nameController,  _passwordController,_emailController,_phoneController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
   
   //Signup Method + chuyen qua trang signinview sau khi signup
     _submit() {
       setState(() {
          AuthService.signupService(_name, _email, _phone, _password);
       });
       Navigator.push(context, 
            MaterialPageRoute(builder: (context){
              return SignInView();
            }));
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
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
                onPressed: () {},
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
                      MaterialStateProperty.all<Color>(Colors.white),
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
            child:
                Image.asset("assets/images/FormSignup.png", width: size.width),
          ),
          //Text title
          Positioned(
              top: 215,
              right: 150,
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
              child: TextField(
                controller: _nameController,
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Image.asset(
                        'assets/images/UserAvatar.png',
                        color: Colors.blueAccent.shade100,
                      ),
                    )),
                onChanged: (value) => _name = value, //luu value thay doi tren name textfield
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
              child: TextField(
                controller: _emailController,
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Image.asset(
                        'assets/images/Email.png',
                        color: Colors.blueAccent.shade100,
                      ),
                    )),
                onChanged: (value) => _email = value, //luu value thay doi tren email textfield
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
              child: TextField(
                controller: _phoneController,
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Image.asset(
                        'assets/images/Frame.png',
                        color: Colors.blueAccent.shade100,
                      ),
                    )),
                onChanged: (value) => _phone = value, //luu value thay doi tren phone textfield
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
              child: TextField(
                controller: _passwordController,
                autofocus: true,
                obscureText: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 15),
                      child: Image.asset(
                        'assets/images/Vector.png',
                        color: Colors.blueAccent.shade100,
                      ),
                    )),
                onChanged: (value) => _password = value, //luu value thay doi tren password textfield
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
                    gradient: LinearGradient(
                        colors: [Colors.yellow, Colors.orange[600]]),
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
    ));
  }

  
}
