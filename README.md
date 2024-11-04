
Project Title : Learning Tracker App
----------------------------------------------------------------------------------------------------

Purpose
----------------------------------------------------------------------------------------------------
The Learning Tracker App is designed to help users monitor and maintain their learning progress
toward a specific goal over a chosen timeframe (week, month, or year). This app encourages
consistent learning by allowing users to set a learning objective and track their progress daily.
Users can “freeze” specific days to preserve their streak without penalty, keeping them motivated
and on track.

UI 
----------------------------------------------------------------------------------------------------
<img width="366" alt="Screenshot 1446-05-02 at 3 18 33 PM" src="https://github.com/user-attachments/assets/2af6fe25-f894-4e15-9ea8-d1ff2d32f6cf">

<img width="366" alt="Screenshot 1446-05-02 at 3 18 46 PM" src="https://github.com/user-attachments/assets/9514d755-38b2-43c7-a62c-090be833ec34">

<img width="364" alt="Screenshot 1446-05-02 at 3 18 59 PM" src="https://github.com/user-attachments/assets/50edb0ae-123d-4108-8258-f962b2879a19">

<img width="364" alt="Screenshot 1446-05-02 at 3 19 11 PM" src="https://github.com/user-attachments/assets/c9e90e5c-0fa0-4e5b-b628-3aa09c982a59">

<img width="367" alt="Screenshot 1446-05-02 at 3 19 20 PM" src="https://github.com/user-attachments/assets/5f4ce8f8-d022-4c44-9c3d-b4bf92d573e1">


The Value of the Learning Tracker App
----------------------------------------------------------------------------------------------------
The Learning Tracker App is a valuable tool for building consistent learning habits by providing a
structured, user-friendly framework for setting and tracking personal goals. It promotes steady
progress through daily tracking, while also offering flexibility with a "freeze days" feature that
allows users to pause without penalty, making it adaptable to real-life schedules. The app fosters
motivation and accountability with a streak count, encouraging users to maintain their learning
momentum, and supports goal re-evaluation, enabling users to reset or extend their goals as they
progress. Ideal for anyone committed to continuous growth, the Learning Tracker App is a practical
companion for developing skills, whether learning a new language, mastering a craft, or enhancing
professional abilities.


User Flow 
-----------------------------------------------------------------------

<img width="1316" alt="Screenshot 1446-05-02 at 3 21 04 PM" src="https://github.com/user-attachments/assets/14d6e556-c26d-4fc8-98aa-a50c73d2e2cd">



Requirements
----------------------------------------------------------------------------------------------------
* iOS 15.0 or later
* Xcode 13.0 or later
* SwiftUI


Functionality 
----------------------------------------------------------------------------------------------------
 Onboarding
- **Goal Setting**: Users begin by entering their learning goal and selecting a duration (week, month, or year) for achieving it. This initial setup customizes the app experience to suit their chosen goal and timeframe.

Logging Daily Progress
- **Learned Today**: Users can log each day as "Learned," increasing their streak count by +1. The current day is highlighted in the calendar with an orange circle.
- **Freeze Day**: Users can "freeze" a day to preserve their streak without learning that day. Each freeze increases the freeze count by +1 and marks the day with a blue circle. Freeze limits are based on the chosen duration: 2 freezes per week, 6 per month, or 60 per year.

 Updating Goal or Duration
- **Update Learning Goal**: Users can revise their learning goal, which is displayed as the title on the main screen.
- **Update Duration**: Adjusts the available freeze days according to the new duration, resetting the streak and frozen day counts.

Streak Management
- The learning streak will reset under specific conditions:
  - After 32 hours pass without logging a day as "Learned."
  - After simultaneously updating both the learning goal and duration.
  - Upon completing the specified duration (unless users choose to keep the streak ongoing).


Usage
----------------------------------------------------------------------------------------------------
* Open the project in Xcode.
* Run the app on a simulator or a physical device.
