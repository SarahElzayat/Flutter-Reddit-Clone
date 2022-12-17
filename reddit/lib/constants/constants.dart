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

//Create community constants
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
const List<String> generalTitles = [
  'Description',
  'Welcome message',
  'Topics',
  'Community Type',
  'Content tag',
  'Post types',
  'Discovery',
  'Modmail',
  'Mod notifications',
  'Location',
  'Archive Posts',
  'Media in comments'
];

const List<String> contentAndRegulationsTitles = [
  'Post flair',
  'Scheduled posts',
];

const List<String> userManagementTitles = [
  'Moderators',
  'Approved users',
  'Mutes users',
  'Banned users',
  'User flair',
];

final List<String> resourceLinksTitles = [
  'r/ModSupport',
  'r/modhelp',
  'Mod help center',
  'Mod guidelines',
  'Connect Reddit',
];

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

const List<IconData> contentAndRegulationsIcons = [
  Icons.edit_outlined,
  Icons.message_outlined,
];

const List<IconData> userManagementIcons = [
  Icons.shield_outlined,
  Icons.person_outlined,
  Icons.volume_mute_outlined,
  Icons.gavel_outlined,
  Icons.label_outlined
];

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

const List<String> banReasons = [
  'This is spam',
  'This is misinformation',
  'This is abusive or harrasing',
  'Other issues'
];

String? token;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
