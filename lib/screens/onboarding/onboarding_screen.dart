 import 'package:ecom/controller/onboarding_controller.dart';
import 'package:ecom/model/onboarding_model.dart';
import 'package:ecom/screens/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentPage = 0;
//   final PageController _pageController = PageController(initialPage: 0);
//   final List<Widget> _pages = [
//   const  OnboardingPage(
//       imagePath: 'assets/images/onboard_1.png',
//       title: 'Welcome to Our Store',
//       description: 'Find the best deals on the products you love.',
//     ),
//   const  OnboardingPage(
//       imagePath: 'assets/images/onboard_2.png',
//       title: 'Easy Shopping Experience',
//       description: 'Browse through our vast selection with ease.',
//     ),
//    const OnboardingPage(
//       imagePath: 'assets/images/onboard_3.png',
//       title: 'Secure Payments',
//       description: 'Shop with confidence with our secure payment methods.',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     Color primaryColor = Theme.of(context).primaryColor;
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             itemCount: _pages.length,
//             onPageChanged: (int index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return _pages[index];
//             },
//           ),
//           Positioned(
//             bottom: 20.0,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     // Handle skip action
//                     // You can navigate to the next screen or perform any other action here
//                   },
//                   child:const Text(
//                     'Skip',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: _buildPageIndicator(),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_currentPage == _pages.length - 1) {
//                       // Handle action when reaching the last page
//                       // You can navigate to the next screen or perform any other action here
//                     } else {
//                       _pageController.nextPage(
//                         duration:const Duration(milliseconds: 500),
//                         curve: Curves.ease,
//                       );
//                     }
//                   },
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(primaryColor),
//                     foregroundColor:
//                         MaterialStateProperty.all<Color>(Colors.white),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
//                     style: const TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildPageIndicator() {
//     List<Widget> indicators = [];
//     for (int i = 0; i < _pages.length; i++) {
//       indicators.add(
//         i == _currentPage ? _indicator(true) : _indicator(false),
//       );
//     }
//     return indicators;
//   }

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration:const Duration(milliseconds: 150),
//       height: 10.0,
//       width: isActive ? 30.0 : 10.0,
//       margin:const EdgeInsets.symmetric(horizontal: 5.0),
//       decoration: BoxDecoration(
//         color: isActive ? Colors.green : Colors.green[200],
//         borderRadius: BorderRadius.circular(5.0),
//       ),
//     );
//   }
// }

// class OnboardingPage extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final String description;

//   const OnboardingPage({super.key, 
//     required this.imagePath,
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset(
//           imagePath,
//           height: 300.0,
//         ),
//       const  SizedBox(height: 30.0),
//         Text(
//           title,
//           style:const TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       const  SizedBox(height: 10.0),
//         Padding(
//           padding:const EdgeInsets.symmetric(horizontal: 40.0),
//           child: Text(
//             description,
//             textAlign: TextAlign.center,
//             style:const TextStyle(
//               fontSize: 16.0,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  final PageController _pageController = PageController(initialPage: 0);
  final List<OnboardingPageModel> _pages = [
    OnboardingPageModel(
      imagePath: 'assets/images/onboard_1.png',
      title: 'Welcome to Our Store',
      description: 'Find the best deals on the products you love.',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/onboard_2.png',
      title: 'Easy Shopping Experience',
      description: 'Browse through our vast selection with ease.',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/onboard_3.png',
      title: 'Secure Payments',
      description: 'Shop with confidence with our secure payment methods.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              return OnboardingPage(
                imagePath: _pages[index].imagePath,
                title: _pages[index].title,
                description: _pages[index].description,
              );
            },
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle skip action
                    // You can navigate to the next screen or perform any other action here
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(controller.currentPage.value),
                    )),
                ElevatedButton(
                  onPressed: () {
                    if (controller.isLastPage(_pages.length)) {
                      // Handle action when reaching the last page
                      // You can navigate to the next screen or perform any other action here
                    } else {
                      controller.nextPage(_pageController);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    controller.isLastPage(_pages.length) ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator(int currentPage) {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(
        i == currentPage ? _indicator(true) : _indicator(false),
      );
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 10.0,
      width: isActive ? 30.0 : 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.green[200],
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}

