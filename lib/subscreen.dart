import 'package:flutter_app/dashboard.dart';
import 'package:flutter_app/categorytab.dart';
import 'package:flutter_app/productAdd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter_app/productList.dart';

import 'brandtab.dart';
import 'header.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Flexify for responsive design
    return const Flexify(
      designWidth: 1440, // Design width for desktop
      designHeight: 1024, // Design height for desktop

      app: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminDashboardScreen(),
      ),
    );
  }
}

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

/*class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Selected screen index for navigation
  int _selectedIndex = 0;
  // Drawer toggle state for mobile
  bool _isDrawerOpen = false;

  // List of screens corresponding to the menu items
  final List<Widget> _screens = [
     DashboardScreen(),
    const PosScreen(),
    const OrderScreen(),
    const ReturnBillScreen(),
    const CategoryScreen(),
    const BrandScreen(),
    const ProductScreen(),
    const SetupScreen(),
    const SettingsScreen(),
  ];

  // List of menu items for the drawer
  final List<String> _menuItems = [
    'Dashboard',
    'POS',
    'Order',
    'Return Bill',
    'Category',
    'Brand',
    'Product',
    'Setup',
    'Settings',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isDrawerOpen = false; // Close drawer on item tap (for mobile)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        // Hamburger menu button for mobile view
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Toggle the drawer for mobile
              setState(() {
                _isDrawerOpen = !_isDrawerOpen;
              });
            },
          ),
        ),
      ),
      // Using LayoutBuilder to detect the screen size
      body: LayoutBuilder(
        builder: (context, constraints) {
          // If screen width is greater than 800, show the drawer as static sidebar
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                // Drawer (static on the left side)
                Container(
                  width: 350.rw, // Flex 2 part for drawer width
                  color: Colors.white,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // Drawer header (could be a logo or profile)
                      DrawerHeader(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.admin_panel_settings, size: 40, color: Colors.white),
                            SizedBox(height: 10),
                            Text('Admin Dashboard', style: TextStyle(color: Colors.white, fontSize: 20)),
                          ],
                        ),
                      ),
                      // Drawer items
                      for (int i = 0; i < _menuItems.length; i++)
                        ListTile(
                          title: Text(_menuItems[i]),
                          onTap: () => _onItemTapped(i),
                        ),
                    ],
                  ),
                ),
                // Main content (screen area)
                Expanded(
                  flex: 8, // Flex 8 part for content width
                  child: _screens[_selectedIndex],
                ),
              ],
            );
          } else {
            // For smaller screens (mobile), use Drawer as slide-in
            return Row(
              children: [
                // Drawer for mobile (it will slide in)
                _isDrawerOpen
                    ? Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // Drawer header
                      DrawerHeader(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.admin_panel_settings, size: 40, color: Colors.white),
                            SizedBox(height: 10),
                            Text('Admin Dashboard', style: TextStyle(color: Colors.white, fontSize: 20)),
                          ],
                        ),
                      ),
                      // Drawer items
                      for (int i = 0; i < _menuItems.length; i++)
                        ListTile(
                          title: Text(_menuItems[i]),
                          onTap: () => _onItemTapped(i),
                        ),
                    ],
                  ),
                )
                    : Container(),
                // Main content (screen area)
                Expanded(
                  child: _screens[_selectedIndex],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}*/

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Selected screen index for navigation
  int _selectedIndex = 0;
  // Drawer toggle state for mobile
  bool _isDrawerOpen = false;

  // List of screens corresponding to the menu items
  final List<Widget> _screens = [
    DashboardScreen(),
    const PosScreen(),
    const OrderScreen(),
    const ReturnBillScreen(),
    const CategoryScreen(),
    const BrandScreen(),
    //  ProductScreen(),
    ProductListScreen(),
    const SetupScreen(),
    const SettingsScreen(),
  ];

  // List of menu items for the drawer
  final List<String> _menuItems = [
    'Dashboard',
    'POS',
    'Order',
    'Return Bill',
    'Category',
    'Brand',
    'Product',
    'Setup',
    'Settings',
  ];

  // Function to handle menu item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isDrawerOpen = false; // Close drawer on item tap (for mobile)
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        // Hamburger menu button for mobile view

        leading:_size.width < 750
            ? Builder(
          builder: (context) {
            // Check screen width and display menu button accordingly
            if (_size.width < 750) {
              // For smaller screens (mobile view), show the menu button
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    _isDrawerOpen = !_isDrawerOpen;
                  });
                },
              );
            } else {
              // For larger screens (desktop view), show nothing
              return SizedBox.shrink(); // or `SizedBox.shrink()` for an empty widget
            }
          },
        ) : null,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // If screen width is greater than 800, show the drawer as static sidebar
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                // Static side menu
                Container(
                  width: 280, // Set the drawer width
                  child: SideMenu(
                    onItemTapped: _onItemTapped,
                    selectedIndex: _selectedIndex,
                  ),
                ),
                // Main content (screen area)
                Expanded(
                  child: _screens[_selectedIndex],
                ),
              ],
            );
          } else {
            // For smaller screens (mobile), use Drawer as slide-in
            return Row(
              children: [
                // Mobile drawer (it will slide in)
                _isDrawerOpen
                    ? Drawer(
                  child: SideMenu(
                    onItemTapped: _onItemTapped,
                    selectedIndex: _selectedIndex,
                  ),
                )
                    : Container(),
                // Main content (screen area)
                Expanded(
                  child: _screens[_selectedIndex],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// Placeholder screens for other sections
class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('POS Screen', style: TextStyle(fontSize: 30)),
    );
  }
}

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Order Screen', style: TextStyle(fontSize: 30)),
    );
  }
}

