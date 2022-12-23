/// @author Abdelaziz Salah
/// @date 26/10/2022
/// this file should contains all useful enums that we are going to use.

/// this enum is used to determine the type of the trailing posts
enum TrailingObjects {
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

enum CommentView {
  normal,
  inSearch,
  inSubreddits,
}

/// the history categories presented in reddit
enum HistoyCategory { recent, upvoted, downvoted, hidden }

enum HomeSort { hot, best, top, trending, newPosts, raising, controversial }
// enum HomeSort { best, hot, newPosts, top, raising, controversial }

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
