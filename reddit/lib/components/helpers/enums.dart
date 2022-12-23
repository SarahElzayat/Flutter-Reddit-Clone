/// @author Abdelaziz Salah
/// @date 26/10/2022
/// this file should contains all useful enums that we are going to use.

/// this enum is used to determine the type of the trailing posts
enum TrailingObjects {
  // TODO: here we should add a button
  switchButton,
  dropBox,
  tailingIcon,
}

/// this enum is used to determine the type of the community
enum CommunityTypes {
  public,
  restricted,
  private,
}

/// this enum is used to determine the type of the sort
enum SortType {
  bestType,
  topType,
  newType,
  hotType,
}

/// controls the view of the post in the posts list
enum PostView {
  classic,
  card,
  withCommentsInSearch,
}

/// controls the view of the comment in the comments list
enum CommentView {
  normal,
  inSearch,
  inSubreddits,
}

/// controls the view of the history in the history list
enum HistoyCategory { recent, upvoted, downvoted, hidden }

/// used to determine the type of the sort in Home screen
enum HomeSort { hot, best, top, trending, newPosts, raising, controversial }

/// used to indicate which users to get
enum UserManagement {
  banned,
  approved,
  muted,
  moderator,
}

enum ModToolsSelectedItem {
  spam,
  unmoderated,
  edited,
  banned,
  muted,
  approved,
  moderator,
  userFlair,
  postFlair,
  scheduledPost,
  communitySettings,
  postsAndComments,
  notifications,
  trafficStats
}

enum ModToolsGroup {
  queues,
  userManagement,
  flair,
  content,
  settings,
  communityActivity
}

/// used to enumerate the types of the moderation options
enum ModOPtions { spoiler, nsfw, lock, unsticky, remove, spam, approve }
