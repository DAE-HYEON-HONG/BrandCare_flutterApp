class AuthFormatUtil {
  static String secureEmail(String email){
    List<String> emailSplit = email.split("@");
    String id = emailSplit[0];
    String secureId = id.replaceRange(2, emailSplit[0].length, "*"*emailSplit[0].length);
    return secureId+"@"+emailSplit[1];
  }
}