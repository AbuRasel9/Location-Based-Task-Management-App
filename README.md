# location_based_task_management_app

# Field Task App


## Features
- **View Assigned Tasks:** See all tasks for the day with title, deadline, and status.
- **Create New Task:** Add tasks manually with title, due time, and map location.
- **Task Details:** View detailed task info with a map preview of the location.
- **Complete Tasks:** Mark tasks as complete only when near the location and parent task (if any) is completed.
- **Task Dependency:** Prevents completing child tasks until parent tasks are done.
- **Offline Support:** View cached tasks offline; syncs automatically when back online.

## Architecture & Design
- **Flutter SDK:** 3.3.5  
- **State Management:** Provider + MVVM  
- **Local Storage:** Hive for offline caching  
- **Remote Storage:** Firebase Firestore for online data  
- **Maps:** FlutterMap (OpenStreetMap) for location previews  
- **Key Design Decisions:**
  - Use MVVM + Provider to separate UI and business logic
  - Offline-first approach with automatic sync
  - Location verification to ensure task completion integrity

## How It Works
1. Agent sees today's tasks in a list.  
2. Tap a task to view details and map preview.  
3. Check-in near the task location (within 100m) to validate presence.  
4. Complete task only if parent dependencies are satisfied.  
5. Tasks can be viewed offline; all updates sync when online.  


