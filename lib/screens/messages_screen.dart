import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for conversation list
    final conversations = [
      {
        'name': 'Dr. Rohan Patel',
        'message': 'Yes, I received the patient files. Thank you.',
        'time': '10:42 AM',
        'avatar': 'https://placehold.co/100x100/png',
        'unread': 2,
      },
      {
        'name': 'Priya Singh',
        'message': 'Okay, see you at my appointment tomorrow.',
        'time': 'Yesterday',
        'avatar': 'https://placehold.co/100x100/png',
        'unread': 0,
      },
      {
        'name': 'Kolkata Clinic',
        'message': 'Reminder: Staff meeting at 3:00 PM today.',
        'time': 'Yesterday',
        'avatar': 'https://placehold.co/100x100/png',
        'unread': 1,
      },
      {
        'name': 'Advik Gupta',
        'message': 'Thank you for the consultation!',
        'time': 'Oct 26',
        'avatar': 'https://placehold.co/100x100/png',
        'unread': 0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Messages', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6)),
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
            child: ListView.separated(
              itemCount: conversations.length,
              separatorBuilder: (context, index) => Divider(
                indent: 80,
                endIndent: 16,
                height: 1,
                color: Theme.of(context).cardColor,
              ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for new message
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add_comment_outlined, color: Colors.white),
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
    final bool isUnread = unreadCount > 0;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Flexible(
        child: Text(
          name,
          style: TextStyle(
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
      subtitle: Flexible(
        child: Text(
          message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isUnread
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isUnread
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 4),
          if (isUnread)
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