// class LandingPage2 extends StatefulWidget {
//   LandingPage2({Key key}) : super(key: key);

//   @override
//   _LandingPageState2 createState() => _LandingPageState2();
// }

// class _LandingPageState2 extends State<LandingPage2>
//     with SingleTickerProviderStateMixin {
//   Widget page;
//   AnimationController animationController;
//   Animation<double> animation;

//   @override
//   void initState() {
//     loadPage();
//     animationController =
//         AnimationController(duration: Duration(seconds: 2), vsync: this);
//     animationController.forward();

//     animation = Tween<double>(begin: 0, end: 2).animate(animationController)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           animationController.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           animationController.forward();
//         }
//       });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }

//   void loadHomePage() {
//     Provider.of<MyGroupsProvider>(context).refreshMyGroups();
//     Provider.of<GroupRecomendationsProvider>(context).refreshMyRecomendations();
//     Provider.of<MyEventsProvider>(context).fetchEvents();
//   }

//   loadPage() {
//     getStoredUser().then((a) {
//       String token = Singleton().jwtToken;

//       setState(() {
//         page = token != null ? toHome() : LoginPage();
//       });
//     });
//   }

//   Widget toHome() {
//     loadHomePage();

//     return HomePage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: themeColor,
//       child: page ??
//           // Center(
//           //   child: Transform.rotate(
//           //     angle: animation.value,
//           //     child: FlutterLogo(),
//           //   )
//           // ),
//           Center(
//               child: RotationTransition(
//             turns: animation,
//             child: Image.asset(
//               'assets/icon.png',
//             ),
//           )),
//     );
//   }
// }
