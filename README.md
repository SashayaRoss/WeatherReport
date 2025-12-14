# Weather Report App

Fetches weather reports for airport codes and displays them in a list.
**Approximate time spent:** 12 hours

---

## Features

- Display a list of previously loaded airports (initially KPWM & KAUS)
- Add new airports via search
- Tap a cell in the list to show detailed weather for the selected airport
- Toggle between conditions and forecast sections
- Store list of requested airports between app launches
- Cache the last retrieved report for each airport
- Automatic updates
- Cache clearing
- Unit tests to ensure stability

---

### API Endpoint

- Endpoint: `https://qa.foreflight.com/weather/report/<Airport identifier>`
- Required HTTP header: `ff-coding-exercise: 1`

---

## Architecture
I have focused on creating a scalable solution using MVVM architecture with Repositories and clean separation of concerns. Each layer communicates through protocols, allowing implementations to be mocked for testing. Core Data is used to persist the list of requested airports between the app launches and NSCache is used for in memory storage of the latest weather reports.

---

## Notable Design Decisions
- Protocol oriented architecture
- Repositories
- Explicit navigation via routers
- Async/Await networking first with cache fallback strategy
- View state–driven UI updates
- Decorator patterns
- Dependency injection via a centralized container
- Caching with NSCache
- Persistance with Core Data
- ViewControllerFactory and ViewFactory 

---

## Known issues

The endpoint returned a large and deeply nested JSON with many properties which in addition to lack of documentations and unclear semantics for some of the fields made it difficoult to work with. Some of the data is intentionally ignored in my viewModels and views to avoid incorrect assumptions or unnecessary duplications. 
The WeatherReportModel entity is relatively complex and frequently updated. To keep the implementation focused and maintainable, weather reports are cached using NSCache rather than persisted via Core Data. It is noted that cached data is not persisted across app launches.

Current implementation does not account for API rate limiting and there is no pagination implemented.

Due to small time for the assignement test coverage is limited.

Some data such as initial airports or time interval for autorefresh is hardcoded. It would be proper to add a more flexible solution.
