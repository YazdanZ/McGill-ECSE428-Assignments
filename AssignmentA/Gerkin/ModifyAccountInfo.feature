Feature: Modify Account Information

    As a student buyer or seller, I want to be able to modify my account information so that I can keep my profile up-to-date with accurate information..

    Background:
        Given the following users exist:
            | username | password  | role           | status | email            |
            | admin    | admin123  | administrator  | normal | admin@admin.com  |
            | admin1   | adminxhas | administrator  | normal | admin1@admin.com |
            | jdoe     | jdoepass  | student seller | normal | mjdoe@gmail.com  |
            | jsmith   | jsmithp   | student buyer  | normal | jsmoth@yahoo.ca  |

        And  I am logged in as "jsmith" with password "jsmithp"

    Scenario: Update username
        When I update my username to "newjsmith"
        Then I should see a success message
        And my account username should be "newjsmith"
        Then the following users shall exist in the system:
            | username  | password  | role           | status | email            |
            | admin     | admin123  | administrator  | normal | admin@admin.com  |
            | admin1    | adminxhas | administrator  | normal | admin1@admin.com |
            | jdoe      | jdoepass  | student seller | normal | mjdoe@gmail.com  |
            | newjsmith | jsmithp   | student buyer  | normal | jsmoth@yahoo.ca  |

    Scenario: Update password
        When I update my password to "newpassword"
        Then I should see a success message
        And my account password should be "newpassword"
        And the following users shall exist in the system:
            | username | password    | role           | status | email            |
            | admin    | admin123    | administrator  | normal | admin@admin.com  |
            | admin1   | adminxhas   | administrator  | normal | admin1@admin.com |
            | jdoe     | jdoepass    | student seller | normal | mjdoe@gmail.com  |
            | jsmith   | newpassword | student buyer  | normal | jsmoth@yahoo.ca  |

    Scenario: Update email address
        When I update my email to "mynewmail@example.com"
        Then I should see a success message
        And my account email should be "mynewmail@example.com"
        And the following users shall exist in the system:
            | username | password  | role           | status | email            |
            | admin    | admin123  | administrator  | normal | admin@admin.com  |
            | admin1   | adminxhas | administrator  | normal | admin1@admin.com |
            | jdoe     | jdoepass  | student seller | normal | mjdoe@gmail.com  |
            | jsmith   | jsmithp   | student buyer  | normal | jsmoth@yahoo.ca  |

    Scenario: User enters invalid email address
        When I attempt to update my email to "notanemailaddress"
        Then I shall see the error message  "the email address is invalid"
        And the user account information shall not be modified


    Scenario: User enters a weak password
        When I attempt to update my password to "weakpassword"
        Then I shall see the error message  "the password is too weak"
        And the user account information shall not be modified

    Scenario: User attempts to modify their role to admin
        When I attempt to update my role to "administrator"
        But I an not an administrator
        Then I shall see the error message  "Cannot change role to administrator"
        And the user account information shall not be modified

    Scenario: User attempts to modify their role
        And  I am logged in as "admin" with password "admin123"
        When I attempt to update my role to "student seller"
        Then my role email should be "student seller"
        And I shall not have administrative privileges
        And the following entry shall be updated:
            | username | password | role           | status | email           |
            | admin    | admin123 | student seller | normal | admin@admin.com |
