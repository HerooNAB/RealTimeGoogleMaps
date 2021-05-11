import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/images/top1.png", width: size.width),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/images/top2.png", width: size.width),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bottom1.png", width: size.width),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("assets/images/bottom2.png", width: size.width),
          ),
          Positioned(
            top: 90,
            right: 160,
            child: Image.asset("assets/images/topleft.png", width: size.width),
          ),
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
                    fontSize: 26, color: Colors.white,
                  ),
                ),
              )),
            //Username Field
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
                autofocus: false,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Image.asset(
                        'assets/images/UserAvatar.png',
                        color: Colors.blueAccent.shade100,
                      ),
                    )),
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
                autofocus: false,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10),
                      child: Image.asset(
                        'assets/images/Email.png',
                        color: Colors.blueAccent.shade100,
                      ),
                    )),
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
                autofocus: false,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsetsDirectional.only(start: 15),
                      child: Image.asset(
                        'assets/images/Vector.png',
                        color: Colors.blueAccent.shade100,
                      ),
                    )),
              ),
            ),
          ),
          //Login Button
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

                //Xu ly ham login
                onPressed: () => {},
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
                  child: Image.asset('assets/images/G.png', color: Colors.redAccent.shade700,),
                
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
