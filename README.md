# **Flutter Lab Assignment 3**
# Feben Getachew  
# UGR/4295/15  
# SECTION-3
A Flutter application that fetches a list of Albums and associated Photos from the [JSONPlaceholder API](https://jsonplaceholder.typicode.com), displays them in a scrollable list, and shows full album details on a separate screen.

---

## **📌 Objective**

Build a Flutter app that:
- Retrieves album and photo data from a remote API.
- Displays the data in a user-friendly, scrollable list.
- Navigates to a detail screen when an album is selected.

---

## **🧩 Functional Requirements**

### **🔗 Data Retrieval & Caching**
- Use `httpClient` to fetch data from:
  - `https://jsonplaceholder.typicode.com/albums`
  -`https://jsonplaceholder.typicode.com/photos`

- Display loading and error states.
- Implement retry mechanism on failure.

### **🖼️ User Interface**

#### **List Screen**
- Shows list of album titles and their respective thumbnails.
- Scrollable list view.
- Proper loading and error indicators.

#### **Detail Screen**
- Displays full details of a selected album.
- Includes title, album ID, and related photos.

### **📍 Navigation**
- Implemented using the `Gorouter` package.

### **❗ Error Handling**
- Handle network errors gracefully with user feedback.
- Retry option for failed API calls.

---

## **🛠️ Technical Requirements**

### **Tech Stack**
- **UI Layer**: Flutter Widgets
- **Networking**: `httpClient`
- **State Management**: BLoC
- **Architecture**: MVVM

---
📁 Project Structure

lib/
├── blocs/             # BLoC files (AlbumBloc, AlbumEvent, AlbumState)
├── models/            # Data models (Album, Photo)
├── routes/            # App router using go_router
├── viewmodels/        # AlbumViewModel for API logic
├── views/             # Screens: AlbumListScreen, AlbumDetailScreen
├── widgets/           # Reusable UI components (e.g., AlbumTile)
main.dart              # Entry point
