import 'package:flutter/material.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Widgets/contacts_list.dart';
import 'package:whisper/Features/Views/screens/select_contact_screen.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.appBarColor,
          centerTitle: false,
          title: const Text(
            'Whisper',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorColor: AppColors.primaryColor,
            indicatorWeight: 4,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'WHISPERS',
              ),
              Tab(
                text: 'SECRETS',
              ),
              Tab(
                text: 'ECHO',
              ),
            ],
          ),
        ),
        body: const ContactsList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SelectContactScreen.routeName);
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.contact_page_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
