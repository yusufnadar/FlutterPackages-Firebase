enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
  invalidCredential,
  abortedByUser,
  accountAlreadyExist,
  credentialAlreadyInUse,
  passwordNotEnough,
  invalidPhoneNumber,
  invalidVerificationCode
}

class AuthExceptionHandler {
  static dynamic handleException(e) {
    AuthResultStatus status;
    switch (e.code) {
      case 'invalid-email':
        status = AuthResultStatus.invalidEmail;
        break;
      case 'invalid-phone-number':
        status = AuthResultStatus.invalidPhoneNumber;
        break;
      case 'invalid-verification-code':
        status = AuthResultStatus.invalidVerificationCode;
        break;
      case 'weak-password':
        status = AuthResultStatus.passwordNotEnough;
        break;
      case 'ınvalıd-emaıl':
        status = AuthResultStatus.invalidEmail;
        break;
      case 'wrong-password':
        status = AuthResultStatus.wrongPassword;
        break;
      case 'user-not-found':
        status = AuthResultStatus.userNotFound;
        break;
      case 'user-disabled':
        status = AuthResultStatus.userDisabled;
        break;
      case 'user-dısabled':
        status = AuthResultStatus.userDisabled;
        break;
      case 'too-many-requests':
        status = AuthResultStatus.tooManyRequests;
        break;
      case 'operation-not-allowed':
        status = AuthResultStatus.operationNotAllowed;
        break;
      case 'email-already-in-use':
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case 'emaıl-already-ın-use':
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case 'invalid-credential':
        status = AuthResultStatus.invalidCredential;
        break;
      case 'ınvalıd-credentıal':
        status = AuthResultStatus.invalidCredential;
        break;
      case 'ERROR_INVALID_CREDENTIAL':
        status = AuthResultStatus.invalidCredential;
        break;
      case 'aborted-by-user':
        status = AuthResultStatus.abortedByUser;
        break;
      case 'credential-already-in-use':
        status = AuthResultStatus.credentialAlreadyInUse;
        break;
      case 'credentıal-already-ın-use':
        status = AuthResultStatus.credentialAlreadyInUse;
        break;
      case 'account-exists-with-different-credential':
        status = AuthResultStatus.accountAlreadyExist;
        break;
      case 'account-exısts-wıth-dıfferent-credentıal':
        status = AuthResultStatus.accountAlreadyExist;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static String generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = 'E-posta adresiniz geçersiz.';
        break;
      case AuthResultStatus.passwordNotEnough:
        errorMessage = 'Parolanız 6 karakterden uzun olmalıdır';
        break;
      case AuthResultStatus.invalidVerificationCode:
        errorMessage = 'Girdiğiniz kod yanlıştır';
        break;
      case AuthResultStatus.invalidPhoneNumber:
        errorMessage = 'Telefon numaranız geçersiz';
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = 'E-posta adresi veya şifre yanlış.';
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = 'Bu e-postaya ait bir kullanıcı bulunamadı.';
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = 'Kullanıcı hesabı aktif değil.';
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage =
            'Çok fazla istek gönderildi. Lütfen daha sonra tekrar deneyin.';
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = 'E-posta adresiyle girişe izin verilmiyor.';
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            'Bu E-posta adresiyle daha önce hesap oluşturulmuş. Lütfen başka bir e-posta adresi kullanın.';
        break;
      case AuthResultStatus.accountAlreadyExist:
        errorMessage =
            'Kullandığınız e-posta adresiyle başka bir hesap mevcut. Lütfen diğer yöntemlerle giriş yapın.';
        break;
      case AuthResultStatus.credentialAlreadyInUse:
        errorMessage =
            'Bu giriş kimliği başka bir hesapla ilişkilendirilmiş. Lütfen başka bir hesapla giriş yapmayı deneyin';
        break;
      case AuthResultStatus.invalidCredential:
        errorMessage =
            'Bu giriş yönteminde bir sorun var. Lütfen farklı bir giriş yöntemi seçiniz.';
        break;
      case AuthResultStatus.abortedByUser:
        errorMessage = 'Giriş kullanıcı tarafından iptal edildi.';
        break;
      default:
        errorMessage = 'Tanımsız bir hata oluştu.';
    }

    return errorMessage;
  }
}
