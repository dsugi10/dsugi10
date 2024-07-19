String insertUser="""
mutation MyMutation(\$username: String, \$mail_id: String, \$password: String, \$phone_num:String) {
  insert_user_table(objects: {username: \$username, mail_id: \$mail_id, password: \$password,phone_num:\$phone_num}) {
    affected_rows
    returning {
      username
      mail_id
      password
      phone_num
      id
    }
  }
}
""";

String editUser="""
mutation MyMutation(\$id: uuid, \$mail_id: String, \$password: String,\$phone_num:String, \$username: String) {
  update_user_table(where: {id: {_eq: \$id}}, _set: {mail_id: \$mail_id, password: \$password,phone_num:\$phone_num, username: \$username}) {
    returning {
      id
      mail_id
      password
      phone_num
      username
    }
  }
}

""";

String insertAddress="""
mutation MyMutation(\$address: String,\$address_type: String, \$name: String, \$user_id:uuid ) {
  insert_user_address(objects: {address:\$address , address_type: \$address_type, name: \$name, user_id: \$user_id}) {
    affected_rows
    returning{
      address
      address_type
      name
      user_id
    }
  }
}

""";