class ReturnBillScreen extends StatelessWidget {
  const ReturnBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Return Bill Screen', style: TextStyle(fontSize: 30)),
    );
  }
}

// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Category Screen', style: TextStyle(fontSize: 30)),
//     );
//   }
// }


// import 'package:flutter/material.dart';
/*
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  final List<Map<String, dynamic>> _categories = [];
  String? _selectedPriority;
  String? _uploadedImage;

  final List<String> _priorities = ['1', '2', '3', '4', '5'];

  void _addCategory() {
    if (_categoryNameController.text.isNotEmpty &&
        _selectedPriority != null &&
        _uploadedImage != null) {
      setState(() {
        _categories.add({
          'name': _categoryNameController.text,
          'priority': _selectedPriority!,
          'image': _uploadedImage!,
        });
      });

      // Clear form fields after adding
      _categoryNameController.clear();
      _selectedPriority = null;
      _uploadedImage = null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields!')),
      );
    }
  }

  Future<void> _pickImage() async {
    // Mock file picker
    // Replace this with file_picker or image_picker plugin if needed
    setState(() {
      _uploadedImage = 'assets/dummy_image.png'; // Mocked file path
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Setup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Category Form
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Category',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _categoryNameController,
                      decoration: const InputDecoration(
                        labelText: 'Category Name (EN)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(),
                      ),
                      items: _priorities
                          .map((priority) => DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Choose File'),
                        ),
                        const SizedBox(width: 16),
                        _uploadedImage != null
                            ? const Text('File Selected')
                            : const Text('No file chosen'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _categoryNameController.clear();
                            setState(() {
                              _selectedPriority = null;
                              _uploadedImage = null;
                            });
                          },
                          child: const Text('Reset'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _addCategory,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Category List Table
            const Text(
              'Category List',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Category Image')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Priority')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _categories
                    .asMap()
                    .entries
                    .map(
                      (entry) => DataRow(cells: [
                    DataCell(Text((entry.key + 1).toString())),
                    DataCell(Image.asset(
                      entry.value['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )),
                    DataCell(Text(entry.value['name'])),
                    DataCell(Text(entry.value['priority'])),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Edit action here
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _categories.removeAt(entry.key);
                            });
                          },
                        ),
                      ],
                    )),
                  ]),
                )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/


// class BrandScreen extends StatelessWidget {
//   const BrandScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Brand Screen', style: TextStyle(fontSize: 30)),
//     );
//   }
// }

// class ProductScreen extends StatelessWidget {
//   const ProductScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Product Screen', style: TextStyle(fontSize: 30)),
//     );
//   }
// }

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Setup Screen', style: TextStyle(fontSize: 30)),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Screen', style: TextStyle(fontSize: 30)),
    );
  }
}


// class SideMenu extends StatelessWidget {
//   final void Function(int) onItemTapped;
//   final int selectedIndex;
//
//   const SideMenu({
//     Key? key,
//     required this.onItemTapped,
//     required this.selectedIndex,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Using the provided selectedIndex and onItemTapped callback
//     return Drawer(
//       child: Column(
//         children: [
//           // Drawer header with logo
//           SizedBox(height: 24),
//           Row(
//             children: [
//               SizedBox(
//                 height: 60,
//                 width: 200,
//                 child: Image.network(
//                   'https://6valley.6amtech.com/storage/app/public/company/2023-06-13-648845d83c293.png',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           // Drawer content
//           Expanded(
//             child: ListView.builder(
//               itemCount: 9, // The number of menu items
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_menuItems[index]),
//                   onTap: () {
//                     onItemTapped(index); // Trigger the item tapped callback
//                   },
//                   selected: index == selectedIndex, // Highlight the selected item
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class SideMenu extends StatelessWidget {
//   final void Function(int) onItemTapped;
//   final int selectedIndex;
//
//   const SideMenu({
//     Key? key,
//     required this.onItemTapped,
//     required this.selectedIndex,
//   }) : super(key: key);
//
//   static const double defaultPadding = 16.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       width: 250, // Set a fixed width for the drawer
//       child: Column(
//         children: [
//           // Logo section
//           SizedBox(height: defaultPadding * 3),
//           Row(
//             children: [
//               SizedBox(
//                 height: defaultPadding * 2,
//                 width: defaultPadding * 10,
//                 child: Image.network(
//                   'https://6valley.6amtech.com/storage/app/public/company/2023-06-13-648845d83c293.png',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(width: defaultPadding / 2),
//             ],
//           ),
//           SizedBox(height: defaultPadding * 2),
//
//           // Scrollable content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   DrawerListTile(
//                     title: "Dashboard",
//                     svgSrc: Icon(Icons.home, color: selectedIndex == 0 ? Colors.blue : Colors.black87),
//                     press: () => onItemTapped(0),
//                     isSelected: selectedIndex == 0,
//                   ),
//                   DrawerListTile(
//                     title: "POS",
//                     svgSrc: Icon(Icons.point_of_sale_sharp, color: selectedIndex == 1 ? Colors.blue : Colors.black87),
//                     press: () => onItemTapped(1),
//                     isSelected: selectedIndex == 1,
//                   ),
//                   DrawerListTile(
//                     title: "Order",
//                     svgSrc: Icon(Icons.shopping_cart_outlined, color: selectedIndex == 2 ? Colors.blue : Colors.black87),
//                     press: () => onItemTapped(2),
//                     isSelected: selectedIndex == 2,
//                   ),
//                   DrawerListTile(
//                     title: "Return Bill",
//                     svgSrc: Icon(Icons.receipt_long, color: selectedIndex == 3 ? Colors.blue : Colors.black87),
//                     press: () => onItemTapped(3),
//                     isSelected: selectedIndex == 3,
//                   ),
//                   HoverMenu(
//                     title: "Categories",
//                     icon: Icons.category_outlined,
//                     children: [
//                       DrawerSubItem(title: "Sub Categories", press: () {}),
//                       DrawerSubItem(title: "Sub Sub Categories", press: () {}),
//                     ],
//                     isSelected: selectedIndex == 4,
//                   ),
//                   DrawerListTile(
//                     title: "Brand",
//                     svgSrc: Icon(Icons.verified_outlined, color: selectedIndex == 5 ? Colors.blue : Colors.black87),
//                     press: () => onItemTapped(5),
//                     isSelected: selectedIndex == 5,
//                   ),
//                   HoverMenu(
//                     title: "Product",
//                     icon: Icons.archive_outlined,
//                     children: [
//                       DrawerSubItem(title: "All Products", press: () {}),
//                       DrawerSubItem(title: "Add Product", press: () {}),
//                     ],
//                     isSelected: selectedIndex == 6,
//                   ),
//                   HoverMenu(
//                     title: "Setup",
//                     icon: Icons.settings_applications,
//                     children: [
//                       DrawerSubItem(title: "General Settings", press: () {}),
//                       DrawerSubItem(title: "Shipping Setup", press: () {}),
//                       DrawerSubItem(title: "Payment Setup", press: () {}),
//                     ],
//                     isSelected: selectedIndex == 7,
//                   ),
//                   DrawerListTile(
//                     title: "Settings",
//                     svgSrc: Icon(Icons.settings_outlined, color: selectedIndex == 8 ? Colors.blue : Colors.black87),
//                     press: () => onItemTapped(8),
//                     isSelected: selectedIndex == 8,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

/*
class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final Icon svgSrc;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: svgSrc,
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black87,
        ),
      ),
    );
  }
}
*/
class HoverMenu extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool isSelected;
  final VoidCallback press;

  const HoverMenu({
    Key? key,
    required this.title,
    required this.icon,
    required this.children,
    required this.isSelected,
    required this.press,
  }) : super(key: key);

  @override
  _HoverMenuState createState() => _HoverMenuState();
}

