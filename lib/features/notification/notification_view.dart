import 'package:allobaby/API/Requests/Userapi.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: FutureBuilder(
        future: Userapi.getAllNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No notifications available"));
          }

          var notifications = snapshot.data as List<dynamic>;
          
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 10,),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var notification = notifications[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  // leading: const Icon(Icons.notifications, color: Colors.blue),
                  leading: Text((index+1).toString()),
                  title: Text(notification['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(notification['description']),
                  // trailing: Text("ID: ${notification['id']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}