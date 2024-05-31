import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/agency_home/agency_home_bloc.dart';
import '../../blocs/agency_home/agency_home_event.dart';
import '../../blocs/agency_home/agency_home_state.dart';
import '../../data/models/posts.dart';
import '../../data/models/validate_form.dart';

void main() {
  runApp(const AgencyHomePage());
}

class AgencyHomePage extends StatelessWidget {
  const AgencyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgencyHomeBloc()..add(LoadAgencyHomePageEvent()),
      child: BlocListener<AgencyHomeBloc, AgencyHomeState>(
        listener: (context, state) {
          if (state is AgencyHomeNavigationSuccess) {
            context.go(state.route);
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: const [
                    Tab(
                      child: Text(
                        "All Posts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "My Posts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Add Post",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  labelColor: Colors.green.shade800,
                  unselectedLabelColor: Colors.grey.shade800,
                  indicatorColor: Colors.green.shade800,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                  child: Text("Sebawi",
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
                        BlocProvider.of<AgencyHomeBloc>(context)
                            .add(LoadAgencyHomePageEvent());
                      },
                      icon: const Icon(Icons.settings),
                      color: Colors.green.shade800,
                      iconSize: 27,
                    ),
                  )
                ],
              ),
              body: TabBarView(
                children: [
                  BlocBuilder<AgencyHomeBloc, AgencyHomeState>(
                    builder: (context, state) {
                      BlocProvider.of<AgencyHomeBloc>(context)
                          .add(LoadAgencyHomePageEvent());
                      if (state is AgencyHomeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AgencyHomeError) {
                        return Center(child: Text(state.error));
                      } else if (state is AgencyHomeLoaded) {
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
                      return Container(); // Empty container for other states
                    },
                  ),
                  BlocBuilder<AgencyHomeBloc, AgencyHomeState>(
                    builder: (context, state) {
                      BlocProvider.of<AgencyHomeBloc>(context)
                          .add(LoadMyPostsEvent());
                      if (state is MyPostsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MyPostsError) {
                        return Center(child: Text(state.error));
                      } else if (state is MyPostsLoaded) {
                        return ListView.builder(
                          itemCount: state.myPosts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                PostItem(
                                  post: state.myPosts[index],
                                  isMyPost: false,
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
                      return Container(); // Empty container for other states
                    },
                  ),
                  BlocBuilder<AgencyHomeBloc, AgencyHomeState>(
                      builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: state.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              controller:
                                  BlocProvider.of<AgencyHomeBloc>(context)
                                      .nameController,
                              labelText: "Agency Name",
                              onChange: (val) {
                                BlocProvider.of<AgencyHomeBloc>(context).add(
                                    AgencyNameChangedEvent(
                                        name: ValidateForm(value: val!)));
                              },
                              validator: (val) {
                                return state.name.error;
                              },
                            ),
                            CustomTextFormField(
                              labelText: "Description",
                              controller:
                                  BlocProvider.of<AgencyHomeBloc>(context)
                                      .descriptionController,
                              onChange: (val) {
                                BlocProvider.of<AgencyHomeBloc>(context).add(
                                    DescriptionChangedEvent(
                                        description:
                                            ValidateForm(value: val!)));
                              },
                              validator: (val) {
                                return state.description.error;
                              },
                            ),
                            CustomTextFormField(
                              labelText: "Contact",
                              controller:
                                  BlocProvider.of<AgencyHomeBloc>(context)
                                      .contactController,
                              onChange: (val) {
                                BlocProvider.of<AgencyHomeBloc>(context).add(
                                    ContactChangedEvent(
                                        contact: ValidateForm(value: val!)));
                              },
                              validator: (val) {
                                return state.contact.error;
                              },
                            ),
                            if (context.read<AgencyHomeBloc>().state.apiError !=
                                null)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Center(
                                  child: Text(
                                    context
                                        .read<AgencyHomeBloc>()
                                        .state
                                        .apiError!,
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            if (context.read<AgencyHomeBloc>().state.apiMessage !=
                                null)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Center(
                                  child: Text(
                                    context
                                        .read<AgencyHomeBloc>()
                                        .state
                                        .apiMessage!,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            CustomButton(
                              buttonText: 'Post',
                              buttonColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              buttonTextColor:
                                  const Color.fromARGB(255, 33, 94, 35),
                              buttonAction: () async {
                                BlocProvider.of<AgencyHomeBloc>(context)
                                    .add(const AddPostEvent());
                                // Implement post creation logic here
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  })
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

// Widget for displaying a single post
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
              Colors.grey.shade100,
            ],
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
                    if (!isMyPost) ...[
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey.shade900,
                        ),
                        onPressed: () {
                          openDialog(context, post);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade700,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text(
                                'Delete Post',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              content: const Text(
                                  'Are you sure you want to delete this post?'),
                              actions: [
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.redAccent.shade700),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // Border radius
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    context.pop();
                                  },
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green.shade800),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20), // Border radius
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<AgencyHomeBloc>(context)
                                        .add(DeletePostEvent(post));
                                    context.pop();
                                  },
                                ),
                              ],
                            ),
                          );
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

  Future openDialog(BuildContext context, Post post) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Edit Post',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          content: const Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Agency Name',
                  hintText: 'Enter the name of the agency',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contact Info',
                  hintText: 'Enter the contact information',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Service Type',
                  hintText: 'Enter the type of service',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.redAccent.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                ),
              ),
              child: const Text(
                'Discard',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.green.shade800),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Border radius
                  ),
                ),
              ),
              child: const Text(
                'Save Changes',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      );
}
