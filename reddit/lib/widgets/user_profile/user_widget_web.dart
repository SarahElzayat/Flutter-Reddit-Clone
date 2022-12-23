// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../components/button.dart';
// import '../../cubit/app_cubit/app_cubit.dart';
// import '../../cubit/user_profile/cubit/user_profile_cubit.dart';
// import '../../networks/constant_end_points.dart';



// import 'package:flutter/scheduler.dart';
// import 'package:intl/intl.dart';

// import 'package:reddit/components/helpers/color_manager.dart';
// import 'package:url_launcher/url_launcher.dart';



// class UserWidgetWeb extends StatefulWidget {
//   UserWidgetWeb({Key? key}) : super(key: key);

//   @override
//   State<UserWidgetWeb> createState() => _UserWidgetWebState();
// }

// class _UserWidgetWebState extends State<UserWidgetWeb> {
//   @override
//   Widget build(BuildContext context) {
//     final mediaquery = MediaQuery.of(context);
//     final navigator = Navigator.of(context);
//     final userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
//     final AppCubit cubit = AppCubit.get(context);
//     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: mediaquery.size.height * 0.4,
//                           width: mediaquery.size.width,
//                           child: Stack(
//                             fit: StackFit.expand,
//                             children: [
//                               (userProfileCubit.userData!.banner == null ||
//                                       userProfileCubit.userData!.banner == '')
//                                   ? Image.asset(
//                                       'assets/images/profile_banner.jpg',
//                                       fit: BoxFit.cover,
//                                     )
//                                   : Image.network(
//                                       '$baseUrl/${userProfileCubit.userData!.banner!}',
//                                       fit: BoxFit.cover,
//                                     ),
//                               Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           horizontal: 22, vertical: 5),
//                                       // padding: EdgeInsets.only(left: 15),
//                                       child: CircleAvatar(
//                                         radius: 40,

//                                         backgroundImage: (userProfileCubit
//                                                         .userData!.picture ==
//                                                     null ||
//                                                 userProfileCubit
//                                                         .userData!.picture ==
//                                                     '')
//                                             ? const AssetImage(
//                                                     'assets/images/Logo.png')
//                                                 as ImageProvider
//                                             : NetworkImage(
//                                                 '$baseUrl/${userProfileCubit.userData!.picture!}',
//                                                 // fit: BoxFit.cover,
//                                               ),
                                        
