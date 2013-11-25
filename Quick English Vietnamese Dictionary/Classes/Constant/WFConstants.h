//
//  WFConstant.h
//  C.R. Flamengo
//
//  Created by Nguyen Duc Chinh on 5/4/13.
//  Copyright (c) 2013 wisekey. All rights reserved.
//

/***
 **  $Date: 2013-03-11 17:28:17 +0700 (Mon, 11 Mar 2013) $
 **  $Revision: 3466 $
 **  $Author: ChinhND $"
 **  $HeadURL: https://chinhnd@scs01.wisekey.ch:8443/svn/wiseid/iphone/trunk/SRC/WISeID/Classes/Common/Constants/WIDConstants.h $
 **  $Id: WIDConstants.h 3466 2013-03-11 10:28:17Z ChinhND $
 ***/

#import "WKConstants.h"

/* Common Constants */
#define kDictEV                         @"dictd_anh-viet.sqlite"
#define kDictEVData                     @"dictd_anh-viet.sdict"
#define kDictVE                         @"dictd_viet-anh.sqlite"
#define kDictVEData                     @"dictd_viet-anh.sdict"
#define kUserData                       @"User.sqlite"

#define strOK                           @"Ok"
#define strEmpty                        @""
#define strYES                          @"Yes"
#define strNO                           @"No"
#define kDatabaseFileName               @"WiseFans_DB.db"
#define kAPP_SCOPE                      @"[app]"
#define strClose                        @"Close"

/* Field Type Constants */
#define strPhotoFieldName               @"Photo"

/*Contact and Support Related Constants*/
#define RECIPIENTS_ADDRESS              @"support@wisekey.ch"

/* Activity Indicator related Constants */
#define strWait                         @"Please wait..."
#define strSaved                        @"Saved!"
#define strLoading                      @"Loading..."
#define strSaving                       @"Saving..."
#define strUpdating                     @"Updating..."
#define strProcessing                   @"Processing..."
#define strAppstoreConnection           @"Contacting Apple Store"
#define strSelectTextSize               @"Select text size"
#define strRelease                      @"Release!"
#define strPullDownToUpdate             @"Pull down to update..."

/* Navigation Bar Related Constants */
#define strSave                         @"Save"
#define strEdit                         @"Edit"
#define strCancel                       @"Cancel"
#define strBack                         @"Back"
#define strDone                         @"Done"
#define strShare                        @"Share"
#define strSend                         @"Send"
#define strPost                         @"Post"
#define strAddSymbol                    @"+"
#define strAdd                          @"Add"
#define strDelete                       @"Delete"
#define strRegistration                 @"Registration"
#define strRELOAD                       @"Reload"

/* Items related constants */
#define strICON                         @"Icon"
#define strITEMNAME                     @"Item Name"
#define strADDFEILDS                    @"Add Fields"
#define strDeleteItem                   @"Are you sure you want to delete this item?"
#define strAlertEmptyField              @"Field name can not be empty"
#define strNAME                         @"Name"
#define strAlertDeleteMsg               @"Are you sure you wish to delete this field ?"
#define strAlertDuplicateField          @"Following field(s) are duplicated"
#define strNewItem                      @"New Item"
#define strEditItem                     @"Edit Item"
#define strFieldType                    @"Field Type"
#define strNote                         @"Note"

/* Target related constants */
#define FirstTimeAlertKey               @"isIntroMessageShown"
#define strWISeFanAppStoreURL           @"http://itunes.apple.com/app/wiseid-password-manager-personal/id384040842?mt=8"
#define strFeedFetch_Fail               @"Problem retrieving content"
#define strVALIDATING_RECEIPT           @"Validating receipt"
#define strRequestingStore              @"Contacting Apple Store"

/* key value used to read receipt response content from App. Store */
#define kReceiptResponse				@"receipt"
#define kReceiptStatus					@"status"

//- Strings

#define strAppSpecificDefaultThemeName	@"Default"
#define strSupport						@"Support"

//- CID
#define strNetworkFailTitle             @"Network Failure!"
#define strDATA_CON_NOT_AVAIL           @"Network connection unavailable."
#define strServerUnavailable            @"Server unavailable."

