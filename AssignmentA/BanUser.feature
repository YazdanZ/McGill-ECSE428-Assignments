Feature: Ban User

    As an administrator, I want to view and ban users on the platform, so that I can ensure that they don't violate our community guidelines.

    Background:

        Given the following users exist:
            | username | password  | role           | status |
            | admin    | admin123  | administrator  | normal |
            | admin1   | adminxhas | administrator  | normal |
            | jdoe     | jdoepass  | student seller | normal |
            | jsmith   | jsmithp   | student buyer  | normal |
        And  I am logged in as "admin" with password "admin123"

    Scenario: Administrator views all users
        When I go to the "Users" page
        Then I should see all the users
        And each user should have a username, password, and role
        And the number of available users shall be "4"
        And the following listings shall exist in the system:
            | username | password  | role           | status |
            | admin    | admin123  | administrator  | normal |
            | admin1   | adminxhas | administrator  | normal |
            | jdoe     | jdoepass  | student seller | banned |
            | jsmith   | jsmithp   | student buyer  | normal |

    Scenario: Administrator bans a user
        When I attempt to ban the user with username "jdoe" with password "jdoepass" and role "student seller" and status "normal"
        Then the user with username "jdoe" status shall be modified to "banned"
        And "jdoe" shall not be able to log in or use the platform.
        And the following entry is updated:
            | username | password | role           | status |
            | jdoe     | jdoepass | student seller | banned |


    Scenario: Administrator attempts to ban a banned user
        Given the following users exist:
            | username | password | role           | status |
            | jdoe     | jdoepass | student seller | banned |

        When I attempt to ban the user with username "jdoe" with password "jdoepass" and role "student seller" and status "normal"
        Then no change shall be made
        And I shall receive the error "Cannot ban a user who's already banned"
        And the following entry shall remain the same:
            | username | password | role           | status |
            | jdoe     | jdoepass | student seller | banned |

    Scenario: Administrator attempts to ban another administrator
        When I attempt to ban the user with username "admin1" witj password "adminxhas" and role "administrator" and status "normal"
        Then the user with username "admin1" shall not be modified to "banned"
        And I shall receive the error "Cannot ban an administrator"
        And the following entry shall not be updated:
            | username | password  | role          | status |
            | admin1   | adminxhas | administrator | normal |

    Scenario: Administrator attempts to ban themselves
        When I attempt to ban the user with username "admin"
        Then the user with username "admin" shall not be modified to "banned"
        And I shall receive the error "Cannot ban yourself"
        And the following entry shall not be updated:
            | username | password | role          | status |
            | admin    | admin123 | administrator | normal |
