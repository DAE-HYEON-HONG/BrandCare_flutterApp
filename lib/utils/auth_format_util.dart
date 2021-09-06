class AuthFormatUtil {
  static String secureEmail(String email){
    List<String> emailSplit = email.split("@");
    String secureId = emailSplit[0].replaceRange(2, emailSplit[0].length, "*");
    return secureId+"@"+emailSplit[1];
  }
}