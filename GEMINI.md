# WhatsApp Flutter Package

## Core Guidelines
- Make sure to use always stable version api.

## Project Architecture & Structure
This project is structured into three main directories under `lib/src/`:
- **`services/`**: Contains domain-specific services (e.g., `AccountService`, `ContactService`, `TemplateService`, `BusinessService`, `FlowService`, etc.). When adding new API interactions, implement them in the relevant service or create a new one extending `BaseService`.
- **`model/`**: Contains data models representing request/response payloads and WhatsApp entities.
- **`utils/`**: Contains utility classes including:
  - API Request and Response handling logic (`request.dart`, `response.dart`).
  - Standardized response models (e.g., `WhatsAppResponse`, `WhatsAppBaseResponse`, `WhatsAppSuccessResponse`, `WhatsAppMediaUploadResponse`) located in `utils/response/`.
  - Custom exceptions (e.g., `NetworkException`, `JsonFormatException`, `WhatsAppException`, `WhatsAppAuthenticationException`) located in `utils/exception.dart`.

**When making architectural changes or adding features:**
1. Ensure API calls are executed via the appropriate service class.
2. Parse API responses using the existing standardized response models, or add new ones following the pattern in `utils/response/`.
3. Handle network and parsing errors using the custom exception classes.

## Test Cases
If any changes done or new feature or new method added or method signature change in the code, make sure to update the test cases and run them in the `test/real_whatsapp_test.dart` file.

## Changes Log
Make sure to update the `CHANGELOG.md` file when any changes are done.