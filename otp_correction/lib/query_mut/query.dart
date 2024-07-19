String getNum="""
query MyQuery(\$phone_num:String) {
  user_table(where: {phone_num: {_eq:\$phone_num}}) {
    username
    password
    mail_id
    phone_num
    id
  }
}
""";

String getTable = """
query MyQuery {
  user_table {
    username
    dept
    phone_num
    mail_id
    id
  }
}
""";

String getID="""
query MyQuery (\$id: uuid){
  user_table(where: {id: {_eq: \$id}}) {
    id
    mail_id
    password
    phone_num
    username
  }
}
""";

String login="""
query MyQuery(\$phone_num: String) {
  user_table(where: {phone_num: {_eq: \$phone_num}}) {
    id
    mail_id
    password
    phone_num
    username
  }
}
""";


String getAddress="""
query MyQuery(\$user_id: uuid) {
  user_address(where: {user_id: {_eq: \$user_id}}) {
    address
    address_type
    name
    id
  }
}
""";