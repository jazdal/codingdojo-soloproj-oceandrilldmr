# codingdojo-soloproj-oceandrilldmr

## OceanDrill DMR: A simple but useful app for the offshore doctor working in "OceanDrill" oil rig to log or record daily consultations with patients in the ship hospital.
## Version Number: 1.0

## Project Description
- This app enables the offshore doctor on duty to log in details of patient consultations in the ship hospital that was done every working day.
- The app will also enable the doctor to see a general overview of the case numbers and trends of consultations done for each month.
- This app aims to allow the doctor to have more free time by helping to optimize some of the daily administrative tasks that the doctor has to do (manually write entries into the patient logbook, enter each data into a Monthly Report excel sheet, email the report to the medical director, etc...).

## Features and Capabilities
- User registration and login with validations.
- User authentication to protect patient data and prevent unauthorized access to records.
- The app will have two levels of access, Admin level (for the medical director / manager), and User level (for the on-site doctor).
- Admin:
    - Only one user can be Admin.
    - Has a special Admin dashboard in addition to the Patient Records dashboard where Admin can see all user accounts.
    - Can view each user information and can remove (delete) users. The patient records created by the deleted user should still persist in the database once the user has been removed.
    - Can access and delete any patient record.
    - Can create, edit and delete a patient. If a patient is deleted, all case records associated with the patient will be deleted as well.
- User:
    - Has a Patient Records dashboard, but no access to the Admin dashboard.
    - Can create and read / edit case records but will not be able to delete. The user who created the particular record / consultation will be the only one able to edit it, other users will be read-only.
    - Can create and edit patient, but will not be able to delete the patient.

## Technologies Used:
- Backend: Java 17 | Maven v.3.9.3 | Spring Boot v.3.1.2 | Spring Security v.6.1 | MySQL Database

- Frontend: HTML5 + JSP | CSS3 | JavaScript | Bootstrap v.5.3.0 | Chart.js v.4.3.3

- Version Control: Git | GitHub

## Project Developer:
- Jasper Dalawangbayan (Full-Stack Web Developer)