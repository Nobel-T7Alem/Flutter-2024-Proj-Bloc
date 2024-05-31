import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../application/admin_page/admin_page_bloc.dart';
import '../Events/admin_page_event.dart';
import '../States/admin_page_state.dart';
import '../../data/models/accounts.dart';
import '../../data/models/posts.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminPageBloc()..add(const AdminPageInitialEvent()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Admin Page',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  bottom: TabBar(
                    tabs: const [
                      Tab(
                          child: Text(
                        "Manage Accounts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Tab(
                          child: Text(
                        "Manage Posts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ],
                    labelColor: Colors.green.shade800,
                    unselectedLabelColor: Colors.grey.shade800,
                    indicatorColor: Colors.green.shade800,
                  ),
                ),
                body: TabBarView(
                  children: [
                    BlocBuilder<AdminPageBloc, AdminPageState>(
                      builder: (context, state) {
                        BlocProvider.of<AdminPageBloc>(context)
                            .add(LoadAccountsEvent());
                        if (state is AccountsLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is AccountsError) {
                          return Center(child: Text(state.error));
                        } else if (state is AccountsLoaded) {
                          return ListView.builder(
                            itemCount: state.accounts.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  AccountItem(
                                    account: state.accounts[index],
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
                    BlocBuilder<AdminPageBloc, AdminPageState>(
                      builder: (context, state) {
                        BlocProvider.of<AdminPageBloc>(context)
                            .add(LoadPostsEvent());
                        if (state is PostsLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is PostsError) {
                          return Center(child: Text(state.error));
                        } else if (state is PostsLoaded) {
                          return ListView.builder(
                              itemCount: state.posts.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    PostItem(
                                      post: state.posts[index],
                                    ),
                                    Divider(
                                      height: 10,
                                      thickness: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                  ],
                                );
                              });
                        }
                          return Container();
                      },
                    ),
                  ],
                )),
          )),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListTile(
            title: Text(
              post.name,
              style: TextStyle(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Description: "),
                    Text(post.description),
                  ],
                ),
                Row(
                  children: [
                    const Text("Contact: "),
                    Text(post.contact),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.grey.shade900,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: const Text(
                        "Delete Post",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      content: const Text(
                          "Are you sure you want to delete this Post?"),
                      actions: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.redAccent.shade700),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
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
                            backgroundColor:
                                WidgetStateProperty.all(Colors.green.shade800),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
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
                            BlocProvider.of<AdminPageBloc>(context)
                                .add(DeletePostEvent(post));
                            context.pop();
                          },
                        ),
                      ]),
                );
              },
            )));
  }
}

class AccountItem extends StatelessWidget {
  final Account account;
  const AccountItem({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListTile(
            title: Text(
              account.name,
              style: TextStyle(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Username: "),
                    Text(account.username),
                  ],
                ),
                Row(
                  children: [
                    const Text("Email: "),
                    Text(account.email),
                  ],
                ),
                Row(
                  children: [
                    const Text("Role: "),
                    Text(account.role),
                  ],
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Border radius
                      ),
                    ),
                  ),
                  child: const Text(
                    'Change Role',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: () {
                    if (account.role == "agency") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "This Account is already an agency",
                            style: TextStyle(color: Colors.red[800]),
                          ),
                          duration: const Duration(milliseconds: 1000),
                        ),
                      );
                    } else if (account.role == "admin") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "This Account is already an Admin",
                            style: TextStyle(color: Colors.red[800]),
                          ),
                          duration: const Duration(milliseconds: 1000),
                        ),
                      );
                    } else {
                      BlocProvider.of<AdminPageBloc>(context)
                          .add(ChangeRoleEvent(account));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Role Updated",
                              style: TextStyle(color: Colors.red[800])),
                          duration: const Duration(milliseconds: 1000),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.grey.shade900,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: const Text(
                        "Delete Account",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      content: const Text(
                          "Are you sure you want to delete this account?"),
                      actions: [
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                Colors.redAccent.shade700),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
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
                            backgroundColor:
                                WidgetStateProperty.all(Colors.green.shade800),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Border radius
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
                            BlocProvider.of<AdminPageBloc>(context)
                                .add(DeleteAccountEvent(account));
                            context.pop();
                          },
                        ),
                      ]),
                );
              },
            )));
  }
}
