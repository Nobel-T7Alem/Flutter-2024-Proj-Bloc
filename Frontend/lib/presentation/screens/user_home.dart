import 'package:Sebawi/data/services/api_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/calendars.dart';
import '../../data/models/posts.dart';
import 'package:Sebawi/blocs/user_home/user_home_bloc.dart';
import 'package:Sebawi/blocs/user_home/user_home_state.dart';
import 'package:Sebawi/blocs/user_home/user_home_event.dart';

void main() {
  runApp(const UserHomePage());
}

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UserHomeBloc()
        ..add(LoadPostsEvent()),
      child: BlocListener<UserHomeBloc, UserHomeState>(
        listener: (context, state) {
          if (state is UserHomeNavigationSuccess) {
            context.go(state.route);
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                  child: Text('Sebawi',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.green.shade800)),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: IconButton(
                      onPressed: () {
                        BlocProvider.of<UserHomeBloc>(context)
                            .add(NavigateToUserUpdateEvent());
                      },
                      icon: const Icon(Icons.settings),
                      color: Colors.green.shade800,
                      iconSize: 27,
                    ),
                  )
                ],
                bottom: TabBar(
                  tabs: const [
                    Tab(
                      child: Text(
                        "Posts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "My Calendar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  labelColor: Colors.green.shade800,
                  unselectedLabelColor: Colors.grey.shade800,
                  indicatorColor: Colors.green.shade800,
                ),
              ),
              body: TabBarView(
                children: [
                  BlocBuilder<UserHomeBloc, UserHomeState>(
                    builder: (context, state) {
                      if (state is UserHomeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserHomeError) {
                        return const Center(child: Text("Error loading posts"));
                      } else if (state is UserHomeLoaded) {
                        return ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                PostItem(
                                  post: state.posts[index],
                                  isMyPost: true,
                                ),
                                Divider(
                                  height: 10,
                                  thickness: 1,
                                  color: Colors.grey.shade200,
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                  BlocBuilder<UserHomeBloc, UserHomeState>(
                      builder: (context, state) {
                        if (state is CalendarLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is CalendarError) {
                          return const Center(child: Text(
                              "Error loading calendar"));
                        }
                        else if (state is CalendarLoaded) {
                          return ListView.builder(
                            itemCount: state.calendars.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  CalendarItem(
                                    calendar: state.calendars[index],
                                  ),
                                  Divider(
                                    height: 10,
                                    thickness: 1,
                                    color: Colors.grey.shade200,
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        return Container();
                      }
                  ),
                ],
              ),
            ),
          ),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
          ),
        ),
      ),
    );
  }
}


class CalendarItem extends StatelessWidget {
  final Calendar calendar;
  const CalendarItem({required this.calendar, super.key});
//
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.grey.shade200,
//               Colors.grey.shade100
//             ], // You can adjust these colors as needed
//           ),
//         ),
//         child: ListTile(
//           title: Padding(
//             padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//             child: Text(
//               calendar?.date,
//               style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.green.shade800),
//             ),
//           ),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.phone_android,
//                       size: 14, color: Colors.green.shade800),
//                   const Text(
//                     " Contact: ",
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                   ),
//                   Text(post.contact),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.medical_services,
//                       size: 14, color: Colors.green.shade800),
//                   const Center(
//                     child: Text(
//                       " Service Type: ",
//                       style:
//                       TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Text(post.description),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                       Text('Scheduled to ${calendar.date}'),
//                     ],
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
      ),
    );
  }
}


class PostItem extends StatelessWidget {
  final Post post;
  final bool isMyPost;
  const PostItem({required this.post, required this.isMyPost, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade200,
              Colors.grey.shade100
            ], // You can adjust these colors as needed
          ),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              post.name,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.green.shade800),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.phone_android,
                      size: 14, color: Colors.green.shade800),
                  const Text(
                    " Contact: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(post.contact),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.medical_services,
                      size: 14, color: Colors.green.shade800),
                  const Center(
                    child: Text(
                      " Service Type: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(post.description),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isMyPost) ...[
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green.shade800),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                          ),
                        ),
                        child: const Text(
                          'Volunteer Now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: () {
                          // Implement your logic here
                        },
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green.shade800),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                          ),
                        ),
                        child: const Text(
                          'Add To Calendar',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        onPressed: () {
                          context.read<UserHomeBloc>().add(AddToCalendarEvent(
                              DateTime.now().toString().split(" ")[0], post.id.toString()));
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