// Store URL
#define WF_STORE_URL                    @"http://www.flaboutique.com.br"
#define WF_WISFANS_URL                  @"http://www.wisfans.com"

// Localization String Key
// More common
//#define strMillisecond                  @"millisecond"
//#define strSecond                       @"second";
//#define strMinute                       @"minute";
//#define strHour                         @"hour";
//#define strDay                          @"day";
//#define strMonth                        @"month";
//#define strYear                         @"year";
#define strNumberViews                  @"%d views"
#define strFinish                       @"Finish"
#define strLogout                       @"Logout"
#define strConfirmLogOut                @"Are you sure you want to logout?"
#define strOperationFailed              @"Error occurred. Operation failed."
#define strOperationSuccessful          @"Operation successful!"
#define strLike                         @"Like"
#define strUnlike                       @"Unlike"
#define strLikeTriggered                @"Like triggered!"
#define strUnlikeTriggered              @"Unlike triggered!"
#define strWriteComment                 @"Write a comment"
#define strNoComment                    @"No Comments"
#define strError                        @"Error"
#define strRequestTimeout               @"The request's time out!"
#define strCheckoutFlamengo             @"Check out the C.R. Flamengo!"
#define strCheckoutFlamengoLong         @"Check out the C.R. Flamengo for iOS and Android from http://wisfans.com to keep track of your favourite C.R. Flamengo players!"
#define strDeviceNotConfiguredSendingEmail  @"Your device is NOT configured for sending emails"
#define strOnAppLink                    @"%@ on app: http://wisfans.com/"
#define strViewMedia                    @"View the media \"%@\" "
#define strMailSubjectMsg               @"C.R. Flamengo - Super app for C.R. Flamengo fans"
#define strReloginMsg                   @"You have logged in the app on other device, please login again!"
#define strShareViaEmail                @"Share via Email"
#define strShareViaFacebook             @"Share via Facebook"
#define strShareViaTwitter              @"Share via Twitter"
#define strCheckOutFacebookMsg          @"Check out your Facebook to see!"
#define strCheckOutTwitterMsg           @"Check out your Twitter to see!"
#define strShareFooterMsg               @"Hi,\nCheck this out! I'm using the C.R. Flamengo App and it told me which C.R. Flamengo Star I look like! Look at my results attached.\nYou can get C.R. Flamengo from http://wisfans.com to check out who you look like. It also has other nice features like following C.R. Flamengo Players in Social Networks and watching exclusive media content. \nAll the best!"
#define strFindOutCFFlamengoMsg         @"Find out which C.R. Flamengo Stars you resemble"
#define strMailContentMsg_iPhone        @"<HTML> <BODY> <DIV style=\"width:280px;height:160px\"> <FONT COLOR = \"Black\"> Check out this great media \"%@\" on the C.R. Flamengo Official WISfans App for iPhone and Android. Get it now from  </FONT> <FONT COLOR = \"Blue\"> <a href=\"http://wisfans.com/\">http://wisfans.com/</a> </FONT> <FONT COLOR = \"Black\"> and keep track of your favorite C.R. Flamengo players! </FONT> </DIV></BODY> </HTML>"

#define strMailContentMsg_iPad          @"<HTML> <BODY> <DIV style=\"width:700px;height:100px\"> <FONT COLOR = \"Black\"> Check out this great media \"%@\" on the C.R. Flamengo Official WISfans App for iPhone and Android. Get it now from  </FONT> <FONT COLOR = \"Blue\"> <a href=\"http://wisfans.com/\">http://wisfans.com/</a> </FONT> <FONT COLOR = \"Black\"> and keep track of your favorite C.R. Flamengo players! </FONT> </DIV></BODY> </HTML>"

// Home
#define strHome                         @"Home"
#define strSocial                       @"Social"
#define strBiographies                  @"Biographies"
#define strClub                         @"Club"
#define strMatches                      @"Matches"
#define strNews                         @"News"
#define strPhotos                       @"Photos"
#define strVideos                       @"Videos"
#define strStar                         @"Star"
#define strStars                        @"Stars"
#define strWhoDoYouLookLike             @"Who Do You Look Like"
#define strStore                        @"Store"
#define strSearch                       @"Search"
#define strMoreApps                     @"More Apps"
#define strSettings                     @"Settings"

