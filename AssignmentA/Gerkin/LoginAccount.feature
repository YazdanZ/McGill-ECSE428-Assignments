Feature: Login

    As a registered student buyer or seller, I want to log in to my account so that I can access my account details and make or receive purchases.

    Background:
        Given the following users exist:
            | username | password  | role           | status | email            |
            | admin    | admin123  | administrator  | normal | admin@admin.com  |
            | admin1   | adminxhas | administrator  | normal | admin1@admin.com |
            | jdoe     | jdoepass  | student seller | normal | mjdoe@gmail.com  |
            | jsmith   | jsmithp   | student buyer  | normal | jsmoth@yahoo.ca  |

    Scenario: Successful login with email and password
        When I enter my valid login credentials with email "jsmoth@yahoo.ca" and password "jsmithp"
        And attempt to login
        Then I should be redirected to the home page

    Scenario: Successful login with username and password
        When I enter my valid login credentials with username "jsmith" and password "jsmithp"
        And attempt to login
        Then I should be redirected to the home page


    Scenario: Invalid username or email credentials
        When I enter my invalid username or email credentials:
            | username | email      | password |
            | me       | em@ada.com | pasda    |
        And attempt to login
        Then I should see the error message "the username or email is not registered. Signup"

    Scenario: Invalid password
        When I enter the wrong password:
            | username | email           | password  |
            | jsmith   | jsmoth@yahoo.ca | wrongpass |
        But the username or email is corrrect
        And attempt to login
        Then I should see the error message "Password is incorrect. Forgot password?"


    Scenario: Locked out due to too many attempts
        Given I have attempted to log in with incorrect credentials too many times (5 times)
        When I try to log in again
        Then I should see a message  "Your account is locked. Contact administration"
        And my account status shall be updated:
            | username | password | role          | status                               | email           |
            | jsmith   | jsmithp  | student buyer | locked due to invalid login attempts | jsmoth@yahoo.ca |

    Scenario: Forgotten password
        Given I have forgotten my password
        When I attempt to login with valid username "jsmith" or email "jsmoth@yahoo.ca"
        And I click the "forgot password" link
        And enter my email address
        Then I should receive an email with instructions on resetting my password

    Scenario: User is banned
        Given I have an account on the platform
        But my account status is banned:
            | username | password | role          | status | email           |
            | jsmith   | jsmithp  | student buyer | banned | jsmoth@yahoo.ca |
        When I try to log in
        Then I should see the message "You're banned from our platform. Check our community guidelines."
        And I shall not be redirected to the home page