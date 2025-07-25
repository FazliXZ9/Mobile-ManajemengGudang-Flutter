// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'theme_notifier.dart'; // Pastikan path ini benar

// Ganti dengan konfigurasi Firebase proyek Anda yang sebenarnya.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "YOUR_API_KEY", // GANTI INI
      appId: "YOUR_APP_ID", // GANTI INI
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID", // GANTI INI
      projectId: "YOUR_PROJECT_ID", // GANTI INI
      databaseURL: "https://YOUR_PROJECT_ID-default-rtdb.asia-southeast1.firebasedatabase.app", // GANTI INI
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.grey[100],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[400]!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2)),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.grey[500]),
        labelStyle: TextStyle(color: Colors.grey[800]), // Warna label sedikit lebih gelap
        prefixIconColor: Colors.grey[600],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black54),
        titleMedium: TextStyle(color: Colors.black87),
        titleLarge: TextStyle(color: Colors.black),
      ),
      iconTheme: IconThemeData(color: Colors.grey[700]),
      dividerColor: Colors.grey[300],
      dialogBackgroundColor: Colors.white,
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple, // Bisa juga pakai Colors.purple atau lainnya
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: ColorScheme.dark(
        primary: Colors.deepPurpleAccent[100]!,
        secondary: Colors.tealAccent[200]!, // Warna aksen untuk filter aktif, dll
        surface: const Color(0xFF1E1E1E), // Card, Dialog
        background: const Color(0xFF121212),
        error: Colors.redAccent[100]!,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurpleAccent[100],
        foregroundColor: Colors.black,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[700]!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.deepPurpleAccent[100]!, width: 2)),
        filled: true,
        fillColor: Colors.grey[800],
        hintStyle: TextStyle(color: Colors.grey[500]),
        labelStyle: TextStyle(color: Colors.grey[300]),
        prefixIconColor: Colors.grey[400],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent[100],
            foregroundColor: Colors.black),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Colors.deepPurpleAccent[100]),
      ),
      textTheme: Typography.whiteMountainView.copyWith(
        bodyLarge: TextStyle(color: Colors.grey[200]),
        bodyMedium: TextStyle(color: Colors.grey[400]),
        titleMedium: TextStyle(color: Colors.grey[100]),
        titleLarge: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.grey[400]),
      dividerColor: Colors.grey[700],
      dialogBackgroundColor: const Color(0xFF1E1E1E),
    );

    return MaterialApp(
      title: 'Data Barang',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.currentThemeMode,
      home: const BarangListPage(),
    );
  }
}

class ItemData {
  final String key;
  final Map<dynamic, dynamic> data;
  ItemData(this.key, this.data);
}

class BarangListPage extends StatefulWidget {
  const BarangListPage({super.key});

  @override
  State<BarangListPage> createState() => _BarangListPageState();
}

