Feature: Affiliate Program Management

    As an admin, I want to be able to manage the affiliate program, so that I can reward users for referring new users to the platform.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "admin" with password "admin123"



    Scenario: Successfully view Affiliate Program Details
        When I query to view details of the affiliate program
        Then I shall see the details of the affiliate program, including the commission rate and referral tracking methods


    Scenario: Successfully edit Affiliate Program Details
        When I query to edit details of the affiliate program
        And  I update the commission rate or referral tracking methods
        Then Ii shall see a confirmation message indicating the details have been updated successfully

    Scenario: Add New Affiliate Error
        When I query to add new affiliate 
        And I enter invalid data for the affiliate's name, email, or referral code
        Then I shall see an error message indicating the new affiliate has not been added successfully
