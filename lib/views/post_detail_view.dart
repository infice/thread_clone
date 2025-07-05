import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../widgets/post_card.dart';
import '../utils/constants.dart';

class PostDetailView extends StatefulWidget {
  final Post post;
  const PostDetailView({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _Comment {
  final User user;
  final String text;
  final DateTime createdAt;
  _Comment({required this.user, required this.text, required this.createdAt});
}

class _PostDetailViewState extends State<PostDetailView> {
  final TextEditingController _commentController = TextEditingController();
  final RxList<_Comment> _comments =
      <_Comment>[
        // mock data
        _Comment(
          user: User(
            id: 'user2',
            username: 'elonmusk',
            displayName: 'Elon Musk',
            profileImage: null,
            isVerified: true,
          ),
          text: 'เห็นด้วยครับ!',
          createdAt: DateTime.now().subtract(Duration(minutes: 5)),
        ),
        _Comment(
          user: User(
            id: 'user3',
            username: 'sundarpichai',
            displayName: 'Sundar Pichai',
            profileImage: null,
            isVerified: true,
          ),
          text: 'ขอบคุณสำหรับข้อมูลดีๆ',
          createdAt: DateTime.now().subtract(Duration(minutes: 10)),
        ),
        _Comment(
          user: User(
            id: 'user4',
            username: 'janedoe',
            displayName: 'Jane Doe',
            profileImage: null,
            isVerified: false,
          ),
          text: 'สุดยอดเลย!',
          createdAt: DateTime.now().subtract(Duration(minutes: 15)),
        ),
      ].obs;

  // Mock current user
  final User _currentUser = User(
    id: 'me',
    username: 'meuser',
    displayName: 'Me',
    profileImage: null,
    isVerified: false,
  );

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      _comments.insert(
        0,
        _Comment(user: _currentUser, text: text, createdAt: DateTime.now()),
      );
      _commentController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('โพสต์')),
      body: Column(
        children: [
          PostCard(post: widget.post),
          Expanded(
            child: Obx(
              () =>
                  _comments.isEmpty
                      ? Center(child: Text('ยังไม่มีคอมเมนต์'))
                      : ListView.separated(
                        reverse: true,
                        padding: EdgeInsets.all(AppSizes.padding),
                        itemCount: _comments.length,
                        separatorBuilder: (_, __) => SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final c = _comments[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Avatar + vertical line
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child:
                                        c.user.profileImage == null
                                            ? Text(
                                              c.user.displayName[0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                            : null,
                                  ),
                                  if (index != _comments.length - 1)
                                    Container(
                                      width: 2,
                                      height: 36,
                                      color: Theme.of(context).dividerColor,
                                    ),
                                ],
                              ),
                              SizedBox(width: 12),
                              // Comment content
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    c.user.displayName,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                if (c.user.isVerified) ...[
                                                  SizedBox(width: 4),
                                                  Icon(
                                                    Icons.verified,
                                                    size: 16,
                                                    color: AppColors.verified,
                                                  ),
                                                ],
                                                SizedBox(width: 8),
                                                Flexible(
                                                  child: Text(
                                                    '@${c.user.username}',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Text(c.text),
                                      SizedBox(height: 4),
                                      Text(
                                        _formatTimeAgo(c.createdAt),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'เขียนคอมเมนต์...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _addComment,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes < 1) return 'เมื่อกี้';
    if (diff.inMinutes < 60) return '${diff.inMinutes} นาทีที่แล้ว';
    if (diff.inHours < 24) return '${diff.inHours} ชั่วโมงที่แล้ว';
    return '${diff.inDays} วันที่แล้ว';
  }
}