class _BarangListPageState extends State<BarangListPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('products');
  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  bool _isSearching = false;

  List<ItemData> _masterProductList = [];
  List<ItemData> _currentlyDisplayedItems = [];
  bool _isLoading = false;
  final int _itemsPerPage = 10;
  int _currentPageNumber = 1;
  int _totalFilteredItems = 0;

  String? _selectedStockFilterStatus;
  bool _isStockFilterActive = false;
  static const int _lowStockThreshold = 10;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _fetchAllProductsAndSetup();
  }

  void _onSearchChanged() {
    if (!mounted) return;
    if (_searchText != _searchController.text) {
      setState(() {
        _searchText = _searchController.text;
        _currentPageNumber = 1;
      });
      _applyAllFiltersAndPaginate();
    }
  }

  Future<void> _fetchAllProductsAndSetup() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final event = await _dbRef.once(DatabaseEventType.value);
      final snapshot = event.snapshot;
      List<ItemData> allItems = [];
      if (snapshot.exists && snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
        (snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            allItems.add(ItemData(key, value));
          }
        });
      }
      allItems.sort((a, b) => (a.data['name'] ?? '').toString().toLowerCase().compareTo((b.data['name'] ?? '').toString().toLowerCase()));
      if (!mounted) return;
      setState(() {
        _masterProductList = allItems;
      });
      _applyAllFiltersAndPaginate(); // Ini akan set _isLoading = false
    } catch (error) {
      print('Error fetching all products: $error');
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal memuat semua produk: $error')));
    }
  }

  void _applyAllFiltersAndPaginate() {
    if (!mounted) return;
    // Tidak perlu setState isLoading true di sini jika sumbernya _masterProductList
    
    List<ItemData> tempFilteredItems = List.from(_masterProductList);

    if (_searchText.isNotEmpty) {
      String searchQuery = _searchText.toLowerCase();
      tempFilteredItems = tempFilteredItems.where((item) {
        final String itemName = (item.data['name'] ?? '').toString().toLowerCase();
        final String itemDescription = (item.data['description'] ?? '').toString().toLowerCase();
        return itemName.contains(searchQuery) || itemDescription.contains(searchQuery);
      }).toList();
    }

    if (_isStockFilterActive && _selectedStockFilterStatus != null) {
      tempFilteredItems = tempFilteredItems.where((item) {
        int stock = 0;
        if (item.data['stock'] is int) {
          stock = item.data['stock'] as int;
        } else if (item.data['stock'] is String) {
          stock = int.tryParse(item.data['stock'] as String) ?? 0;
        } else if (item.data['stock'] is num) {
          stock = (item.data['stock'] as num).toInt();
        }
        switch (_selectedStockFilterStatus) {
          case "CUKUP": return stock >= _lowStockThreshold;
          case "MENIPIS": return stock > 0 && stock < _lowStockThreshold;
          case "KOSONG": return stock == 0;
          default: return true;
        }
      }).toList();
    }

    _totalFilteredItems = tempFilteredItems.length;
    int startIndex = (_currentPageNumber - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;

    if (startIndex >= _totalFilteredItems) {
      _currentlyDisplayedItems = [];
      if (_totalFilteredItems > 0 && _currentPageNumber > 1) {
         _currentPageNumber = 1;
         startIndex = 0;
         endIndex = _itemsPerPage;
         _currentlyDisplayedItems = tempFilteredItems.sublist(startIndex, endIndex.clamp(0, _totalFilteredItems));
      }
    } else {
      _currentlyDisplayedItems = tempFilteredItems.sublist(startIndex, endIndex.clamp(0, _totalFilteredItems));
    }
    
    if (!mounted) return;
    // Pastikan isLoading diset false di akhir proses ini
    setState(() {
       _isLoading = false; 
    });
  }

  Future<void> _showAddItemDialog(BuildContext context) async {
    _nameController.clear(); _descriptionController.clear(); _priceController.clear(); _stockController.clear();
    return showDialog<void>(
      context: context, barrierDismissible: false,
      builder: (BuildContext dialogContext) { 
        return AlertDialog(
          title: const Text('Tambah Barang Baru'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SingleChildScrollView(child: _buildFormFields()),
          actions: <Widget>[
            TextButton(child: const Text('Batal'), onPressed: () => Navigator.of(dialogContext).pop()),
            ElevatedButton(
              child: const Text('Tambah'),
              onPressed: () { _addItem(); Navigator.of(dialogContext).pop(); },
            ),
          ],
        );
      }
    );
  }

  void _addItem() {
    final String name = _nameController.text.trim();
    final String description = _descriptionController.text.trim();
    final num? price = num.tryParse(_priceController.text.trim());
    final int? stock = int.tryParse(_stockController.text.trim());

    if (name.isEmpty || price == null || price < 0 || stock == null || stock < 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nama, Harga, dan Stok valid tidak boleh kosong!'))); return;
    }
    final String timestamp = DateTime.now().toIso8601String();
    _dbRef.push().set({
      'name': name, 'description': description, 'price': price, 'stock': stock,
      'created_at': timestamp, 'updated_at': timestamp,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barang berhasil ditambahkan!')));
      _fetchAllProductsAndSetup(); 
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menambahkan barang: $error')));
    });
  }

  Future<void> _showEditDialog(BuildContext context, ItemData item) async { 
    _nameController.text = item.data['name'] ?? ''; _descriptionController.text = item.data['description'] ?? '';
    _priceController.text = (item.data['price'] ?? 0).toString(); _stockController.text = (item.data['stock'] ?? 0).toString();
    return showDialog<void>(
      context: context, barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Edit Barang'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SingleChildScrollView(child: _buildFormFields()),
          actions: <Widget>[
            TextButton(child: const Text('Batal'), onPressed: () => Navigator.of(dialogContext).pop()),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () { _updateItem(item.key); Navigator.of(dialogContext).pop(); },
            ),
          ],
        );
      }
    );
  }

  Widget _buildFormFields() { 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama Barang')),
        const SizedBox(height: 12),
        TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Deskripsi'), maxLines: 3),
        const SizedBox(height: 12),
        TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Harga'), keyboardType: TextInputType.number),
        const SizedBox(height: 12),
        TextField(controller: _stockController, decoration: const InputDecoration(labelText: 'Jumlah Stok'), keyboardType: TextInputType.number),
      ],
    );
  }

  void _updateItem(String itemKey) { 
    final String newName = _nameController.text.trim(); final String newDescription = _descriptionController.text.trim();
    final num? newPrice = num.tryParse(_priceController.text.trim()); final int? newStock = int.tryParse(_stockController.text.trim());

    if (newName.isEmpty || newPrice == null || newPrice < 0 || newStock == null || newStock < 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nama, Harga, dan Stok valid tidak boleh kosong!'))); return;
    }
    final String timestamp = DateTime.now().toIso8601String();
    Map<String, dynamic> updatedData = {
      'name': newName, 'description': newDescription, 'price': newPrice, 'stock': newStock, 'updated_at': timestamp,
    };
    _dbRef.child(itemKey).update(updatedData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barang berhasil diupdate!')));
      _fetchAllProductsAndSetup();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal mengupdate barang: $error')));
    });
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, ItemData item) async { 
    return showDialog<void>(
      context: context, barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus barang "${item.data['name'] ?? 'Tidak Dikenal'}"?'),
          actions: <Widget>[
            TextButton(child: const Text('Batal'), onPressed: () => Navigator.of(dialogContext).pop()),
            TextButton(
              child: Text('Hapus', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onPressed: () { _deleteItem(item.key); Navigator.of(dialogContext).pop(); },
            ),
          ],
        );
      }
    );
  }

  void _deleteItem(String itemKey) { 
    _dbRef.child(itemKey).remove().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barang berhasil dihapus!')));
      _fetchAllProductsAndSetup();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menghapus barang: $error')));
    });
  }

  Future<void> _showStockFilterDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Filter Status Stok'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButtonFormField<String?>(
                    value: _selectedStockFilterStatus,
                    hint: const Text('Pilih Status Stok'),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem<String?>(value: null, child: Text('Semua Status')),
                      DropdownMenuItem<String?>(value: "CUKUP", child: Text('Stok Cukup')),
                      DropdownMenuItem<String?>(value: "MENIPIS", child: Text('Stok Menipis')),
                      DropdownMenuItem<String?>(value: "KOSONG", child: Text('Stok Kosong')),
                    ],
                    onChanged: (String? newValue) {
                      setDialogState(() {
                        _selectedStockFilterStatus = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Reset'),
                onPressed: () {
                  setState(() {
                    _selectedStockFilterStatus = null;
                    _isStockFilterActive = false;
                    _currentPageNumber = 1;
                  });
                  _applyAllFiltersAndPaginate();
                  Navigator.of(dialogContext).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Terapkan'),
                onPressed: () {
                  setState(() {
                    _isStockFilterActive = _selectedStockFilterStatus != null;
                    _currentPageNumber = 1;
                  });
                  _applyAllFiltersAndPaginate();
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }


  @override
  void dispose() {
    _nameController.dispose();_descriptionController.dispose();_priceController.dispose();_stockController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildItemCard(ItemData item) { 
    num? price = item.data['price'] is num ? item.data['price'] : null;
    int? stock;
    if (item.data['stock'] is int) { stock = item.data['stock'] as int;
    } else if (item.data['stock'] is String) { stock = int.tryParse(item.data['stock'] as String);
    } else if (item.data['stock'] is num) { stock = (item.data['stock'] as num).toInt(); }

    Color stockColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
    FontWeight stockFontWeight = FontWeight.normal;

    if (stock == null || stock == 0) {
        stockColor = Theme.of(context).colorScheme.error;
    } else if (stock < _lowStockThreshold) {
        stockColor = Colors.orange.shade800; // Atau gunakan warna dari tema jika ada
        stockFontWeight = FontWeight.bold;
    }


    return Card(
      child: ListTile(
        leading: Icon(Icons.shopping_bag_outlined, size: 38, color: Theme.of(context).colorScheme.primary),
        title: Text(item.data['name'] ?? 'Nama tidak tersedia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Theme.of(context).textTheme.titleLarge?.color)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.data['description'] ?? '', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 5),
            Text('Stok: ${stock ?? 'N/A'}',
              style: TextStyle( fontSize: 14,
                fontWeight: stockFontWeight,
                color: stockColor,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
                mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    Text(price != null ? _currencyFormatter.format(price) : 'Rp 0', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, fontSize: 15)),
                    const SizedBox(height: 2), 
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                             SizedBox( width: 34, height: 32, 
                                child: IconButton(icon: Icon(Icons.edit_outlined, color: Theme.of(context).colorScheme.secondary, size: 20), onPressed: () => _showEditDialog(context, item), padding: EdgeInsets.zero, visualDensity: VisualDensity.compact, constraints: const BoxConstraints())),
                            SizedBox( width: 34, height: 32, 
                                child: IconButton(icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error, size: 20), onPressed: () => _showDeleteConfirmationDialog(context, item), padding: EdgeInsets.zero, visualDensity: VisualDensity.compact, constraints: const BoxConstraints())),
                        ],
                    )
                ],
            ),
          ],
        ),
        isThreeLine: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  Widget _buildPaginationControls() { 
    bool canLoadNextPage = (_currentPageNumber * _itemsPerPage) < _totalFilteredItems;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back_ios, size: 16), label: const Text(''),
            onPressed: (_currentPageNumber > 1 && !_isLoading) ? () { setState(() => _currentPageNumber--); _applyAllFiltersAndPaginate(); } : null,
          ),
          Text('Hal $_currentPageNumber (${_currentlyDisplayedItems.length} dari $_totalFilteredItems)', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward_ios, size: 16), label: const Text(''),
            onPressed: (canLoadNextPage && !_isLoading) ? () { setState(() => _currentPageNumber++); _applyAllFiltersAndPaginate(); } : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final bool isDarkMode = themeNotifier.currentThemeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? Container(
                height: 40, alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black.withOpacity(0.35) : Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8)),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87, fontSize: 17),
                  decoration: InputDecoration(
                    hintText: 'Cari barang...',
                    hintStyle: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey[600], fontSize: 17),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: isDarkMode ? Colors.grey[400] : Colors.grey[700], size: 20),
                    contentPadding: const EdgeInsets.symmetric(vertical: 11), 
                  ),
                  cursorColor: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              )
            : const Text('Daftar Barang'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              themeNotifier.currentThemeMode == ThemeMode.dark 
                  ? Icons.light_mode_outlined 
                  : Icons.dark_mode_outlined,
            ),
            tooltip: 'Ganti Tema',
            onPressed: () => themeNotifier.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white, // Atur agar ikon selalu berwarna putih
            ),
            tooltip: 'Filter Stok',
            onPressed: () {
              _showStockFilterDialog(context);
              // Anda mungkin masih ingin memberi tahu pengguna bahwa filter aktif dengan cara lain,
              // misalnya dengan mengubah ikon itu sendiri atau menambahkan badge.
            },
          ),
          _isSearching
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    if (mounted) setState(() => _isSearching = false);
                     _searchController.clear(); // Ini akan memicu _onSearchChanged
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => setState(() => _isSearching = true),
                ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _fetchAllProductsAndSetup, 
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading && _masterProductList.isEmpty // Tampilkan loading hanya jika master list belum terisi
                ? const Center(child: CircularProgressIndicator())
                : (_currentlyDisplayedItems.isEmpty 
                    ? Center(child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inventory_2_outlined, size: 60, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                            const SizedBox(height: 16),
                            Text(
                              _searchText.isNotEmpty || _isStockFilterActive 
                                  ? 'Tidak ada barang yang cocok.' : 'Belum ada barang.', 
                              textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
                            ),
                            const SizedBox(height: 8),
                            if (!(_searchText.isNotEmpty || _isStockFilterActive))
                              Text(
                                _isLoading ? 'Sedang memuat...' : 'Tambahkan barang baru atau periksa koneksi.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7), fontSize: 14),
                              ),
                          ],
                        ),
                      ))
                    : ListView.builder(
                        itemCount: _currentlyDisplayedItems.length,
                        itemBuilder: (context, index) => _buildItemCard(_currentlyDisplayedItems[index]),
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                      )),
          ),
          // Selalu tampilkan paginasi jika ada item (atau total filtered item > 0)
          if (_totalFilteredItems > 0 || _currentlyDisplayedItems.isNotEmpty)
            _buildPaginationControls(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _showAddItemDialog(context),
      //   tooltip: 'Tambah Barang',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}