// Home capital
#define strSocialCapital                @"SOCIAL"
#define strBiographiesCapital           @"BIO"
#define strClubCapital                  @"CLUB"
#define strMatchesCapital               @"MATCHES"
#define strNewsCapital                  @"NEWS"
#define strPhotosCapital                @"PHOTOS"
#define strVideosCapital                @"VIDEOS"
#define strStoreCapital                 @"STORE"

// News
#define strFootball                     @"Football"
#define strAll                          @"All"
#define strOtherSports                  @"Other sports"

// Club
#define strTheClub                      @"The Club"
#define strHistory                      @"History"
#define strTitles                       @"Titles"
#define strIdols                        @"Idols"

// Social
#define strFavorites                    @"Favorites"
#define strPlayers                      @"Players"
#define strRealTimeAlert                @"You will receive real time alerts when these players make social posts."
#define strNoPosts                      @"There are no posts"
#define strNoTwitterAndFacebookPage     @"This player does not have a Twitter or Facebook page"

//Biography
#define strCast                         @"Cast"
#define strTechnicalCommittee           @"Technical Committee"

// Videos
#define strNoMediaFound                 @"No media files found"
#define strShareAndCommentVideo @"Share and comment on official videos."
#define strShareAndCommentPhoto @"Share and comment on official photos."


#define strSharedContent                @"Check out this great media \"%@\" on the C.R. Flamengo Official WISfans App for iPhone and Android. Get it now from http://wisfans.com/ and keep track of your favorite C.R. Flamengo players!"

// Photos
#define strAlbum                        @"Album"

//setting

#define kLogoutFacebookMsg              @"Logout Facebook"
#define kLoginFacebookMsg               @"Login Facebook"
#define kLogoutTwitterMsg               @"Logout Twitter"
#define kLoginTwitterMsg                @"Login Twitter"

#define kLogoutNRNMsg                   @"Logout FLAMENGO NRN"
#define kLoginNRNMsg                    @"Login FLAMENGO NRN"

#define kViewDigitalCertificateMsg      @"View digital certificate"
#define kLogoutWISeKey                  @"Logout WISeKey"
#define kLoginCIDMsg                    @"Login WISeKey"
#define kCheckOutYourFacebook           @"Check out your Facebook to see!"
#define kCheckOutYourTwitter            @"Check out your Twitter to see!"
#define kMessage                        @"Hi! I'm using C.R. Flamengo (wisfans.com) to get real time messages, photos and videos from C.R. Flamengo players!"
#define kFullName                       @"Full name"
#define kUserName                       @"Username"
#define kRequired                       @"Required"
#define kPassword                       @"Password"
#define kConfirm                        @"Confirm"
#define kCharacters                     @"8-80 characters"
#define kRequiredRetypePassword         @"Required - Retype password"
#define kPhoneRegis                     @"Phone"
#define kEmailRegis                     @"Email"
#define kAleartRegis                    @"Please fill in the mandatory fields"
#define kPasswordNottMatch              @"Password doesn't match"
#define kYourEmailNotFomat              @"Your email doesn't match the email format"
#define kPasswordLength                 @"Password length must be between 7 and 81 characters"
#define kNameLength                     @"Name length must be less than 81 characters"
#define kPhoneLength                    @"Phone length must less than 21 characters"
#define kPhoneMustBeNumeric             @"Phone must be numeric"
#define kYourWISeKeyAccountCreated      @"Your WISeKey Account has been created."
#define kReceiveEmail                   @"You will receive a verification email in your mailbox, please look for it and verify your email address. After verifying your email address your digital ID will be created. You will be notified after your digital ID has been issued.\n\nYou are now a member and can comment on, like and share official videos and photos."

#define kEmailHasVerified               @"We have detected that your email address has already been verified. Your digital ID will now be created, and you will be notified when it is ready.\n\nYou can now share, like, and comment on FLAMENGO videos and photos."
#define kInternetNotAvailable           @"Internet connection not available"


#define kYourFBEmailIsAlready           @"Your Facebook email is already registered for WiseKey certificates, please login with the email and password!"
#define kObtainingFacebookProfile       @"Obtaining Facebook profile"

