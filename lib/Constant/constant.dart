String 
homeScreen='/HomeScreen',
imageSplash='/ImageSplashScreen',
authors='/Authors',
cari='/Cari',
listAuthor='/TampilAuthor'
;

String default_Url = 'http://api.sinta.ristekdikti.go.id/', author_Url = 'author/detail/', journal_Url = 'journal/', affiliation_Url = 'affiliation/';

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

Map<String, dynamic> endpoint_api_url = {
  'author_all' : default_Url + 'author/',
  'author_detail' : default_Url + author_Url + 'overview/',
  'author_bimbingan' : default_Url + author_Url + 'bimbingan/',
  'author_scopus' : default_Url + author_Url + 'scopus/',
  'author_google' : default_Url + author_Url + 'google/',
  'author_book' : default_Url + author_Url + 'book/',
  'author_ipr' : default_Url + author_Url + 'ipr/',
  'author_service' : default_Url + author_Url + 'service/',
  'author_research' : default_Url + author_Url + 'research/',
  'journal_all' : default_Url + journal_Url,
  'journal_detail' : default_Url + journal_Url + 'detail/',
  'affiliation_all' : default_Url + affiliation_Url,
  'affiliation_detail' : default_Url + affiliation_Url + 'detail/',
};