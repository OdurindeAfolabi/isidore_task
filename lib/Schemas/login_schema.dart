class LoginSchema {
  static String loginJson = """
  
mutation Login(\$email: String!, \$password: String!) {
  login(email: \$email, password: \$password) {
    credentials {
      token
    }
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
