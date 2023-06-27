class SignUpSchema {
  static String signUpJson = """
  
mutation Signup(\$userInput: UserRegisterInput!) {
  signup(userInput: \$userInput) {
    errors {
      fullMessage
      message
      property
    }
    status
    user {
      createdAt
      email
      id
      status
      tokens
      updatedAt
    }
  }
}
  """;
}
