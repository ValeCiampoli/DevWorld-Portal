class FirestorePath {
  static String user(String uid) => 'users/$uid';
  static String users() => 'users';
  static String document(String pid) => 'documents/$pid';
  static String documents() => 'documents';
  static String appointment(String pid) => 'appointments/$pid';
  static String appointments() => 'appointments';
  static String memo(String pid) => 'memoes/$pid';
  static String memoes() => 'memoes';
  static String sections(String pid) => 'posts/$pid/sections';
  static String section(String pid, String sid) => 'posts/$pid/sections/$sid';
  static String notification(String nid) => 'notifications/$nid';
  static String notifications() => 'notifications';
  static String subscription(String sid) => 'subscriptions/$sid';
  static String subscriptions() => 'subscriptions';
}