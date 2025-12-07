# CryptoTracker Lite 🚀

Aplicación Flutter para seguimiento de criptomonedas en tiempo real, consumiendo datos de la API CoinGecko sin autenticación. Proyecto completo con Clean Architecture, BLoC, MVVM y Atomic Design.

## 📋 Características Implementadas

✅ **Lista de Criptomonedas**
- Listado en tiempo real con precios actuales
- Información: precio, cambio 24h, porcentaje
- Pull to refresh
- Cargar más criptos (paginación)
- Caché en memoria (20 segundos)
- Sistema de favoritos con persistencia
- Sincronización de estado entre pantallas

✅ **Pantalla de Detalle**
- Información completa de cada cripto
- Precio actual, High/Low 24h
- Market Cap y ranking
- **Gráfico de 7 días** con fl_chart (línea con área sombreada)
- Mínimo y máximo de precio
- Toggle de favoritos en AppBar
- **Descripción completa de la moneda** (obtenida de API)
- Pull to refresh

✅ **Sistema de Favoritos** 🤍
- Guardar/eliminar favoritos con SharedPreferences
- Toggle funcional en lista y detalle
- Persistencia de datos entre sesiones
- Sincronización automática entre todas las pantallas
- Pantalla dedicada de favoritos
- Recargar automáticamente al regresar de otras pantallas

✅ **Drawer de Navegación** ☰
- Menú lateral con avatar, nombre y email
- Acceso rápido a Favoritos y Perfil
- Items con iconos coloreados y bordes personalizados
- Navegación fluida entre secciones

✅ **Pantalla de Perfil** 👤
- Avatar con borde dorado
- Información de cuenta (Nombre, Email)
- Detalles adicionales (Ubicación, Teléfono)
- Estadísticas de usuario
- Acceso desde el Drawer

✅ **Arquitectura Profesional**
- Clean Architecture (Domain, Data, Presentation)
- MVVM (ViewModel)
- BLoC para state management
- Atomic Design (Atoms → Molecules → Organisms → Templates → Pages)
- Inyección de dependencias con GetIt
- FavoritesService para manejo local

✅ **Manejo de Errores**
- Detección de error 429 (Rate Limit)
- Pantallas de error personalizadas
- Reintentos de carga
- Estados de carga optimizados
- Mensajes de error amigables

✅ **Diseño Profesional**
- Modo oscuro completo
- Colores: Negro, Azul, Dorado, Verde (positivo), Rojo (negativo)
- Tipografía: Google Fonts (Roboto)
- Responsive
- Grid de 2x2 para estadísticas de mercado
- Tarjetas con bordes redondeados
- Elementos con transiciones suaves
- Avatares y componentes visuales atractivos

## 🛠️ Tecnologías Usadas

- **Framework**: Flutter 3.38.3
- **State Management**: BLoC 8.1.4
- **API**: CoinGecko REST API (sin autenticación)
- **Gráficos**: fl_chart 1.1.1
- **Inyección de dependencias**: GetIt 7.7.0
- **Persistencia Local**: SharedPreferences
- **Networking**: http 1.1.0
- **Serialización JSON**: json_serializable, build_runner
- **Utilidades**: Equatable

## 📁 Estructura del Proyecto
```
lib/
├── assets/
│   └── images/
│       └── profile.jpg
├── config/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── text_styles.dart
│   │   └── app_theme.dart
│   ├── constants/
│   │   └── api_constants.dart
│   └── dependency_injection/
│       └── service_locator.dart
├── data/
│   └── services/
│       └── favorites_service.dart
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
│           │   ├── crypto_detail/
│           │   └── favorites/
│           ├── viewmodels/
│           │   ├── crypto_list_viewmodel.dart
│           │   ├── crypto_detail_viewmodel.dart
│           │   └── favorites_viewmodel.dart
│           ├── pages/
│           │   ├── crypto_list_page.dart
│           │   ├── crypto_detail_page.dart
│           │   ├── favorites_page.dart
│           │   └── profile_page.dart
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

3. **Generar archivos JSON**
```bash
dart run build_runner build
```

4. **Ejecutar en Chrome (Web)**
```bash
flutter run -d chrome
```

5. **Ejecutar en Android**
```bash
flutter run
```

6. **Ejecutar en iOS**
```bash
flutter run -d ios
```

## 📱 Guía de Uso

### 1. Pantalla de Lista
- **Ver criptos**: La app carga automáticamente las criptomonedas
- **Marcar favorito**: Click en la estrella (⭐) para guardar
- **Ver detalle**: Click en la tarjeta de la cripto
- **Cargar más**: Scroll hacia abajo y click en "Cargar más"
- **Refrescar**: Pull to refresh (arrastra hacia abajo)

### 2. Pantalla de Detalle
- **Información completa**: Precio, High/Low, Market Cap
- **Gráfico de 7 días**: Visualiza la tendencia de precio
- **Descripción**: Lee detalles sobre la criptomoneda
- **Favorito**: Click en estrella para agregar/eliminar
- **Refrescar**: Pull to refresh

### 3. Pantalla de Favoritos
- **Ver favoritos**: Solo las criptos marcadas
- **Eliminar**: Click en la estrella para quitar
- **Ir a detalle**: Click en la tarjeta
- **Sincronización**: Se actualiza automáticamente

### 4. Drawer de Navegación (☰)
- **Inicio**: Volver a lista
- **Favoritos**: Ir a pantalla de favoritos
- **Perfil**: Ver información de usuario
- **Configuración**: Acceso rápido
- **Acerca de**: Información de la app

### 5. Pantalla de Perfil
- **Avatar**: Foto de perfil
- **Información de cuenta**: Nombre y email
- **Datos personales**: Ubicación, teléfono
- **Estadísticas**: Criptos vistas, favoritos, días activo

## 🔄 Flujo de Datos
```
UI (Page)
  ↓
