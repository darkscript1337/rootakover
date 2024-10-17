# Subdomain Takeover Tespit Uygulaması

Bu uygulama, bir `.txt` dosyası içindeki subdomain'lerin takeover (ele geçirilme) durumu olup olmadığını kontrol eder. Uygulama HTTP ve HTTPS protokollerini kullanarak her bir subdomain'i ziyaret eder ve belirtilen koşullara göre takeover olup olmadığını tespit eder.

## Uygulama Nasıl Çalışır?

1. Uygulama, kullanıcıdan içinde subdomain'lerin listelendiği bir `.txt` dosyası ister.
2. Her subdomain'e sırasıyla HTTP ve HTTPS üzerinden istek gönderilir.
3. Yanıt içinde belirtilen takeover belirtilerinden biri mevcutsa, bu subdomain takeover tespit edilmiş olarak kabul edilir.
4. Eğer takeover tespit edilirse, uygulama "takeoverlar.txt" dosyasına subdomain'i kaydeder.
5. Eğer hiç takeover bulunmazsa dosya oluşturulmaz.


### Kurulması Gereken Kütüphaneler

Ruby'nin standart kütüphanelerini kullanıyoruz. Dolayısıyla harici bir kütüphane kurulumu gerekmemektedir. Ancak aşağıdaki standart kütüphaneler kullanılıyor:

- **net/http**: HTTP ve HTTPS istekleri yapmak için kullanılır.
- **uri**: URL'leri yönetmek için kullanılır.

Bu kütüphaneler Ruby ile birlikte geldiği için ek bir işlem yapmanıza gerek yoktur.

