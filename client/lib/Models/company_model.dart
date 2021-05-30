

class Company{
  String name;
  String phone;
  String email;
  String web;

  Company({this.name, this.phone, this.email, this.web});

  Company.fromJson(Map<String, dynamic> json){
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    web = json['web'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['web'] = this.web;
  }
}



