# Developer Handbook

This document serves as the technical guide for the Readory application.

## Architecture

Readory follows a **Clean Architecture** approach with **Riverpod** for state management.

### Layer Structure

1.  **Domain Layer** (`lib/domain`):
    -   **Entities**: Core data objects (e.g., `BookEntity`, `CollectionEntity`).
    -   **Repositories**: Interfaces ensuring data abstraction.
    -   **Use Cases**: Business logic units (e.g., `ScanBooksUseCase`).

2.  **Data Layer** (`lib/data`):
    -   **Models**: Database implementations (Isar) (e.g., `BookModel`, `CollectionModel`).
    -   **Data Sources**:
        -   `LocalDataSource`: Isar DB interactions.
        -   `FileService`: File system operations.
    -   **Repositories**: Implementations of Domain Repositories.

3.  **Presentation Layer** (`lib/presentation`):
    -   **Features**: Grouped by feature (e.g., `library`, `reader`, `details`).
    -   **Providers**: Riverpod notifiers managing state (e.g., `LibraryViewModel`, `ReaderViewModel`).
    -   **Screens & Widgets**: UI components.

## Key Features Implementation

### 1. Folder Management
-   **Goal**: Persist user-selected folders for seeking books.
-   **Implementation**:
    -   `SettingsRepository` saves paths to `SharedPreferences`.
    -   `ScanBooksUseCase` reads these paths to find files recursively.
    -   **UI**: `FolderManagementScreen` allows adding/removing paths.

### 2. Reader V2
-   **Goal**: immersive reading with controls.
-   **Implementation**:
    -   **State**: `ReaderViewModel` (StateNotifier) manages `currentPage`, `bookmarks`, `theme`.
    -   **PDF Engine**: Uses `pdfrx`.
    -   **TOC**: Extracted via `doc.loadOutline()` (or `doc.outline`).
    -   **Progress**: Persisted to `BookEntity` on page changes and disposal.

### 3. Collections
-   **Goal**: Group books.
-   **Implementation**:
    -   **Data**: `CollectionEntity` and `CollectionModel` (Isar).
    -   **UI**: `CollectionsScreen` lists collections. `AddToCollectionDialog` allows tagging books.
    -   **Logic**: `BookEntity` contains a `List<String> collections` (IDs) to link loosely.

### 4. Themes
-   **Implementation**:
    -   `ThemeProvider`: Persists `ThemeMode` (System/Light/Dark) in SharedPrefs.
    -   `AppTheme`: Defines light/dark `ThemeData`.

## Current Known Issues

-   **Build Errors**: Occasionally `pdfrx` outline getter mismatch (being resolved).
-   **EPUB Support**: Currently placeholder in V2 Reader.

## Schema Structure (Isar)

**BookModel**:
-   `id`: auto-increment
-   `title`, `author`, `filePath`: String
-   `progress`: Double (0.0 - 1.0)
-   `readingStatus`: Enum (none, reading, completed, wantToRead)

**CollectionModel**:
-   `name`: String (Unique)
-   `isDefault`: Boolean
