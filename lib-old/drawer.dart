import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'header.dart';
// import 'package:flutter_svg/flutter_svg.dart';

/*class SideMenu extends StatelessWidget {
   SideMenu({
    Key? key,
  }) : super(key: key);

  // This variable will toggle the drawer's width
  bool isCollapsed = false;

  // Default padding value for spacing
  static const double defaultPadding = 16.0;

  // Function to toggle the state of the drawer (collapse or expand)
  void toggleDrawer() {

      isCollapsed = !isCollapsed;

  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: isCollapsed ? defaultPadding * 4 : defaultPadding * 12,
      child: ListView(
        children: [
          // DrawerHeader(
          //   child: Icon(Icons.home),
          // ),
          SizedBox(height: defaultPadding*3,),
          Row(
            children: [
              SizedBox(height:defaultPadding*2,width:defaultPadding*10,child: Image.network('https://6valley.6amtech.com/storage/app/public/company/2023-06-13-648845d83c293.png')),
              SizedBox(width: defaultPadding/2,),
              GestureDetector(
                onTap: toggleDrawer, // Toggle drawer on tap
                child: Icon(
                  isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios_new,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding*2),
          Expanded(child: SearchField()),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Transaction",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Task",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Documents",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Store",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}*/

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  // This variable will toggle the drawer's width
  bool isCollapsed = false;

  // Default padding value for spacing
  static const double defaultPadding = 16.0;

  // Function to toggle the state of the drawer (collapse or expand)
  void toggleDrawer() {
    setState(() {
      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
   /* return Drawer(
      // width: isCollapsed ? defaultPadding * 4 : defaultPadding * 12,
      // GestureDetector(
      //   onTap: toggleDrawer, // Toggle drawer on tap
      //   child: Icon(
      //     isCollapsed
      //         ? Icons.arrow_forward_ios
      //         : Icons.arrow_back_ios_new,
      //   ),
      // ),
      child: Column(
        children: [
          SizedBox(height: defaultPadding * 3),
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
          SizedBox(height: defaultPadding * 2),
          Expanded(child: Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: SearchField(),
          )), // Replace with your actual search field widget
          SingleChildScrollView(
            child: Column(
              children: [
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: Icon(Icons.home,color: Colors.black87,),
                  press: () {},
                ),
                DrawerListTile(
                  title: "POS",
                  svgSrc: Icon(Icons.point_of_sale_sharp,color: Colors.black87,),
                  press: () {},
                ),
                SizedBox(height: defaultPadding,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: defaultPadding,),
                    Text('Order management',style:  Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
                SizedBox(height: defaultPadding,),
                DrawerListTile(
                  title: "Orders",
                  svgSrc: Icon(Icons.shopping_cart_outlined,color: Colors.black87,),
                  press: () {},
                ),
                DrawerListTile(
                  title: "Refund Request",
                  svgSrc: Icon(Icons.receipt_long,color: Colors.black87,),
                  press: () {},
                ),
                // DrawerListTile(
                //   title: "Category",
                //   svgSrc: Icon(Icons.category_outlined,color: Colors.black87,),
                //   press: () {},
                // ),
                SizedBox(height: defaultPadding,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: defaultPadding,),
                    Text('Product management',style:  Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
                SizedBox(height: defaultPadding,),
                ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.category_outlined, color: Colors.black87),
                      SizedBox(width: 10),
                      Text('Category'),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Text("Category"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Sub Category"),
                      onTap: () {},
                    ),
                  ],
                ),
                
                DrawerListTile(
                  title: "Brand",
                  svgSrc: Icon(Icons.verified_outlined,color: Colors.black87,),
                  press: () {},
                ),
                ExpansionTile(
                  title: Row(
                    children: [
                      Icon(Icons.archive_outlined, color: Colors.black87),
                      SizedBox(width: 10),
                      Text('Inhouse Product'),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Text("Product List"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Add New Product"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Bulk Import"),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Request Load Stock"),
                      onTap: () {},
                    ),
                  ],
                ),
                // DrawerListTile(
                //   title: "Product",
                //   svgSrc: Icon(Icons.archive,color: Colors.black87,),
                //   press: () {},
                // ),
                //
                SizedBox(height: defaultPadding,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: defaultPadding,),
                    Text('Promotion management',style:  Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
                SizedBox(height: defaultPadding,),
                DrawerListTile(
                  title: "Banner Setup",
                  svgSrc: Icon(Icons.screen_search_desktop_rounded,color: Colors.black87,),
                  press: () {},
                ),
                DrawerListTile(
                  title: "Settings",
                  svgSrc: Icon(Icons.settings_outlined,color: Colors.black87,),
                  press: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );*/
    return Drawer(
      child: Column(
        children: [
          // Fixed section: Image and Search field
          SizedBox(height: defaultPadding * 3),
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
          SizedBox(height: defaultPadding * 2),
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
                  DrawerListTile(
                    title: "Dashboard",
                    svgSrc: Icon(Icons.home, color: Colors.black87),
                    press: () {},
                  ),
                  DrawerListTile(
                    title: "POS",
                    svgSrc: Icon(Icons.point_of_sale_sharp, color: Colors.black87),
                    press: () {},
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
                    title: "Orders",
                    svgSrc: Icon(Icons.shopping_cart_outlined, color: Colors.black87),
                    press: () {},
                  ),
                  DrawerListTile(
                    title: "Refund Request",
                    svgSrc: Icon(Icons.receipt_long, color: Colors.black87),
                    press: () {},
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
                  // ExpansionTile(
                  //   title: Row(
                  //     children: [
                  //       Icon(Icons.category_outlined, color: Colors.black87),
                  //       SizedBox(width: 10),
                  //       Text('Category'),
                  //     ],
                  //   ),
                  //   children: [
                  //     ListTile(
                  //       title: Text("Category"),
                  //       onTap: () {},
                  //     ),
                  //     ListTile(
                  //       title: Text("Sub Category"),
                  //       onTap: () {},
                  //     ),
                  //   ],
                  // ),
                   Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.only(left: defaultPadding,right: defaultPadding*2),
                childrenPadding: EdgeInsets.only(left: defaultPadding*2,),
                title: Row(
                  children: [
                    // SizedBox(width: defaultPadding),
                    Icon(Icons.category_outlined, color: Colors.black87),
                    SizedBox(width: 10),
                    Text('Category'),
                  ],
                ),
                children: [
                  ListTile(
                    title: Text("Category"),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Sub Category"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
                  DrawerListTile(
                    title: "Brand",
                    svgSrc: Icon(Icons.verified_outlined, color: Colors.black87),
                    press: () {},
                  ),
                  ExpansionTile(
                    title: Row(
                      children: [
                        Icon(Icons.archive_outlined, color: Colors.black87),
                        SizedBox(width: 10),
                        Text('Inhouse Product'),
                      ],
                    ),
                    children: [
                      ListTile(
                        title: Text("Product List"),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text("Add New Product"),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text("Bulk Import"),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text("Request Load Stock"),
                        onTap: () {},
                      ),
                    ],
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
                  DrawerListTile(
                    title: "Banner Setup",
                    svgSrc: Icon(Icons.screen_search_desktop_rounded, color: Colors.black87),
                    press: () {},
                  ),
                  DrawerListTile(
                    title: "Settings",
                    svgSrc: Icon(Icons.settings_outlined, color: Colors.black87),
                    press: () {},
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
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final Icon svgSrc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: svgSrc,
      // SvgPicture.asset(
      //   svgSrc,
      //   colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
      //   height: 16,
      // ),
      title: Row(
        children: [
          SizedBox(width: defaultPadding/2,),
          Text(
            title,
            style: TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
