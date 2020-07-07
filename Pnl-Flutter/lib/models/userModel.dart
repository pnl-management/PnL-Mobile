class User{
  String token;
  String userName;
  String fullName;
  String role;
  String storeId;
  String storeName;
  String brandId;
  String brandName;
  bool brandStatus;

  User({
    this.token, this.userName,this.fullName,this.role,this.storeId,this.storeName,this.brandId,this.brandName,this.brandStatus
  } );
  User.fromJSON(Map<String, dynamic> json)
    : token = json['token'],
      userName = json['userName'],
      fullName = json['fullName'],
      role = json['role'],
      storeId = json['storeId'],
      storeName = json['storeName'],
      brandId = json['brandId'],
      brandName = json['brandName'],
      brandStatus = json['brandStatus']
      ;
  Map<String, dynamic> toJson() =>{
    'token' : token,
    'userName' : userName,
    'fullName': fullName,
    'role' :role,
    'storeId' : storeId,
    'storeName' : storeName,
    'brandId' : brandId,
    'brandName' : brandName,
    'brandStatus' : brandStatus
  };
}