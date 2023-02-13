Feature: Return Policy

    As a buyer in the system, I want to be able to initiate a return if I am not satisfied with my purchase so that I can ensure I am getting the right value for money.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "jdoe" with password "jdoep"


    Scenario: Successful return request
        Given I have initiated a return
        And the return request is valid
        Then the seller approves the return
        Then I shall receive a confirmation message indicating the return has been approved

    Scenario: Unsuccessful return request
        Given I have initiated a return
        And the return request is valid
        Then the seller denies the return request
        Then the user should receive a message indicating the return request has been denied and the reason for denial
