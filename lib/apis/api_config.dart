class ApiConfig {
  static String newServerBaseURL =
      "https://api.softsmartinc.com/Services/Tanach/";

  static String? token;

  static String getFinalNewBaseUrl(currentApi) {
    return ApiConfig.newServerBaseURL + currentApi;
  }

  static var httpAuthorizationHeader = {
    "Access-Control-Allow-Origin": "*",
    "Authorization": "Bearer 14FE34B2-9547-43F5-A57C-F0DC7DE81AA9",
    // "Accept": "application/json",
    "Content-type": "application/json"
  };
  static var httpPostHeaderForEncode = {
    "Access-Control-Allow-Origin": "*",
    // "authToken": token,
    "Accept": "application/json",
    "Content-type": "application/x-www-form-urlencoded"
  };
  static String BookmarksList = 'Bookmarks/List';
  static String ChaptersUpdateTime = 'Chapters/UpdateTime';
  static String ChaptersCompleted = "Chapters/Completed";
  static String ParashaThisWeek = "Parasha/ThisWeek/1";
  static String DashboardCurrentBookStats = "Dashboard/CurrentBookStats";
  static String DashboardPartialStats = "Dashboard/PartialStats";
  static String DashboardTorah = "Dashboard/Torah";
  static String DashboardDailyChart = "Dashboard/DailyChart";
  static String DashboardTanachAchievements = "DashboardTanachAchievements";
  static String DashboardTanachUpdateDate = "DashboardUpdateDate";
  static String DashboardBookStats = "Dashboard/BookStats";
  static String DashboardAll = "Dashboard/All";
  static String LibraryBooksListTorah = "Books/ListTorah";
  static String LibraryBooksListProphets = "Books/ListProphets";
  static String LibraryBooksListWritings = "Books/ListWritings";
  static String LibraryBooksListHaftorah = "Books/ListTorah";
  static String LibraryParashaListHaftorah = "Parasha/ListHaftorah";
  static String LibraryParashaList = "Parasha/List";
  static String ParashaListVerses = "Parasha/ListVerses";
  static String BookmarksAdd = "Bookmarks/Add";
  static String ChaptersListVerses = "Chapters/ListVerses";
  static String ChaptersList = "Chapters/List";
  static String ChaptersListMore = "Chapters/ListMore";
  static String MemberSaveSettings = "MemberSaveSettings";
  static String SettingsBooksListExceptTorah = "Books/ListExceptTorah";
  static String SettingsMemberGet = "Member/Get";
  static String SettingsMemberSaveSettings = "Member/SaveSettings";
  static String MEMBERS_SocialAuthenticate = "MEMBERS_SocialAuthenticate";
  static String MemberListCalendar = "Member/ListCalendar";
}
