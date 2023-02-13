Feature: Upcoming Availabilities of a Sold Out Book

    As a user, I want to be able to check when a sold out book will be available for purchase again.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "jdoe" with password "jdoep"


    Scenario: Successfully check availability of a sold out book
        When I search for a book that is sold out now
        Then I shall see the expected availability date of the book



    Scenario: Book will not be available anymore
        When I search for a book that is sold out now
        Then I shall see a message indicating book will not be available anymore