//                                       ),
//                                     ),
//                                     Stack(
//                                       children: [
//                                         Container(
//                                           width: mediaquery.size.width,
//                                           height: 80,
//                                           decoration: const BoxDecoration(
//                                               gradient: LinearGradient(
//                                             colors: [
//                                               Color.fromARGB(20, 0, 0, 0),
//                                               Color.fromARGB(255, 0, 0, 0),
//                                             ],
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                           )),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 15, top: 10),
//                                           child: (isMyProfile)
//                                               ? Button(
//                                                   text: 'Edit',
//                                                   textFontSize: 20,
//                                                   onPressed: () {
//                                                     navigator.pushNamed(
//                                                         UserProfileEditScreen
//                                                             .routeName);
//                                                     setState(() {});
//                                                     SchedulerBinding.instance
//                                                         .addPostFrameCallback(
//                                                             (_) {
//                                                       getHeight();
//                                                     });
//                                                   },
//                                                   buttonWidth: 100,
//                                                   buttonHeight: 55,
//                                                   splashColor:
//                                                       Colors.transparent,
//                                                   borderColor:
//                                                       ColorManager.white,
//                                                   backgroundColor:
//                                                       Colors.transparent,
//                                                   textFontWeight:
//                                                       FontWeight.bold)
//                                               : BlocBuilder<UserProfileCubit,
//                                                   UserProfileState>(
//                                                   buildWhen:
//                                                       (previous, current) {
//                                                     if (current
//                                                             is FollowOrUnfollowState ||
//                                                         previous
//                                                             is FollowOrUnfollowState) {
//                                                       print(true);
//                                                       return true;
//                                                     } else {
//                                                       return false;
//                                                     }
//                                                   },
//                                                   builder: (context, state) {
//                                                     return Button(
//                                                         text: (userProfileCubit
//                                                                 .userData!
//                                                                 .followed!)
//                                                             ? 'Following'
//                                                             : 'Follow',
//                                                         textFontSize: 20,
//                                                         onPressed: () {
//                                                           if (userProfileCubit
//                                                               .userData!
//                                                               .followed!) {
//                                                             userProfileCubit
//                                                                 .followOrUnfollowUser(
//                                                                     false);
//                                                           } else {
//                                                             userProfileCubit
//                                                                 .followOrUnfollowUser(
//                                                                     true);
//                                                           }
//                                                         },
//                                                         buttonWidth:
//                                                             (userProfileCubit
//                                                                     .userData!
//                                                                     .followed!)
//                                                                 ? 150
//                                                                 : 120,
//                                                         buttonHeight: 55,
//                                                         splashColor:
//                                                             Colors.transparent,
//                                                         borderColor:
//                                                             ColorManager.white,
//                                                         backgroundColor:
//                                                             Colors.transparent,
//                                                         textFontWeight:
//                                                             FontWeight.bold);
//                                                   },
//                                                 ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           key: _con1,
//                           padding: const EdgeInsets.only(bottom: 5),
//                           color: ColorManager.black,
//                           child: Container(
//                             margin: const EdgeInsets.only(left: 15),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               // key: _con1,
//                               children: [
//                                 Text(
//                                   (userProfileCubit.userData!.displayName ==
//                                               null ||
//                                           userProfileCubit
//                                                   .userData!.displayName ==
//                                               '')
//                                       ? userProfileCubit.username!
//                                       : userProfileCubit.userData!.displayName!,
//                                   style: const TextStyle(
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 // MaterialButton(
//                                 //   padding: EdgeInsets.zero,
//                                 //   onPressed: (() {}),
//                                 //   child: Row(
//                                 //       mainAxisSize: MainAxisSize.min,
//                                 //       children: const [
//                                 //         Text('0 followers'),
//                                 //         Icon(Icons.arrow_forward_ios_sharp),
//                                 //       ]),
//                                 // ),
//                                 Text(
//                                     'u/${userProfileCubit.userData!.displayName} *${userProfileCubit.userData!.karma} Karma *${DateFormat('dd/MM/yyyy').format((userProfileCubit.userData!.cakeDate!))}'),
//                                 Text(userProfileCubit.userData!.about ?? ''),
//                                 (isMyProfile)
//                                     ? Wrap(
//                                         spacing: 5,
//                                         children: [
//                                           for (int i = 0;
//                                               i <
//                                                   userProfileCubit.userData!
//                                                       .socialLinks!.length;
//                                               i++)
//                                             Container(
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 2),
//                                               child: InkWell(
//                                                 onTap: () async {
//                                                   Uri url = Uri.parse(
//                                                       userProfileCubit
//                                                           .userData!
//                                                           .socialLinks![i]
//                                                           .link!);
//                                                   await launchUrl(url);
//                                                   // if (await canLaunchUrl(url)) {
//                                                   //   await launchUrl(url);
//                                                   // }
//                                                 },
//                                                 child: Container(
//                                                   padding: const EdgeInsets
//                                                           .symmetric(
//                                                       horizontal: 15,
//                                                       vertical: 5),
//                                                   decoration: BoxDecoration(
//                                                       color: ColorManager.grey,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                                   child: Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: [
//                                                         const Icon(Icons.link),
//                                                         Text(userProfileCubit
//                                                             .userData!
//                                                             .socialLinks![i]
//                                                             .displayText!),
//                                                       ]),
//                                                 ),
//                                               ),
//                                             ),
//                                           if (userProfileCubit.userData!
//                                                   .socialLinks!.length <
//                                               5)
//                                             Container(
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 2),
//                                               child: InkWell(
//                                                 // padding: EdgeInsets.zero,
//                                                 onTap: (() {
//                                                   navigator.pushNamed(
//                                                       UserProfileEditScreen
//                                                           .routeName);
//                                                 }),
//                                                 child: Container(
//                                                   padding: const EdgeInsets
//                                                           .symmetric(
//                                                       horizontal: 15,
//                                                       vertical: 5),
//                                                   decoration: BoxDecoration(
//                                                       color: ColorManager.grey,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                                   child: Row(
//                                                       mainAxisSize:
//                                                           MainAxisSize.min,
//                                                       children: const [
//                                                         Icon(Icons.add),
//                                                         Text('Add Social Link')
//                                                       ]),
//                                                 ),
//                                               ),
//                                             ),
//                                         ],
//                                       )
//                                     : const SizedBox(),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     );
//   }
// }