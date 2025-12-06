# CryptoTracker Lite 🚀

Aplicación Flutter para seguimiento de criptomonedas en tiempo real, consumiendo datos de la API CoinGecko sin autenticación.

## 📋 Características Implementadas

✅ **Lista de Criptomonedas**
- Listado en tiempo real con precios actuales
- Información: precio, cambio 24h, market cap
- Pull to refresh
- Cargar más criptos (paginación)
- Caché en memoria (20 segundos)

✅ **Pantalla de Detalle**
- Información completa de cada cripto
- Precio actual, High/Low 24h
- Market Cap y ranking
- **Gráfico de 7 días** con fl_chart
- Mínimo y máximo de precio

✅ **Arquitectura Profesional**
- Clean Architecture (Domain, Data, Presentation)
- MVVM (ViewModel)
- BLoC para state management
- Atomic Design (Atoms → Molecules → Organisms → Templates → Pages)
- Inyección de dependencias con GetIt

✅ **Manejo de Errores**
- Detección de error 429 (Rate Limit)
- Pantallas de error personalizadas
- Reintentos de carga

✅ **Diseño**
- Modo oscuro profesional
- Colores: Negro, Azul, Dorado, Verde (positivo), Rojo (negativo)
- Tipografía: Google Fonts (Roboto)
- Responsive

## 🛠️ Tecnologías Usadas

- **Framework**: Flutter 3.38.3
- **State Management**: BLoC 8.1.4
- **API**: CoinGecko (sin key)
- **Gráficos**: fl_chart 1.1.1
- **Inyección de dependencias**: GetIt 7.7.0
- **Persistencia**: SharedPreferences (próximamente)
- **HTTP**: http 1.1.0

## 📁 Estructura del Proyecto
```
lib/
├── config/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── text_styles.dart
│   │   └── app_theme.dart
│   ├── constants/
│   │   └── api_constants.dart
│   └── dependency_injection/
│       └── service_locator.dart
├── features/
│   └── crypto_list/
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── crypto_entity.dart
│       │   │   └── market_data_entity.dart
│       │   └── repositories/
│       │       └── crypto_repository.dart
│       ├── data/
│       │   ├── datasources/
│       │   │   └── crypto_remote_datasource.dart
│       │   ├── models/
│       │   │   └── crypto_model.dart
│       │   └── repositories/
│       │       └── crypto_repository_impl.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── crypto_list/
│           │   └── crypto_detail/
│           ├── viewmodels/
│           │   ├── crypto_list_viewmodel.dart
│           │   └── crypto_detail_viewmodel.dart
│           ├── pages/
│           │   ├── crypto_list_page.dart
│           │   └── crypto_detail_page.dart
│           └── widgets/
│               ├── atoms/
│               ├── molecules/
│               ├── organisms/
│               └── templates/
└── main.dart
```

## 🚀 Instalación y Ejecución

### Requisitos Previos
- Flutter 3.0+
- Dart 3.0+

### Pasos

1. **Clonar el repositorio**
```bash
git clone https://github.com/genaro-velazquez/Crypto-Tracker-Lite-Challenge.git
cd Crypto-Tracker-Lite-Challenge
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Generar archivos JSON (si es necesario)**
```bash
dart run build_runner build
```

4. **Ejecutar en Chrome**
```bash
flutter run -d chrome
```

5. **Ejecutar en Android/iOS**
```bash
flutter run
```

## 📱 Flujo de la Aplicación
```
Pantalla de Lista
    ↓ (clic en cripto)
Pantalla de Detalle
    ↓ (con gráfico)
Información completa
```

## 🔄 Flujo de Datos
```
UI (Page)
  ↓
ViewModel (Lógica de presentación)
  ↓
BLoC (Manejo de estado)
  ↓
Repository (Datos puros)
  ↓
DataSource (Peticiones HTTP)
  ↓
API CoinGecko
```

## 📊 API Endpoints Utilizados

- `GET /coins/markets` - Lista de criptomonedas
- `GET /coins/{id}` - Detalles de una cripto
- `GET /coins/{id}/market_chart` - Gráfico de 7 días

## 🎨 Diseño

**Tema Oscuro:**
- Fondo Primario: #0F0F0F
- Fondo Secundario: #1A1A1A
- Color Primario: #1E88E5 (Azul)
- Positivo: #4CAF50 (Verde)
- Negativo: #FF5252 (Rojo)
- Dorado: #FFDD00

## 🚧 Próximas Características

- [ ] Sistema de favoritos con persistencia
- [ ] Pantalla de perfil de usuario
- [ ] Drawer de navegación
- [ ] Búsqueda y filtrado
- [ ] Notificaciones de cambios de precio
- [ ] Modo claro

## 👨‍💻 Autor

**Genaro Velázquez**

## 📄 Licencia

MIT License - Consulta el archivo [LICENSE](LICENSE) para más detalles.

## 🔗 Links

- [CoinGecko API](https://docs.coingecko.com/v3.0.1/reference)
- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Pattern](https://bloclibrary.dev/)