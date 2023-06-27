class CreateContactSchema {
  static String createContactJson = """
  mutation Contact(\$contactInput: ContactInput!) {
  contact(contactInput: \$contactInput) {
    contact {
      address
      createdAt
      email
      id
      name
      phone
      updatedAt
    }
    errors {
      fullMessage
      message
      property
    }
    status
  }
}
  """;
}
