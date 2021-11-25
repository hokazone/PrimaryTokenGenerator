import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

String getIssueAt() {
  int time = (new DateTime.now().millisecondsSinceEpoch / 1000).floor() * 60;
  return base64.encode(utf8.encode('iat: ${time}\n')) + '.';
}

String encryptoIatWithSecretKey(List<int> key, iat) {
  var hash = new Hmac(sha1, key);
  var digest = hash.convert(iat);
  String hash_b64 = base64.encode(digest.bytes);
  return hash_b64;
}

void main() {
  print('Enter AuthKey: ');
  String authKey = stdin.readLineSync();
  var mid = authKey.substring(0, 33);
  var key = authKey.substring(34);

  var iat = getIssueAt();
  
  var key_decoded = base64.decode(key);

  var digest = encryptoIatWithSecretKey(key_decoded, utf8.encode(iat));

  String text = '\n\n[!SUCCESS] ${mid}:${iat}.${digest}\n\n';

  print('*'*text.length + text + '*'*text.length);

}
