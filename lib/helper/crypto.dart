import 'dart:convert';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

class RSACrypto {
  late RSAPublicKey publicKey;
  late int keyLength;
  late PKCS1Encoding cipher;

  RSACrypto(String publicKey) {
    this.publicKey = CryptoUtils.rsaPublicKeyFromPem(publicKey);
    keyLength = publicKey.length;
    cipher = PKCS1Encoding(RSAEngine());
    cipher.init(true, PublicKeyParameter<RSAPublicKey>(this.publicKey));
  }

  String encrypt(String plaintext) {
    Uint8List output =
        cipher.process(Uint8List.fromList(utf8.encode(plaintext)));

    String base64encoded = base64Encode(output);
    return base64encoded;
  }
}

List<int> bytesToKey(List<int> data, List<int> salt) {
  data += salt;
  List<int> key = md5.convert(data).bytes;
  List<int> finalKey = key;
  while (finalKey.length < 48) {
    key = md5.convert(key + data).bytes;
    finalKey += key;
  }
  return finalKey;
}

class AESCrypto {
  final int blockSize = 16;

  String encrypt(String plaintext, String passphrase) {
    List<int> passphraseUTF8 = utf8.encode(passphrase);
    List<int> salt = utf8.encode(StringUtils.generateRandomString(8));
    List<int> keyIv = bytesToKey(passphraseUTF8, salt);

    Key key = Key(Uint8List.fromList(keyIv.getRange(0, 32).toList()));
    IV iv = IV(Uint8List.fromList(keyIv.getRange(32, keyIv.length).toList()));

    Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    Uint8List encrypted = encrypter.encrypt(plaintext, iv: iv).bytes;
    return base64Encode(utf8.encode("Salted__") + salt + encrypted);
  }

  String decrypt(String encrypted, String passphrase) {
    Uint8List utf8Encoded = base64Decode(encrypted);
    List<int> passphraseUTF8 = utf8.encode(passphrase);
    List<int> salt = utf8Encoded.getRange(8, 16).toList();
    List<int> keyIv = bytesToKey(passphraseUTF8, salt);
    Key key = Key(Uint8List.fromList(keyIv.getRange(0, 32).toList()));
    IV iv = IV(Uint8List.fromList(keyIv.getRange(32, keyIv.length).toList()));

    Encrypter encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    Encrypted encrypt = Encrypted(Uint8List.fromList(
        utf8Encoded.getRange(16, utf8Encoded.length).toList()));
    String decrypted = encrypter.decrypt(encrypt, iv: iv);

    return decrypted;
  }
}
