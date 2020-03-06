String 
homeScreen='/HomeScreen',
imageSplash='/ImageSplashScreen',
authors='/Authors',
cari='/Cari',
listAuthor='/TampilAuthor'
;

String defaultUrl = 'http://api.sinta.ristekdikti.go.id/', authorUrl = 'author/detail/', journalUrl = 'journal/', affiliationUrl = 'affiliation/';

Map<String, dynamic> routerMap = {
  '_homescreen' : '/HomeScreen',
  '_splashscreen' : '/ImageSplashScreen',
  '_detail' : '',
  '_list' : '',
  '_cari' : '/Cari',
  '_authors' : '/Authors',
  '_listauthors' : '/TampilAuthor',
  '_detailauthors' : '',
  '_affiliation' : '',
  '_listaffiliation' : '',
  '_detailaffiliation' : '',
  '_journal' : '',
  '_listjournal' : '',
  '_detailjournal' : '',
};

Map<String, dynamic> endpointApiUrl = {
  'author_all' : defaultUrl + 'author/',
  'author_detail' : defaultUrl + authorUrl + 'overview/',
  'author_bimbingan' : defaultUrl + authorUrl + 'bimbingan/',
  'author_scopus' : defaultUrl + authorUrl + 'scopus/',
  'author_google' : defaultUrl + authorUrl + 'google/',
  'author_book' : defaultUrl + authorUrl + 'book/',
  'author_ipr' : defaultUrl + authorUrl + 'ipr/',
  'author_service' : defaultUrl + authorUrl + 'service/',
  'author_research' : defaultUrl + authorUrl + 'research/',
  'journal_all' : defaultUrl + journalUrl,
  'journal_detail' : defaultUrl + journalUrl + 'detail/',
  'affiliation_all' : defaultUrl + affiliationUrl,
  'affiliation_detail' : defaultUrl + affiliationUrl + 'detail/',
};