import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todoey/components/alertdialog/showalertdialog.dart';
import 'package:todoey/components/animation/spin_kit.dart';
import 'package:todoey/components/constants/constants.dart';
import 'package:todoey/components/reusablecomponents/reusable_components.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/drawer_state_management/drawer_cubit.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_cubit.dart';
import 'package:todoey/services/statemanagement/todoey_state_management/todoey_state.dart';
import 'package:todoey/styles/icons/broken_icons.dart';
import 'package:workmanager/workmanager.dart';
import '../../../components/animation/animated_text_kit.dart';
import '../../splash_screen/splash_screen_activity.dart';

class DrawerProfile extends StatelessWidget with DoubleBouncingAnimation {
  const DrawerProfile({Key? key}) : super(key: key);

  Widget divider() => const Divider(
        indent: 30,
        endIndent: 30,
        height: 40,
        thickness: 2,
      );

  Widget bottomSheetWidgets(
          {required VoidCallback onTap,
          required IconData cameraOrGalleryIcon,
          required String cameraOrGalleryTitle}) =>
      InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              cameraOrGalleryIcon,
              color: kAppMainColor,
              size: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              cameraOrGalleryTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DrawerCubit()..getUserInfo(),
      child: BlocConsumer<DrawerCubit, DrawerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DrawerCubit drawerCubit = DrawerCubit.get(context);
          List<IconData> iconData = [
            BrokenIcons.user_1,
            BrokenIcons.message,
            Icons.phone,
          ];

          Widget dataRow({required int index, required List userData}) {
            return Column(
              children: [
                Row(
                  children: [
                    Icon(iconData[index], color: kAppMainColor),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        userData[index].toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                divider(),
              ],
            );
          }

          Future<void> checkCase() async {
            switch (drawerCubit.userInfoModel.signInMethod) {
              case 'Google':
                await drawerCubit.googleAuthSignOut();
                break;
              case 'Facebook':
                await drawerCubit.facebookAuthSignOut();
                break;
              case 'EmailAndPassword':
                await drawerCubit.userAuthSignOut();
                break;
            }
          }

          return Drawer(
            child: (state is DrawerGetDataLoadingState)
                ? ModalProgressHUD(
                    inAsyncCall: true,
                    color: Colors.white,
                    progressIndicator: super.doubleBouncingSpinner(),
                    child: const Center(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        (state is DrawerGetDataErrorState ||
                                firebaseAuth.currentUser!.uid.isEmpty)
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Text(
                                      'Error While Loading Data, Try Again Later...'),
                                ),
                              )
                            : Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      (state is DrawerGetDataLoadingState ||
                                              state is UploadImageLoadingState)
                                          ? CircleAvatar(
                                              radius: 80,
                                              child:
                                                  super.doubleBouncingSpinner(),
                                            )
                                          : (drawerCubit.profilePictureGallery !=
                                                      null ||
                                                  drawerCubit
                                                          .profilePictureCamera !=
                                                      null)
                                              ? CircleAvatar(
                                                  backgroundImage: FileImage(
                                                    (drawerCubit.profilePictureCamera !=
                                                            null)
                                                        ? drawerCubit
                                                            .profilePictureCamera!
                                                        : drawerCubit
                                                            .profilePictureGallery!,
                                                  ),
                                                  radius: 80,
                                                )
                                              : CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    drawerCubit
                                                        .userInfoModel.userImage
                                                        .toString(),
                                                  ),
                                                  radius: 80,
                                                ),
                                      CircleAvatar(
                                        backgroundColor: kAppMainColor,
                                        child: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  const Color(0xff757575),
                                              context: context,
                                              builder: (context) => Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                height: 130,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    bottomSheetWidgets(
                                                      onTap: () {
                                                        drawerCubit
                                                            .pickImageCamera();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      cameraOrGalleryIcon:
                                                          BrokenIcons.camera,
                                                      cameraOrGalleryTitle:
                                                          'Camera',
                                                    ),
                                                    const Divider(
                                                      endIndent: 40,
                                                      indent: 40,
                                                      height: 30,
                                                      color: Colors.black,
                                                    ),
                                                    bottomSheetWidgets(
                                                      onTap: () {
                                                        drawerCubit
                                                            .pickImageGallery();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      cameraOrGalleryIcon: Icons
                                                          .photo_library_outlined,
                                                      cameraOrGalleryTitle:
                                                          'Gallery',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            BrokenIcons.camera,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Column(
                                    children: List.generate(
                                      iconData.length,
                                      (index) =>
                                          dataRow(index: index, userData: [
                                        drawerCubit.userInfoModel.userName,
                                        drawerCubit.userInfoModel.email,
                                        drawerCubit.userInfoModel.phoneNumber,
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(height: 30,),
                                  BlocConsumer<TodoeyCubit, TodoeyStates>(
                                    listener: (ctx, state) {},
                                    builder: (ctx, state) {
                                      return (TodoeyCubit.get(ctx)
                                              .tasksList
                                              .isEmpty)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                singleAnimatedText(
                                                    kAnimatedText:
                                                    'All Tasks Is Done, Congratulations...',
                                                    textStyle: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 12,
                                                      overflow: TextOverflow.visible,
                                                    ),
                                                    colors: [Colors.deepPurple, Colors.cyan],
                                                    totalRepeatCount: 2
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const Icon(Icons.done_all, size: 20, color: Colors.cyan,),
                                              ],
                                            )
                                          : singleAnimatedText(
                                        kAnimatedText:
                                        'You Have (${TodoeyCubit.get(ctx).tasksList.length}) '
                                            'Tasks Not Done Yet... ',
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          overflow: TextOverflow.visible,
                                        ),
                                        colors: [Colors.deepPurple, Colors.cyan],
                                        totalRepeatCount: 2
                                      );
                                    },
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 50,
                        ),
                        rMaterialButton(
                          color: kAppMainColor,
                          splashColor: Colors.blue,
                          horizontal: 30,
                          vertical: 10,
                          onPressed: () {
                            showAlertDialog(
                              context: context,
                              barrierDismissible: true,
                              title: 'Sign out Confirmation.',
                              content: const Text(
                                'Are you sure signing out '
                                '(that\'s will clear all data and caches) ?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => checkCase().whenComplete(
                                    () async => await Workmanager()
                                        .cancelAll()
                                        .whenComplete(
                                          () => Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SplashScreen(),
                                            ),
                                          ),
                                        ),
                                  ),
                                  child: const Text(
                                    'Sign Out',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Sign Out',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
