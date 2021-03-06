class User{
  String userId;
  String name;
  String phone;
  String email;
  String password;
  String avatar;
  String bio;
  String role;


  User({this.userId, this.name, this.phone, this.email, this.password, this.avatar, this.bio, this.role });

   User.fromJson(Map<String, dynamic> json){
    
    userId = json['_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    bio = json['bio'];    
    role = json['role'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['bio'] = this.bio;
    data['role'] = this.role;
    return data;
  }
}
