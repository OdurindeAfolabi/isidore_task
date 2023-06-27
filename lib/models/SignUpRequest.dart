class SignUpRequest {
  SignUpRequest({
      this.userInput,});

  SignUpRequest.fromJson(dynamic json) {
    userInput = json['userInput'] != null ? UserInput.fromJson(json['userInput']) : null;
  }
  UserInput? userInput;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userInput != null) {
      map['userInput'] = userInput?.toJson();
    }
    return map;
  }
}

class UserInput {
  UserInput({
      this.email, 
      this.password, 
      this.passwordConfirmation,});

  UserInput.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['passwordConfirmation'];
  }
  String? email;
  String? password;
  String? passwordConfirmation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['passwordConfirmation'] = passwordConfirmation;
    return map;
  }

}