class Message{
  String content;
  String role;
  

  Message(this.content, this.role);

  @override
  String toString() {
    return 'MessageEvent{content: $content, role: $role}';
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'role': role,
    };
  }
}