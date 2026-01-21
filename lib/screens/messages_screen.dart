import 'package:flutter/material.dart';
import 'package:edochub_b2b/utils/color_extensions.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for conversation list
    final conversations = [
      {
        'name': 'Dr. Evelyn Reed',
        'message': 'Yes, I received the patient files. Thank you.',
        'time': '10:42 AM',
        'avatar': 'https://placehold.co/100x100/png',
        'unread': 2,
      },
      {
        'name': 'John Smith',
        'message': 'Okay, see you at my appointment tomorrow.',
        'time': 'Yesterday',
        'avatar': 'https://placehold.co/100x100/png',
        'unread': 0,
      },
      {
        'name': 'Central Clinic',
        'message': 'Reminder: Staff meeting at 3:00 PM today.',
        'time': 'Yesterday',
        'avatar': 'https://placehold.co/100x100/png',
        'unread': 1,
      },
       {
        'name': 'Maria Garcia',
        'message': 'Thank you for the consultation!',
        'time': 'Oct 26',
        'avatar': 'https://placehold.co/100x100/png',
        'unread': 0,
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacitySafe(0.6)),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Conversation List
          Expanded(
            child: ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ConversationTile(
                  name: conversation['name'] as String,
                  message: conversation['message'] as String,
                  time: conversation['time'] as String,
                  avatarUrl: conversation['avatar'] as String,
                  unreadCount: conversation['unread'] as int,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int unreadCount;

  const ConversationTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          if (unreadCount > 0)
            CircleAvatar(
              radius: 10,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        // Navigate to chat screen
      },
    );
  }
}