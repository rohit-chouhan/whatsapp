## 4.0.0

- **BREAKING CHANGES**:  
  - Renamed `replay` methods to `reply` for consistency.  
  - Added support for `web` platforms.  
- Performance optimized — now runs up to 3x faster than the previous version.  
- Fixed issues with sending contact details.  
- Updated to WhatsApp Business API v23.0 (latest stable release).  
- Added support for Flow messages (interactive flows).  
- Added Catalog and Product message support for e-commerce.  
- Added Typing Indicator.  
- Added User Blocking and Unblocking features.  
- Added Resumable Upload Session
- Improved error handling with dedicated exception classes.  
- Updated dependencies to the latest versions.  
- Enhanced type safety with stronger type annotations.  
- Fixed various bugs and typos across the codebase.  
- Improved documentation and overall code organization.  


## 3.0.0

- Comprehensive documentation is now available at [whatsapp-flutter.github.io](https://whatsapp-flutter.github.io)
- setup method removed, now you can defined using constructor.
- The entire library has been refactored for improved performance and maintainability.
- Updated to support the latest version of the WhatsApp Graph API.
- New methods have been added to enhance functionality.
- Users now have the ability to change the API version.
- Multiple bug fixes have been implemented to ensure a smoother experience.

## 2.0.0

- Action Button Message
- Upload media files
- Delete media files
- Retrieve media url
- Update Whatsapp business profile
- Two Step Verification

## 1.1.1

- New services
  - Embed the Signup Flow
    - Get Id of Shared WABAs
    - Get List of Shared WABAs

## 1.0.9 + 1.1.0

- other bugs fixed
- New services
  - Register a phone number
  - De-register a phone number

## 1.0.8

- Mentioned services removed and implemented to messagesMediaByLink()
  - ~~messagesImageByLink~~
  - ~~messagesVideoByLink~~
- New services
  - Replay by Media
  - Replay by Media (url)

## 1.0.7

- WhatsApp Business API updated from v13.0 to v14.0
- Bugfixed
- Documentation updated
- Preview url fixed
- New services added

  - Send image
  - Send video
  - Reply to message
  - React to message

- readme updated

## 1.0.5

- readme updated

## 1.0.4

- example updated

## 1.0.3

- properties updated
- bug fixed

## 1.0.2

- bug fixed

## 1.0.1

- readme updated

## 1.0.0

- intial release
