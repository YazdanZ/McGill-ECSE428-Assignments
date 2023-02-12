Feature: User Account Creation

    As a user, I want to be able to signup to the platform so that I can buy, sell, and trade textbooks.

    Background:
        Given the following users exist:
            | username | password  | role           | status | email            |
            | admin    | admin123  | administrator  | normal | admin@admin.com  |
            | admin1   | adminxhas | administrator  | normal | admin1@admin.com |
            | jdoe     | jdoepass  | student seller | normal | mjdoe@gmail.com  |
            | jsmith   | jsmithp   | student buyer  | normal | jsmoth@yahoo.ca  |


    Scenario Outline: Successful account creation
        When the user fills in the registration form given the role "student seller" with the valid credentials username "jane23", password "hellokitty12", email "jane@mcgill.ca"
        Then the user should receive a confirmation message "Account created"
        And the user with username "jane23", password "hellokitty12", email "jane@mcgill.ca" shall exist in the system
        And the user shall have status "normal"
        And the number of users in the system shall be "5"
        Then the following users shall exist in the system:
            | username | password     | role           | status | email            |
            | admin    | admin123     | administrator  | normal | admin@admin.com  |
            | admin1   | adminxhas    | administrator  | normal | admin1@admin.com |
            | jdoe     | jdoepass     | student seller | normal | mjdoe@gmail.com  |
            | jsmith   | jsmithp      | student buyer  | normal | jsmoth@yahoo.ca  |
            | jane23   | hellokitty12 | student seller | normal | jane@mcgill.ca   |

    Scenario Outline: Invalid email address format
        When the user fills in the registration form with an invalid email format "jane@mcgill.helllooooo"
        Then the user should receive an error message  "invalid email format"
        And the user with email "jane@mcgill.helllooooo" shall not be added to the system

    Scenario Outline: Password too weak
        When the attempts to register to the platform with a weak "thisisweak"
        Then the user should receive an error message "Selected password is weak"
        And The user shall not be added to the system
        And the number of users in the system shall stay at "4"

    Scenario Outline: Username already exists
        Given the username "jsmith" already exists in the database
        When the user fills in the registration form given the role "student seller" with the valid credentials username "jsmith", password "hellokitty12", email "jsmith@mcgill.ca"
        But the user fills in the registration form with the existing username "jsmith"
        Then the user should receive the error message "username already exists"
        And The user shall not be added to the system
        And the number of users in the system shall stay at "4"
