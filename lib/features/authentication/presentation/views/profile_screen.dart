import 'package:eCommerce/features/authentication/application/authentication_repository.dart';
import 'package:eCommerce/reusable_widgets/profile_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eCommerce/features/authentication/application/blocs/auth/authentication_bloc_bloc.dart';
import 'package:eCommerce/features/authentication/data/bloc/database_bloc.dart';
import 'package:eCommerce/utils/constants.dart';

import '../../../../reusable_widgets/Navbar.dart';
import '../../../../reusable_widgets/customAppBar.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/Profile';
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: _TopPortion(),
            ),
            Expanded(
              flex: 3,
              child: _UserDataList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.amberAccent, Color.fromARGB(255, 246, 246, 246)],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?cs=srgb&dl=pexels-simon-robben-614810.jpg&fm=jpg',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserDataList extends StatelessWidget {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
      builder: (context, state) {
        print(state);
        if (state is AuthenticationBlocInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AuthenticationSuccess) {
          if (state.fullInformation.isEmpty) {
            return Center(
              child: Text(Constants.textNoData),
            );
          } else {
            return Builder(
              builder: (context) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Hi,',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // const Spacer(),
                          Text(
                            state.displayName!,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 20, child: Text(state.email!)),
                      // ProfileMenuWidget(
                      //   title: 'alo',
                      //   icon: Icons.abc,
                      //   onPress: () {},
                      // ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text('Username'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    state.displayName!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text('Email'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    (state.email!).toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Orders',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                            // const SizedBox(height: 10),
                            // TextFormField(
                            //   decoration: const InputDecoration(
                            //       label: Text('Email'),
                            //       prefixIcon: Icon(Icons.email)),
                            // ),
                            // const SizedBox(height: 10),
                            // TextFormField(
                            //   decoration: const InputDecoration(
                            //       label: Text('Phone'),
                            //       prefixIcon: Icon(Icons.phone)),
                            // ),
                            // const SizedBox(height: 40),
                            // TextFormField(
                            //   obscureText: true,
                            //   decoration: InputDecoration(
                            //     label: const Text('Password'),
                            //     prefixIcon: const Icon(Icons.fingerprint),
                            //     suffixIcon: IconButton(
                            //         icon:
                            //             const Icon(Icons.remove_red_eye_sharp),
                            //         onPressed: () {}),
                            //   ),
                            // ),
                            // const SizedBox(height: 10),

                            // // -- Form Submit Button
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: ElevatedButton(
                            //     onPressed: () =>
                            //         Get.to(() => const UpdateProfileScreen()),
                            //     style: ElevatedButton.styleFrom(
                            //         backgroundColor: tPrimaryColor,
                            //         side: BorderSide.none,
                            //         shape: const StadiumBorder()),
                            //     child: const Text(tEditProfile,
                            //         style: TextStyle(color: tDarkColor)),
                            //   ),
                            // ),

                            // -- Created Date and Delete Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // const Text.rich(
                                //   TextSpan(
                                //     text: 'Joined',
                                //     style: TextStyle(fontSize: 12),
                                //     children: [
                                //       TextSpan(
                                //           text: 'Joined At',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               fontSize: 12))
                                //     ],
                                //   ),
                                // ),
                                ElevatedButton(
                                  onPressed: () {
                                    _signOut();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                      side: BorderSide.none),
                                  child: const Text('logout'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
