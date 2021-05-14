import 'package:client/Services/auth_service.dart';
import 'package:client/Views/home_view.dart';
import 'package:flutter/material.dart';
import 'components/authentication_components.dart';


class SignInView extends StatefulWidget {
   @override
  _SignInViewState createState() => _SignInViewState();

}

class _SignInViewState extends State<SignInView>{
    
    String _phone, _password;
    TextEditingController  _phoneController, _passwordController = TextEditingController();  
  @override
  Widget build(BuildContext context) {
    
    //Signin Method + chuyen qua trang homeview sau khi signin
     _submit() {
       setState(() {
          AuthService.signInService(_phone, _password);
       });
       Navigator.push(context, 
            MaterialPageRoute(builder: (context){
              return HomeView();
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
          authenticationComponents(context), //images top1, top2, bottom1, bottom2
          signinComponents(context), //image topleft
          //Nut chuyen trang dang nhap
          Positioned(
              top: 147,
              right: 330,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => null,
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 15),
                ),
              )),
          //Nut chuyen trang dang ky
          Positioned(
              top: 195,
              right: 326,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
                //Xu ly chuyen trang dang ky
                onPressed: () {},
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 15),
                ),
              )),
          //Form Login
          Positioned(
            top: 215,
            right: 50,
            child:
                Image.asset("assets/images/FormLogin.png", width: size.width),
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
                    fontSize: 26, color: Colors.white,
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
              child: TextField(
                controller: _phoneController,
                autofocus: false,
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
            top: 385,
            right: 145,
            child: Container(
              height: 50,
              width: 240,
              decoration: BoxDecoration(
                color: Colors.grey[100].withOpacity(0.4),
                borderRadius: BorderRadius.circular(90),
              ),
              child: TextField(
                controller: _passwordController,
                autofocus: false,
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
                    gradient: LinearGradient(
                        colors: [Colors.yellow, Colors.orange[600]]),
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
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
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
                  child: Image.asset('assets/images/G.png', color: Colors.redAccent.shade700,),
                
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
    )
      );
  }

}
