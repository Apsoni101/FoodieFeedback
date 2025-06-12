import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localisation/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @addRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Add Restaurant'**
  String get addRestaurant;

  /// No description provided for @addRestaurantButton.
  ///
  /// In en, this message translates to:
  /// **'Add Restaurant'**
  String get addRestaurantButton;

  /// No description provided for @adding.
  ///
  /// In en, this message translates to:
  /// **'➕ Adding...'**
  String get adding;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'🍔 Foodie 🍕 Feedback 😊'**
  String get appName;

  /// No description provided for @appNameWithoutEmoji.
  ///
  /// In en, this message translates to:
  /// **'Foodie Feedback '**
  String get appNameWithoutEmoji;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @createdLabel.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get createdLabel;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @enterContent.
  ///
  /// In en, this message translates to:
  /// **'Enter content'**
  String get enterContent;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter title'**
  String get enterTitle;

  /// No description provided for @googleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in using Google'**
  String get googleSignIn;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, John Doe!'**
  String get greeting;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get languageHindi;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'🔄 Loading...'**
  String get loading;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginToQuicky.
  ///
  /// In en, this message translates to:
  /// **'Login to QUICKY NOTES'**
  String get loginToQuicky;

  /// No description provided for @noRestaurantsFound.
  ///
  /// In en, this message translates to:
  /// **'No restaurants found'**
  String get noRestaurantsFound;

  /// No description provided for @restaurantDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Detail'**
  String get restaurantDetailTitle;

  /// No description provided for @restaurantUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Restaurant updated'**
  String get restaurantUpdatedMessage;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @orSignInUsing.
  ///
  /// In en, this message translates to:
  /// **'or sign in using'**
  String get orSignInUsing;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @registerToQuicky.
  ///
  /// In en, this message translates to:
  /// **'Register to QUICKY NOTES'**
  String get registerToQuicky;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @shortPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get shortPassword;

  /// No description provided for @signupGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign up using Google'**
  String get signupGoogle;

  /// No description provided for @subtitle.
  ///
  /// In en, this message translates to:
  /// **'⚡ Fast. Simple. Organized. 📋'**
  String get subtitle;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Quicky Restaurants'**
  String get welcome;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'💬 Review'**
  String get review;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @review_added_success.
  ///
  /// In en, this message translates to:
  /// **'✅ Review added successfully!'**
  String get review_added_success;

  /// No description provided for @review_error_prefix.
  ///
  /// In en, this message translates to:
  /// **'❌ Error: {message}'**
  String review_error_prefix(Object message);

  /// No description provided for @write_review.
  ///
  /// In en, this message translates to:
  /// **'📝 Write a Review'**
  String get write_review;

  /// No description provided for @your_name.
  ///
  /// In en, this message translates to:
  /// **'🙍‍♂️ Your Name'**
  String get your_name;

  /// No description provided for @enter_name_error.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please enter your name'**
  String get enter_name_error;

  /// No description provided for @rating_label.
  ///
  /// In en, this message translates to:
  /// **'⭐ Rating:'**
  String get rating_label;

  /// No description provided for @your_review.
  ///
  /// In en, this message translates to:
  /// **'💬 Your Review'**
  String get your_review;

  /// No description provided for @enter_review_error.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please enter your review'**
  String get enter_review_error;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'❎ Cancel'**
  String get cancel;

  /// No description provided for @submit_review.
  ///
  /// In en, this message translates to:
  /// **'📤 Submit Review'**
  String get submit_review;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'👤 Profile'**
  String get profileTitle;

  /// No description provided for @userEmail.
  ///
  /// In en, this message translates to:
  /// **'📧 User Email'**
  String get userEmail;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'✏️ Edit Profile'**
  String get editProfile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'🚪 Logout'**
  String get logout;

  /// No description provided for @searchRestaurantsHint.
  ///
  /// In en, this message translates to:
  /// **'Search restaurants...'**
  String get searchRestaurantsHint;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bite 🍽️, rate ⭐, repeat 🔄'**
  String get appSubtitle;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @restaurantName.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Name'**
  String get restaurantName;

  /// No description provided for @errorRestaurantName.
  ///
  /// In en, this message translates to:
  /// **'Please enter restaurant name'**
  String get errorRestaurantName;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @errorDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter description'**
  String get errorDescription;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @errorAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter address'**
  String get errorAddress;

  /// No description provided for @cuisine.
  ///
  /// In en, this message translates to:
  /// **'Cuisine Type'**
  String get cuisine;

  /// No description provided for @errorCuisine.
  ///
  /// In en, this message translates to:
  /// **'Please enter cuisine type'**
  String get errorCuisine;

  /// No description provided for @currentlyOpen.
  ///
  /// In en, this message translates to:
  /// **'Currently Open'**
  String get currentlyOpen;

  /// No description provided for @restaurantImage.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Image'**
  String get restaurantImage;

  /// No description provided for @pickImage.
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pickImage;

  /// No description provided for @changeImage.
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get changeImage;

  /// No description provided for @restaurantAdded.
  ///
  /// In en, this message translates to:
  /// **'Restaurant added successfully!'**
  String get restaurantAdded;

  /// No description provided for @imageRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select an image'**
  String get imageRequired;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @addRestaurantTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Restaurant'**
  String get addRestaurantTitle;

  /// No description provided for @pleaseSelectImage.
  ///
  /// In en, this message translates to:
  /// **'Please select an image'**
  String get pleaseSelectImage;

  /// No description provided for @pleaseSpecifyOpenStatus.
  ///
  /// In en, this message translates to:
  /// **'Please specify if the restaurant is open'**
  String get pleaseSpecifyOpenStatus;

  /// No description provided for @restaurantAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Restaurant added successfully!'**
  String get restaurantAddedSuccess;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorMessage(Object message);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
