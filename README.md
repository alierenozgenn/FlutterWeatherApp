# Flutter Weather App

## Proje Açıklaması
Bu uygulama, OpenWeatherMap API kullanarak hava durumu bilgilerini görüntüleyen bir Flutter mobil uygulamasıdır. Kullanıcılar şehir adına veya mevcut konumlarına göre hava durumu bilgisi alabilirler.

## Özellikler
- Şehir arama
- Anlık konum bazlı hava durumu
- Son aranan şehirleri kaydetme
- Glassmorphic tasarım
- Detaylı hava durumu bilgileri
  - Sıcaklık
  - Hissedilen sıcaklık
  - Nem oranı
  - Rüzgar hızı

## Başlarken

### Gereksinimler
- Flutter SDK (3.0.0 üzeri)
- Dart SDK
- OpenWeatherMap API Key

### Kurulum
1. Projeyi klonlayın
```bash
git clone https://github.com/alierenozgenn/FlutterWeatherApp.git
cd weather_app
```

2. Bağımlılıkları yükleyin
```bash
flutter pub get
```

3. OpenWeatherMap API Key'inizi `weather_service.dart` dosyasında güncelleyin
```dart
static const String apiKey = 'YOUR_API_KEY';
```

### Çalıştırma
```bash
flutter run
```

## Kullanılan Teknolojiler
- Flutter
- Provider (State Management)
- OpenWeatherMap API
- Geolocator
- Glassmorphism
- Google Fonts

## Katkıda Bulunma
1. Fork edin
2. Kendi branch'inizi oluşturun (`git checkout -b feature/AmazingFeature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add some AmazingFeature'`)
4. Branch'inizi push edin (`git push origin feature/AmazingFeature`)
5. Bir Pull Request açın

## Lisans
MIT Lisansı ile dağıtılmaktadır.