#define strNewNews                      @"New news"
#define strAppUpdateAndNews             @"App updates and news"
#define strGameStart                    @"Start of game"
#define strMatches                      @"Matches"
#define kInAppVibrateMsg                @"In-App Vibrate"
#define kResetAllNotificationsMsg       @"Reset all notifications"
#define kInAppSoundsMsg                 @"In-App Sounds"
#define strAlertMsg                     @"Alerts"
#define kSoundsMsg                      @"Sounds"



// Sosie
#define strYourName                    @"Your name"
#define strTapToTakePhoto               @"Tap to take your photo"
#define strTeamPicture                  @"TEAM PICTURES"
#define strStarResult                   @"STAR RESULTS"
#define strLiveVideo                    @"Live Video"
#define strChooseExistingPhoto          @"Choose Existing Photo"
#define strCRFlamengoStar               @"C.R. Flamengo Star"
#define strCRFlamengoStarResults        @"C.R. Flamengo Star results"
#define strFlamengoStarResultsAt        @"Flamengo Star results at"
#define strCRFlamengoHeaderResults      @"C.R. Flamengo Player resemblance results"
#define strRecognizingFace              @"Recognizing face"
#define strDetectingFace                @"Detecting face"
#define strNoFaceAlertMsg               @"The photo does not appear to have a face within it. Please take a photo of yourself!"
#define strTryingToDetectFace           @"Trying to detect your face..."


// digital ID strings
//- sign up screen
#define strSuccessCreatedDigitalID      @"Your WISeKey Digital Certificate has been created."
#define strSigUpScreenTitle             @"Get your C.R. Flamengo digital ID and become a certified fan to comment and like on videos, photos, and more."
#define strEmailPrompt                  @"Enter your email here"
#define strSignUpScreenClue             @"Sign Up using"
#define strContinue                     @"Continue"
#define strCheckEmail                   @"Checking email"
#define strInvalidEmail                 @"Invalid email address"
#define strInvalidEmailOrFieldsAreBlank @"Invalid email address or mandatory fields are blank"
#define strFetchingFacebookProfile      @"Obtaining Facebook profile"
//-sign in screen
#define strSignInScreenTitle            @"Your WISeKey Account exists. Enter your password to logon"
#define strEmail                        @"Email"
#define strLogon                        @"Logon"
#define strPasswordPrompt               @"Enter your password here"
#define strResetPasswordGuid            @"Forgot your password? We'll send you a password reset email"
#define strResetPassword                @"Reset password"
#define strLoggingInState               @"Logging in..."
#define strSendVerificationEmail        @"Sending verification email"
#define strLogin                        @"Login..."
#define strLinkingAccounts              @"Linking accounts"
#define strPleaseEnterPassword          @"Please enter your password"
//-notification screen
#define strNotifScreenTitle             @"Your digital ID is being prepared."
//-registration form
#define strTermAndCondition             @"Terms and Conditions"
#define strTermAndConditionContent      @"I have read and accepted WISeKey's privacy statement and general terms and conditions at\n"
#define strTermConditionLink            @"https://secure.certifyid.com/certifyid/accounts/PrivacyPolicy.htm"
#define strDecline                      @"Decline"
#define strAccept                       @"Accept"
#define strCreateAccount                @"Create account"
#define strIssueTo                      @"Issued to"

// Search
#define strSearchImage                  @"Image"
#define strSearchVideo                  @"Video"
#define strSearchNews                   @"News"
#define strSearchWeb                    @"Web"
#define strSelectType                   @"Select Type"
#define strSearchUnvailable             @"Search service is temporarily unavailable. Please try again later."
#define strSearchNoResults              @"There are no results. Please try again later."

// new login
#define strSapoNRNLogin                 @"If you have NRN account of FLAMENGO you can login here"
#define strTermNCondition               @"When you sign up you are accepting our Terms and Conditions of service"
#define strGuideLogin                   @"Login/Signup using"

// comment out to disable
#define ENABLE_FLURRY
#define ENABLE_TAPJOY

#define ENABLE_SPONSOR_FOG

#define ENABLE_PRIMARY_SPONSOR

//Login failse
#define strLoginFailse                  @"Failed to Login"
