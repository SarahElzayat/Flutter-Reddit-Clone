/// @author Haitham
import 'package:flutter/material.dart';

const bool isMobile = true;
const List<String> labels = ['Image', 'Video', 'Text', 'Link', 'Poll'];
const List<IconData> icons = [
  Icons.image_outlined,
  Icons.play_circle_outline,
  Icons.article_outlined,
  Icons.add_link_outlined,
];
const List<IconData> selectedIcons = [
  Icons.image_rounded,
  Icons.play_circle_fill_rounded,
  Icons.article,
  Icons.add_link_outlined,
];

const List<String> postTypes = [
  'image',
  'video',
  'hybrid',
  'link',
  '',
  'hybrid'
];

/// Create community constants
/// community types when creating a community
const List<String> communityTypes = ['Public', 'Restricted', 'Private'];

/// community types description
const List<String> communityDescription = [
  'Anyone can view, post, and comment to this community',
  'Anyone can view this community, but only approved users can post',
  'Only approved users can view and submit to this community'
];

///icons for the bottom sheet for each community type
const List<IconData> communityTypesIcon = [
  Icons.person_off_outlined,
  Icons.check_circle,
  Icons.lock
];

///regecp used for community name validation
final regexp = RegExp(r'^[A-Za-z0-9_]*$');

//Moderation constants
///Modtools titles for general screens
const List<String> generalTitles = [
  'Description',
  'Welcome message',
  'Topics',
  'Community Type',
  'Post types',
  'Discovery',
  'Mod notifications',
  'Location',
  'Archive Posts',
  'Media in comments'
];

/// Modtools titles for content and regulations screens
const List<String> contentAndRegulationsTitles = [
  'Post flair',
  'Scheduled posts',
];

/// Modtools titles for content and user management screens
const List<String> userManagementTitles = [
  'Moderators',
  'Approved users',
  'Muted users',
  'Banned users',
  'User flair',
];

/// Modtools titles for content and resource links screens
final List<String> resourceLinksTitles = [
  'r/ModSupport',
  'r/modhelp',
  'Mod help center',
  'Mod guidelines',
  'Connect Reddit',
];

///Modtools icons for general screens
const List<IconData> generalIcons = [
  Icons.edit_outlined,
  Icons.message_outlined,
  Icons.label_outlined,
  Icons.lock_outline,
  Icons.star_border_outlined,
  Icons.menu_book_outlined,
  Icons.compass_calibration_outlined,
  Icons.mail_outline,
  Icons.notifications_none_outlined,
  Icons.location_on_outlined,
  Icons.archive_outlined,
  Icons.image_outlined
];

///Modtools icons for content and regulations screens
const List<IconData> contentAndRegulationsIcons = [
  Icons.edit_outlined,
  Icons.message_outlined,
];

///Modtools icons for user management screens
const List<IconData> userManagementIcons = [
  Icons.shield_outlined,
  Icons.person_outlined,
  Icons.volume_mute_outlined,
  Icons.gavel_outlined,
  Icons.label_outlined
];

///Modtools icons for resource links screens
const List<IconData> resourceLinksIcons = [
  Icons.shield,
  Icons.shield,
  Icons.help_outline_rounded,
  Icons.list_alt_outlined,
  Icons.reddit_outlined
];

/// available topics for a subreddit
const List<String> topicsTitles = [
  'Activism',
  'Addiction Support',
  'Animals and Pets',
  'Anime',
  'Art',
  'Beauty and Makeup',
  'Business, Economics, and Finance',
  'Careers',
  'Cars and Motor Vehicles',
  'Celebrity',
  'Crafts and DIY',
  'Crypto',
  'Culture, Race, and Ethnicity',
  'Ethics and Philosophy',
  'Family and Relationships',
  'Fashion',
  'Fitness and Nutrition',
  'Food and Drink',
  'Funny/Humor',
  'Gaming',
  'Gender',
  'History',
  'Hobbies',
  'Home and Garden',
  'Internet Culture and Memes',
  'Law',
  'Learning and Education',
  'MarketPlace and Deals',
  'Mature Themes and Adult Content',
  'Medical and Mental Health',
  'Men\'s Health',
  'Meta Reddit',
  'Military',
  'Movies',
  'Music',
  'Outdoors and Nature',
  'Place',
  'Podcasts and Streamers',
  'Politics',
  'Programming',
  'Reading, Writing, and Literature',
  'Religion and Spirituality',
  'Science',
  'Sexual Orientaion',
  'Sports',
  'Tabletop Games',
  'Technology',
  'Television',
  'Trauma Support',
  'Travel',
  'Women\'s Health',
  'World News',
  'None of these topics'
];

/// possible ban reasons for banning a user
const List<String> banReasons = [
  'This is spam',
  'This is misinformation',
  'This is abusive or harrasing',
  'Other issues'
];

/// sorting posts according to values
const List<String> sortingItems = ['Newest First', 'New', 'Old'];

/// drop down list items to show type
/// could be posts or comments or both
const List<String> listingTypes = ['Posts', 'Comments'];

/// drop down list to show view of list
/// could be card or classic or both
const List<String> view = ['Card', 'Classic'];

/// available languages for a subreddit
const List<String> languages = ['English', 'Arabic', 'French'];

/// available regions for a subreddit
const List<String> regions = ['Egypt', 'Argentina', 'Brazil'];

/// available options a post can be
const List<String> postOptions = ['Any', 'Links Only', 'Text Post Only'];

/// the suggested sorting for posts and comments
const List<String> suggestedSort = ['Top', 'New', 'Best', 'Old'];

String? token;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
