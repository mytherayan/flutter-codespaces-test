import 'package:flutter_app/responsive.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'header.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


const primaryColor = Colors.black12;
const primaryColorWhite = Colors.white10;
// const primaryColor = Colors.white24;
// const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 8,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}


//
// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         primary: false,
//         padding: EdgeInsets.all(defaultPadding),
//         child: Column(
//           children: [
//             Header(),
//             // SizedBox(height: defaultPadding),
//
//             SizedBox(height: defaultPadding),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 8,
//                   child: Column(
//                     children: [
//                       MyFiles(),
//                       SizedBox(height: defaultPadding),
//                       Text('table'),
//                       if (Responsive.isMobile(context))
//                         SizedBox(height: defaultPadding),
//                       if (Responsive.isMobile(context)) Text('hi'),
//                     ],
//                   ),
//                 ),
//                 if (!Responsive.isMobile(context))
//                   SizedBox(width: defaultPadding),
//                 // On Mobile means if the screen is less than 850 we don't want to show it
//                 // if (!Responsive.isMobile(context))
//                 //   Expanded(
//                 //     flex: 3,
//                 //     child: Text('chart'),
//                 //   ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            // Header(),
            // SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      MyFiles2(),
                      SizedBox(height: defaultPadding),
                      OrderStatistics(), // Added Order Statistics Section
                      SizedBox(height: defaultPadding),
                      OrderStatistics(), // Added Order Statistics Section
                      SizedBox(height: defaultPadding),
                      UserOverview(), // Added User Overview Section
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) Text('Mobile-specific content'),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // if (!Responsive.isMobile(context))
                  // Expanded(
                  //   flex: 3,
                  //   child: StatisticsCharts(), // Add this for desktop-specific charts
                  // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(
            //   "My Files",
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Welcome Admin${_size.width}',
                  style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(height: defaultPadding),
                Text('Monitor your business analytics and statistics.',
                  style: Theme.of(context).textTheme.bodyMedium,),
              ],
            ),
            // ElevatedButton.icon(
            //   style: TextButton.styleFrom(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 1.5,
            //       vertical:
            //       defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
            //     ),
            //   ),
            //   onPressed: () {},
            //   icon: Icon(Icons.add),
            //   label: Text("Add New"),
            // ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 750 ? 2 : 4,
            childAspectRatio: _size.width < 850 && _size.width > 350 ? 1.5 : 2,
          ),
          tablet: FileInfoCardGridView(
            childAspectRatio: _size.width > 1400 ? 4 : 2,
          ),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.8 : 2,
          ),
        ),
      ],
    );
  }
}
class MyFiles2 extends StatelessWidget {
  const MyFiles2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [

        SizedBox(height: defaultPadding),
        Responsive(
          mobile:Text('mobile'),
          // FileInfoCardGridView(
          //   crossAxisCount: _size.width < 650 ? 2 : 4,
          //   childAspectRatio: _size.width < 650 && _size.width > 350 ? 2 : 1,
          // ),
          tablet: Text('tablet'),
          // FileInfoCardGridView(
          //   childAspectRatio: _size.width > 1400 ? 2 : 1,
          // ),
          desktop: Text('desktop'),

          // FileInfoCardGridView(
          //   childAspectRatio: _size.width < 1400 ? 1.8 : 1,
          // ),
        ),
      ],
    );
  }
}


class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
    );
  }
}


class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Total Sales",
    numOfFiles: 1328,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Total Order",
    numOfFiles: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Total Product",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Total Customer",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: primaryColorWhite,
        border: Border.all(
          color: Colors.black.withOpacity(0.4),  // Black color with 0.4 opacity
          width: 0.4,                           // Border width of 0.4
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              info.title!,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: info.color!.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(Icons.search)
                // SvgPicture.asset(
                //   info.svgSrc!,
                //   colorFilter: ColorFilter.mode(
                //       info.color ?? Colors.black, BlendMode.srcIn),
                // ),
              ),

              // Icon(Icons.more_vert, color: Colors.black12)
            ],
          ),

          ProgressLine(
            color: info.color,
            percentage: info.percentage,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${info.numOfFiles} Files",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
              Text(
                info.totalStorage!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}



class UserOverview extends StatelessWidget {
  const UserOverview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "User Overview",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: DashboardCardGridView2(
            crossAxisCount: _size.width < 650 ? 1 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: DashboardCardGridView2(
            childAspectRatio: _size.width > 1400 ? 4 : 2,
          ),
          desktop: DashboardCardGridView2(
            childAspectRatio: _size.width < 1400 ? 3 : 1,
          ),
        ),
      ],
    );
  }
}


class OrderStatistics extends StatelessWidget {
  const OrderStatistics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   "Order Statistics",
        //   style: Theme.of(context).textTheme.titleLarge,
        // ),
        // SizedBox(height: defaultPadding),
        Responsive(
          mobile: DashboardCardGridView(
            crossAxisCount: _size.width < 650 ? 1 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 4: 1,
          ),
          tablet: DashboardCardGridView(
            childAspectRatio: _size.width > 1400 ? 4 : 2,
            // childAspectRatio: _size.width > 1400 ? 2 : 2,
          ),
          desktop: DashboardCardGridView(
            childAspectRatio: _size.width < 1400 ? 3 : 2,
          ),
        ),
      ],
    );
  }
}



class DashboardCardGridView extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  const DashboardCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4, // Replace with the number of items you want to display
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => DashboardCard(
        title: "Card $index",
        amount: "\$${(index + 1) * 1000}",
        icon: Icons.analytics,
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Text(amount, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}



class DashboardCardGridView2 extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  const DashboardCardGridView2({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: defaultPadding,
      crossAxisSpacing: defaultPadding,
      itemCount: 5, // Replace with the number of items you want to display
      itemBuilder: (context, index) {
        // First item spans a larger area
        if (index == 0) {
          return SizedBox(
            height: (defaultPadding*12.5)+defaultPadding,
            child: DashboardCard2(
              title: "Special Card $index",
              amount: "\$${(index + 1) * 1000}",
              icon: Icons.analytics,
            ),
          );
        }
        // Other items have a standard size
        return SizedBox(
          height: defaultPadding*6.25,
          child: DashboardCard2(
            title: "Card $index",
            amount: "\$${(index + 1) * 1000}",
            icon: Icons.analytics,
          ),
        );
      },
    );
  }
}

class DashboardCard2 extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;

  const DashboardCard2({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32),
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          Text(amount, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}





class SmallCardGridView extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;

  const SmallCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4, // Replace with the number of items you want to display
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => DashboardCard(
        title: "Card $index",
        amount: "\$${(index + 1) * 1000}",
        icon: Icons.analytics,
      ),
    );
  }
}
