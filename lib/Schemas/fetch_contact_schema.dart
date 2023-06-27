class FetchContactSchema {
  static String fetchContactJson = """
query Contacts {
  contacts {
    address
    createdAt
    email
    id
    name
    phone
    updatedAt
  }
}
  """;
}
