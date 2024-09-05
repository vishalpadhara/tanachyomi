class Config{

  String baseurl = "https://api.softsmartinc.com/Services/Tanach/";
  // String baseurl = "https://api.softsmartinc.com/Services/LetsConnect/";

  String baseurlfortext = "https://www.sefaria.org/api/texts/";

  String secondarybaseurl = "https://api.softsmartinc.com/Services/Tanach/";

  String baseurlforGetAudio = "https://letsconnect.blob.core.windows.net/members/";

  String getimagebaseurl = "https://tanachyomi.blob.core.windows.net/members/";

  static var httppostheader = {
    "Access-Control-Allow-Origin": "*",
    "Authorization": "Bearer 14FE34B2-9547-43F5-A57C-F0DC7DE81AA9",
    // "Accept": "application/json",
    "Content-type": "application/json"
  };

  static var httppostheaderforupload = {
    "Access-Control-Allow-Origin": "*",
    "Authorization": "Bearer 14FE34B2-9547-43F5-A57C-F0DC7DE81AA9",
    // "Accept": "application/json",
    'Content-Type': 'multipart/form-data',
  };

  static var httpgetheader = {
    "Access-Control-Allow-Origin": "*",
    "Authorization": "Bearer 14FE34B2-9547-43F5-A57C-F0DC7DE81AA9",
    // "Accept": "application/json",
    "Content-type": "application/json"
  };

}