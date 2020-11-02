import 'package:flutter/foundation.dart';

class ConnectionRefused implements Exception {
  @override
  String toString() {
    return '101 :Connection refused';
  }
}

class DataInvalid implements Exception {
  @override
  String toString() {
    return '422 : The given data was invalid ';
  }
}

class DataMessing implements Exception {
  @override
  String toString() {
    return '500 : authentication data messing!';
  }
}

class RedirectionFound implements Exception {
  @override
  String toString() {
    return '301,302,303 : Redirection found';
  }
}

class Unauthorized implements Exception {
  @override
  String toString() {
    return '401 : Credenials rejected, check your Token';
  }
}

// class Unauthorized implements Exception {
//   @override
//   String toString() {
//     return '401: Unauthorized connexion, check your Token';
//   }
// }

class ResourceNotFound implements Exception {
  String message;
  ResourceNotFound(this.message);
  @override
  String toString() {
    return '404 : Resource $message not found';
  }
}

class NotInternetConnection implements Exception {
  @override
  String toString() {
    return 'No internet Connextion availabl!!!';
  }
}

class PropretyIsRequired implements Exception {
  String proprety;
  PropretyIsRequired(this.proprety);
  @override
  String toString() {
    return 'Proprety $proprety is required';
  }
}
