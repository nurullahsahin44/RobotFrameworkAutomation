---------System Gereksinimleri-----------------

-Python
-Robot Framework
--pip install robotframework

--------------Version-----------------------

Library   RequestsLibrary
Library   SeleniumLibrary
Library   String
Library   FakerLibrary
Library   JSONLibrary
kütüphanalerini çekebilecek bir versiyon olması yeterli olacaktır.

----------------------Proje Hakkinda-------------------------

https://todomvc.com/examples/vue/#    adresi için 7 farklı test case oluşturulup web üzerinden otomatize edilmesini ele almaktadır.
Test caseleri   TestCases.xlsx   içerisinden göz atabilirsiniz.

----------------------Dosya Yapısı---------------------------

***Library
Robot framework'den bağımsız olarak CustomLibrary yazmak isterseniz eğer Library içerisinde tutulabilir, PYTHON dilinde olmalıdır

***Resources
Otomasyon için tüm kaynaklar bu alanda tutulmalıdır,
Alt başlıklarından Config içerisinde tüm proje için kullanılacak değişkenlerimiz mevcuttur, URL - Username vb.
Pages içerinde ise sayfa sayfa elementler tutulmaktaır, Ana Sayfaya ait elementler veya Giriş Sayfasına ait elementler için düşünebilirsiniz. Page Object Model

***Steps

Base içerisinde tüm proje genelinde kullanılabilecek steps'ler bulunmaktadır, tarayıcıyı ac - tarayıcıyı kapat  vb.
MySteps içerisinde robot framework'ün sağladığı steps'lerin birleşimi ile daha anlaşılır steps'ler yazmamızı sağlamaktadır.Custom Library için RobotFramework'ün yetersiz kaldığı noktalarda , burada ise varolanların birleşimi ile daha anlaşılır steps'ler yazmamızı saglar.

***Results

Sonuclar için olusturulmustur fakat bu tamamen değişkendir.

***TestCases

Bu alanda sadece case'ler bulunmaktadır, altına yeni klasörler açıp modül modül ayrılabilmektedir.

***venv

Python projelerinin versiyon bağımsızlığını ortadan kaldırmak adına olusturdum.
Virtual Environment anlamına gelmektedir.

***.gitignore

commit atarken yasaklanmasını istediğim dosya türlerini ekledim. Hazır olarak aldım

***chromedriver.exe

Chrome ile test başlattıgınızda otomatik olarak proje içerisindekini alacaktır fakat calıstırılan bilgisayarda kullanılan chrome ile eşleşmelidir.
94.... versiyonu'nu ekledim.

***gecodriver.exe

Mozilla ile test başlatmak isterseniz otomatik olarak proje içeirisnde bulunanı alacaktır versiyon bağımlılığı yoktur case'leri mozillaya göre tamamladım.

***TestCases.xlsx

Tüm senaryolar yer almaktadır.


----------------------Case Execution---------------------------

Hazır komutları kullanabilirsiniz.

Test ismine göre başlatmak isterseniz,

robot -d SonucDosyasi -t "testismi"  DosyaUzantısı

robot -d Results -t "Todomvc_Page_Display"  TestCases/Test.robot

Tüm case'leri başlatmak isterseniz,

robot -d Results TestCases/Test.robot

