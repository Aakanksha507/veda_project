
class User{
final String? id;
final String? username;
// final String? email;
final String? password;
final String? phoneNumber;
final String? cardNumber;
final String? bankName;
final String? bankBranch;
final String? transactionName;
final List<String>? category;
final List<String>? description;
final List<String>? amount;


User( {
  this.id,
  this.username,
  this.password,
  this.phoneNumber,
  // this.email,
  this.cardNumber,
  this.bankName, 
  this.bankBranch, 
  this.transactionName,
  this.category,
  this.description,
  this.amount,
});

factory User.fromJson(Map<String, dynamic> json){
  return User(
    id: json['id'],
    username: json['username'],
    password: json['password'],
    phoneNumber: json['phoneNumber'],
    cardNumber: json['cardNumber'],
    bankName: json['bankName'],
    bankBranch: json['bankBranch'],
    transactionName: json['transactionName'],
    category: (json['categoryName'] as List?)?.map((e) => e.toString()).toList() ?? [],
    description: (json['description'] as List?)?.map((e) => e.toString()).toList() ?? [],
    amount: (json['amount'] as List?)?.map((e) => e.toString()).toList() ?? [],
  );
}


Map<String, dynamic> toJson(){
  return{
    'id': id,
    'username': username,
    'password':password,
    'phoneNumber':phoneNumber,
    // 'email': email,
    'cardNumber':cardNumber,
    'bankName': bankName,
    'bankBranch':bankBranch,
    'transactionName': transactionName,
    'categoryName': category,
    'description': description,
    'amount': amount,

  };
}

}