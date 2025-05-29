import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import for localization delegates

import 'providers/theme_provider.dart'; // You will create this file
import 'providers/locale_provider.dart'; // You will create this file
import 'view_models/product_view_model.dart';
import 'view_models/cart_view_model.dart';
import 'view_models/login_view_model.dart';
import 'view_models/order_view_model.dart';
import 'views/catalog_screen.dart';
import 'views/favorites_screen.dart';
import 'views/cart_screen.dart';
import 'views/account_screen.dart';
import 'views/orders_screen.dart';
import 'views/settings_screen.dart';
import 'views/support_screen.dart';
// If you use flutter_gen_l10n for custom app localizations,
// you'll also import the generated file like:
// import 'package:your_app_name/l10n/app_localizations.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        // Add ThemeProvider and LocaleProvider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const BloomyApp(), // Renamed from MyApp for clarity
    ),
  );
}

class BloomyApp extends StatelessWidget {
  const BloomyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the providers for theme and locale
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Bloomy',
      // Theme settings driven by ThemeProvider
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData.dark(),
      // Locale settings driven by LocaleProvider
      locale: localeProvider.locale,
      // Define all supported locales for your app
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ru', ''), // Russian (as per your example)
        // Add any other locales your app will support
      ],
      // Localization delegates for standard Flutter widgets
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // If you're using flutter_gen_l10n for custom strings,
        // uncomment the following line and replace with your actual delegate:
        // AppLocalizations.delegate,
      ],
      home: const HomeScreen(),
      routes: {
        // Your existing routes remain the same
        '/catalog': (context) => CatalogScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/cart': (context) => CartScreen(),
        '/account': (context) => AccountScreen(),
        '/orders': (context) => OrdersScreen(),
        '/settings': (context) => SettingsScreen(),
        '/support': (context) => SupportScreen(),
      },
    );
  }
}

// Your existing HomeScreen widget remains unchanged
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    CatalogScreen(),
    FavoritesScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Каталог'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Корзина'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Аккаунт'),
        ],
      ),
    );
  }
}