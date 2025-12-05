# CryptoTracker Lite

App Flutter para seguimiento de criptomonedas en tiempo real.

## Características
- Lista de criptomonedas con precios en vivo
- Conexión a API CoinGecko
- Caché en memoria
- Arquitectura Clean Architecture + MVVM + BLoC
- Atomic Design

## Instalación
```bash
flutter pub get
flutter run -d chrome
```

## Estructura
- `lib/config/` - Configuración (tema, colores, constantes)
- `lib/features/` - Features (Domain, Data, Presentation)
- `lib/features/crypto_list/presentation/widgets/` - Atomic Design

## Autor
Genaro Velázquez