class _HoverMenuState extends State<HoverMenu> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: widget.press,// Define actions on parent menu tap
            leading: Icon(
              widget.icon,
              color: widget.isSelected ? Colors.blue : Colors.black87,
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                color: widget.isSelected ? Colors.blue : Colors.black87,
              ),
            ),
          ),
          if (isHovered)
            Container(
              color: Colors.grey.shade200,
              child: Column(
                children: widget.children,
              ),
            ),
        ],
      ),
    );
  }
}

class DrawerSubItem extends StatelessWidget {
  final String title;
  final VoidCallback press;

  const DrawerSubItem({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      contentPadding: EdgeInsets.only(left: 40),
      title: Text(
        title,
        style: TextStyle(color: Colors.black87),
      ),
    );
  }
}


class SideMenu extends StatelessWidget {
  final void Function(int) onItemTapped;
  final int selectedIndex;

  const SideMenu({
    Key? key,
    required this.onItemTapped,
    required this.selectedIndex,
  }) : super(key: key);

  // Default padding value for spacing
  static const double defaultPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Fixed section: Image and Search field
          SizedBox(height: defaultPadding ),
          Row(
            children: [
              SizedBox(
                height: defaultPadding * 2,
                width: defaultPadding * 10,
                child: Image.network(
                  'https://6valley.6amtech.com/storage/app/public/company/2023-06-13-648845d83c293.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: defaultPadding / 2),
            ],
          ),
          SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: SearchField(),
          ), // Fixed Search field
          SizedBox(height: defaultPadding * 2),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Menu items list
                  DrawerListTile(
                    title: "Dashboard",
                    svgSrc: Icon(Icons.home, color: selectedIndex == 0 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(0),
                    isSelected: selectedIndex == 0,
                  ),
                  DrawerListTile(
                    title: "POS",
                    svgSrc: Icon(Icons.point_of_sale_sharp, color: selectedIndex == 1 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(1),
                    isSelected: selectedIndex == 1,
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: defaultPadding),
                      Text('Order management', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  DrawerListTile(
                    title: "Order",
                    svgSrc: Icon(Icons.shopping_cart_outlined, color: selectedIndex == 2 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(2),
                    isSelected: selectedIndex == 2,
                  ),
                  DrawerListTile(
                    title: "Return Bill",
                    svgSrc: Icon(Icons.receipt_long, color: selectedIndex == 3 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(3),
                    isSelected: selectedIndex == 3,
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: defaultPadding),
                      Text('Product management', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  DrawerListTile(
                    title: "Category",
                    svgSrc: Icon(Icons.category_outlined, color: selectedIndex == 4 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(4),
                    isSelected: selectedIndex == 4,
                  ),
                  DrawerListTile(
                    title: "Brand",
                    svgSrc: Icon(Icons.verified_outlined, color: selectedIndex == 5 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(5),
                    isSelected: selectedIndex == 5,
                  ),
                  /*DrawerListTile(
                    title: "Product",
                    svgSrc: Icon(Icons.archive_outlined, color: selectedIndex == 6 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(6),
                    isSelected: selectedIndex == 6,
                  ),
                  DrawerListTile(
                    title: "Setup",
                    svgSrc: Icon(Icons.settings_applications, color: selectedIndex == 7 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(7),
                    isSelected: selectedIndex == 7,
                  ),*/
                  HoverMenu(
                    title: "Product",
                    icon: Icons.archive_outlined,
                    press: () => onItemTapped(6),
                    children: [
                      DrawerSubItem(title: "All Products", press: () {}),
                      DrawerSubItem(title: "Add Product", press: () {}),
                    ],
                    isSelected: selectedIndex == 6,
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: defaultPadding),
                      Text('Promotion management', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  HoverMenu(
                    title: "Setup",
                    press: () => onItemTapped(7),
                    icon: Icons.settings_applications,
                    children: [
                      DrawerSubItem(title: "General Settings", press: () {}),
                      DrawerSubItem(title: "Shipping Setup", press: () {}),
                      DrawerSubItem(title: "Payment Setup", press: () {}),
                    ],
                    isSelected: selectedIndex == 7,
                  ),
                  DrawerListTile(
                    title: "Settings",
                    svgSrc: Icon(Icons.settings_outlined, color: selectedIndex == 8 ? Colors.blue : Colors.black87),
                    press: () => onItemTapped(8),
                    isSelected: selectedIndex == 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final Icon svgSrc;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: svgSrc,
      title: Row(
        children: [
          SizedBox(width: defaultPadding / 2),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}







// class SideMenu extends StatelessWidget {
//   final void Function(int) onItemTapped;
//   final int selectedIndex;
//
//    SideMenu({
//     Key? key,
//     required this.onItemTapped,
//     required this.selectedIndex,
//   }) : super(key: key);
//
//   // This variable will toggle the drawer's width
//   bool isCollapsed = false;
//
//   // Default padding value for spacing
//   static const double defaultPadding = 16.0;
//
//   // Function to toggle the state of the drawer (collapse or expand)
//   // void toggleDrawer() {
//   //   setState(() {
//   //     isCollapsed = !isCollapsed;
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     /* return Drawer(
//       // width: isCollapsed ? defaultPadding * 4 : defaultPadding * 12,
//       // GestureDetector(
//       //   onTap: toggleDrawer, // Toggle drawer on tap
//       //   child: Icon(
//       //     isCollapsed
//       //         ? Icons.arrow_forward_ios
//       //         : Icons.arrow_back_ios_new,
//       //   ),
//       // ),
//       child: Column(
//         children: [
//           SizedBox(height: defaultPadding * 3),
//           Row(
//             children: [
//               SizedBox(
//                 height: defaultPadding * 2,
//                 width: defaultPadding * 10,
//                 child: Image.network(
//                   'https://6valley.6amtech.com/storage/app/public/company/2023-06-13-648845d83c293.png',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(width: defaultPadding / 2),
//
//             ],
//           ),
//           SizedBox(height: defaultPadding * 2),
//           Expanded(child: Padding(
//             padding: const EdgeInsets.only(left: 8.0,right: 8),
//             child: SearchField(),
//           )), // Replace with your actual search field widget
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 DrawerListTile(
//                   title: "Dashboard",
//                   svgSrc: Icon(Icons.home,color: Colors.black87,),
//                   press: () {},
//                 ),
//                 DrawerListTile(
//                   title: "POS",
//                   svgSrc: Icon(Icons.point_of_sale_sharp,color: Colors.black87,),
//                   press: () {},
//                 ),
//                 SizedBox(height: defaultPadding,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(width: defaultPadding,),
//                     Text('Order management',style:  Theme.of(context).textTheme.titleMedium,),
//                   ],
//                 ),
//                 SizedBox(height: defaultPadding,),
//                 DrawerListTile(
//                   title: "Orders",
//                   svgSrc: Icon(Icons.shopping_cart_outlined,color: Colors.black87,),
//                   press: () {},
//                 ),
//                 DrawerListTile(
//                   title: "Refund Request",
//                   svgSrc: Icon(Icons.receipt_long,color: Colors.black87,),
//                   press: () {},
//                 ),
//                 // DrawerListTile(
//                 //   title: "Category",
//                 //   svgSrc: Icon(Icons.category_outlined,color: Colors.black87,),
//                 //   press: () {},
//                 // ),
//                 SizedBox(height: defaultPadding,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(width: defaultPadding,),
//                     Text('Product management',style:  Theme.of(context).textTheme.titleMedium,),
//                   ],
//                 ),
//                 SizedBox(height: defaultPadding,),
//                 ExpansionTile(
//                   title: Row(
//                     children: [
//                       Icon(Icons.category_outlined, color: Colors.black87),
//                       SizedBox(width: 10),
//                       Text('Category'),
//                     ],
//                   ),
//                   children: [
//                     ListTile(
//                       title: Text("Category"),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       title: Text("Sub Category"),
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//
//                 DrawerListTile(
//                   title: "Brand",
//                   svgSrc: Icon(Icons.verified_outlined,color: Colors.black87,),
//                   press: () {},
//                 ),
//                 ExpansionTile(
//                   title: Row(
//                     children: [
//                       Icon(Icons.archive_outlined, color: Colors.black87),
//                       SizedBox(width: 10),
//                       Text('Inhouse Product'),
//                     ],
//                   ),
//                   children: [
//                     ListTile(
//                       title: Text("Product List"),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       title: Text("Add New Product"),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       title: Text("Bulk Import"),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       title: Text("Request Load Stock"),
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//                 // DrawerListTile(
//                 //   title: "Product",
//                 //   svgSrc: Icon(Icons.archive,color: Colors.black87,),
//                 //   press: () {},
//                 // ),
//                 //
//                 SizedBox(height: defaultPadding,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(width: defaultPadding,),
//                     Text('Promotion management',style:  Theme.of(context).textTheme.titleMedium,),
//                   ],
//                 ),
//                 SizedBox(height: defaultPadding,),
//                 DrawerListTile(
//                   title: "Banner Setup",
//                   svgSrc: Icon(Icons.screen_search_desktop_rounded,color: Colors.black87,),
//                   press: () {},
//                 ),
//                 DrawerListTile(
//                   title: "Settings",
//                   svgSrc: Icon(Icons.settings_outlined,color: Colors.black87,),
//                   press: () {},
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );*/
//     return Drawer(
//       child: Column(
//         children: [
//           // Fixed section: Image and Search field
//           SizedBox(height: defaultPadding * 3),
//           Row(
//             children: [
//               SizedBox(
//                 height: defaultPadding * 2,
//                 width: defaultPadding * 10,
//                 child: Image.network(
//                   'https://6valley.6amtech.com/storage/app/public/company/2023-06-13-648845d83c293.png',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(width: defaultPadding / 2),
//             ],
//           ),
//           SizedBox(height: defaultPadding * 2),
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0, right: 8),
//             child: SearchField(),
//           ), // Fixed Search field
//           SizedBox(height: defaultPadding * 2),
//
//           // Scrollable content
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   DrawerListTile(
//                     title: "Dashboard",
//                     svgSrc: Icon(Icons.home, color: Colors.black87),
//                     press: () {},
//                   ),
//                   DrawerListTile(
//                     title: "POS",
//                     svgSrc: Icon(Icons.point_of_sale_sharp, color: Colors.black87),
//                     press: () {},
//                   ),
//                   SizedBox(height: defaultPadding),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(width: defaultPadding),
//                       Text('Order management', style: Theme.of(context).textTheme.titleMedium),
//                     ],
//                   ),
//                   SizedBox(height: defaultPadding),
//                   DrawerListTile(
//                     title: "Orders",
//                     svgSrc: Icon(Icons.shopping_cart_outlined, color: Colors.black87),
//                     press: () {},
//                   ),
//                   DrawerListTile(
//                     title: "Refund Request",
//                     svgSrc: Icon(Icons.receipt_long, color: Colors.black87),
//                     press: () {},
//                   ),
//                   SizedBox(height: defaultPadding),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(width: defaultPadding),
//                       Text('Product management', style: Theme.of(context).textTheme.titleMedium),
//                     ],
//                   ),
//                   SizedBox(height: defaultPadding),
//                   ExpansionTile(
//                     title: Row(
//                       children: [
//                         Icon(Icons.category_outlined, color: Colors.black87),
//                         SizedBox(width: 10),
//                         Text('Category'),
//                       ],
//                     ),
//                     children: [
//                       ListTile(
//                         title: Text("Category"),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         title: Text("Sub Category"),
//                         onTap: () {},
//                       ),
//                     ],
//                   ),
//                   DrawerListTile(
//                     title: "Brand",
//                     svgSrc: Icon(Icons.verified_outlined, color: Colors.black87),
//                     press: () {},
//                   ),
//                   ExpansionTile(
//                     title: Row(
//                       children: [
//                         Icon(Icons.archive_outlined, color: Colors.black87),
//                         SizedBox(width: 10),
//                         Text('Inhouse Product'),
//                       ],
//                     ),
//                     children: [
//                       ListTile(
//                         title: Text("Product List"),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         title: Text("Add New Product"),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         title: Text("Bulk Import"),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         title: Text("Request Load Stock"),
//                         onTap: () {},
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: defaultPadding),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(width: defaultPadding),
//                       Text('Promotion management', style: Theme.of(context).textTheme.titleMedium),
//                     ],
//                   ),
//                   SizedBox(height: defaultPadding),
//                   DrawerListTile(
//                     title: "Banner Setup",
//                     svgSrc: Icon(Icons.screen_search_desktop_rounded, color: Colors.black87),
//                     press: () {},
//                   ),
//                   DrawerListTile(
//                     title: "Settings",
//                     svgSrc: Icon(Icons.settings_outlined, color: Colors.black87),
//                     press: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//
//   }
// }
//
//
//
// class DrawerListTile extends StatelessWidget {
//   const DrawerListTile({
//     Key? key,
//     // For selecting those three line once press "Command+D"
//     required this.title,
//     required this.svgSrc,
//     required this.press,
//   }) : super(key: key);
//
//   final String title;
//   final VoidCallback press;
//   final Icon svgSrc;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: press,
//       horizontalTitleGap: 0.0,
//       leading: svgSrc,
//       // SvgPicture.asset(
//       //   svgSrc,
//       //   colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
//       //   height: 16,
//       // ),
//       title: Row(
//         children: [
//           SizedBox(width: defaultPadding/2,),
//           Text(
//             title,
//             style: TextStyle(color: Colors.black87),
//           ),
//         ],
//       ),
//     );
//   }
// }