ViewModel (Lógica de presentación)
  ↓
BLoC (Manejo de estado)
  ↓
Repository (Datos puros)
  ├─ RemoteDataSource (Peticiones HTTP a CoinGecko)
  └─ FavoritesService (Almacenamiento local)
  ↓
API CoinGecko / SharedPreferences
```

## 📊 API Endpoints Utilizados

- `GET /coins/markets` - Lista de criptomonedas (250 por página)
- `GET /coins/{id}` - Detalles completos de una cripto
- `GET /coins/{id}/market_chart` - Datos históricos de 7 días

**Parámetros:**
- `vs_currency=usd` - Precios en dólares
- `order=market_cap_desc` - Ordenado por capitalización
- `per_page=250` - Máximo de resultados

## 🎨 Diseño Visual

### Tema Oscuro
```
Primario (#0F0F0F)     → Fondo principal
Secundario (#1A1A1A)   → Fondo alternativo
Superficie (#2D2D2D)   → Tarjetas y componentes
Azul (#1E88E5)         → Color principal
Dorado (#FFDD00)       → Favoritos y destacados
Verde (#4CAF50)        → Cambios positivos
Rojo (#FF5252)         → Cambios negativos
```

### Componentes
- **Tarjetas**: Bordes redondeados (12-16px)
- **Botones**: Esquinas redondeadas con efecto
- **Íconos**: Material Design 2
- **Fuente**: Roboto (Google Fonts)
- **Espaciado**: Consistente y responsive

## ⚡ Características Técnicas

- **Caché en Memoria**: 20 segundos para evitar sobrecarga
- **Rate Limit Handling**: Detección y mensaje de error 429
- **Sincronización de Estado**: Favoritos se actualizan en todas las pantallas
- **Pull to Refresh**: Recarga de datos en todas las vistas
- **Error Handling**: Pantallas personalizadas para errores
- **Null Safety**: 100% null-safe
- **Type Safety**: Uso de tipos genéricos

## 🚧 Próximas Características

- [ ] Búsqueda y filtrado de criptos
- [ ] Notificaciones de cambios de precio
- [ ] Modo claro
- [ ] Historial de cambios en gráficos
- [ ] Comparativa entre criptos
- [ ] Exportar datos
- [ ] Análisis técnico adicional

## 👨‍💻 Autor

**Genaro Velázquez**

## 📄 Licencia

MIT License - Consulta el archivo [LICENSE](LICENSE) para más detalles.

## 🔗 Links Útiles

- [CoinGecko API Documentation](https://docs.coingecko.com/v3.0.1/reference)
- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Pattern Guide](https://bloclibrary.dev/)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [Atomic Design](https://atomicdesign.bradfrost.com/)

## 📝 Notas de Desarrollo

### Decisiones Arquitectónicas
- **BLoC + MVVM**: Separación clara de responsabilidades
- **Atomic Design**: Componentes reutilizables y escalables
- **Repository Pattern**: Abstracción de fuentes de datos
- **Service Locator**: Inyección de dependencias centralizada

### Optimizaciones
- Caché en memoria para reducir peticiones
- Lazy loading de criptos (paginación)
- Widget rebuilds optimizados con BLoC
- Uso de Equatable para comparaciones eficientes

### Testing (Recomendado para futuro)
- Unit tests para ViewModels
- Widget tests para Pages
- Integration tests para flujos completos