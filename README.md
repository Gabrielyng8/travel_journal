# Travel Journal

Travel Journal is a Flutter application that allows users to document their travel experiences. Users can add logs with details such as title, description, location, date range, and photos. The logs are stored in Firebase Realtime Database as base64 strings which then are decode for viewing.

## Features

- Add new travel logs with title, description, location, date range, and photos.
- View details of each travel log.
- Responsive design for different screen sizes.
- Integration with Firebase Realtime Database for data storage.

## Usage

1. **Add a new log:**
   - Click on the "Add Log" button.
   - Fill in the details such as title, location, date range, and description.
   - Add photos by taking a photo or selecting from the gallery.
   - Save the log.

2. **View log details:**
   - Tap on any log entry to view its details.

## Dependencies

- `firebase_core: ^3.12.1`
- `firebase_database: ^11.3.4`
- `flutter`
- `image_picker: ^1.1.2`
- `intl: ^0.20.2`
