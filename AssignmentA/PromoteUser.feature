Feature: Promote User

    As an administrator, I want to promote users on the platform, so that they can help me manage the platform.
    Background:

        Given the following users exist:
            | username | password  | role           | status |
            | admin    | admin123  | administrator  | normal |
            | admin1   | adminxhas | administrator  | normal |
            | jdoe     | jdoepass  | student seller | normal |
            | jsmith   | jsmithp   | student buyer  | banned |
        And  I am logged in as "admin" with password "admin123"

    Scenario: Administrator promotes a user to admin
        When I promote user "jdoe" to admin
        Then user "jdoe" with password "jdoepass", role "student seller", and status "normal" should have the role "administrator"
        Examples:
            | username | password | role          | status |
            | jdoe     | jdoepass | administrator | normal |

    Scenario: Administrator attempts to promote a banned user to admin
        When I promote user "jsmith" to admin
        Then user "jsmith" should keep the role "student buyer"
        And I shall see the error "cannot promote a banned user to administrator"
        Examples:
            | username | password | role          | status |
            | jsmith   | jsmithp  | student buyer | banned |


    Scenario: Administrator attempts to an admin to administrator
        When I promote user "admin1" to admin
        And I shall see the error "cannot promote a administrator to administrator"



