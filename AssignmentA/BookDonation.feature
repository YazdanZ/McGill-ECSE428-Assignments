Feature: Book Donation

    As a user, I want to be able to donate my used books so that I can help the community.


    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "jdoe" with password "jdoep"


    Scenario: Successfully donate a book
        When I make a query to donate a book
        And I enter the book details, such as title, author, and condition
        Then I shall see a confirmation page indicating the book donation has been received and will be reviewed


    Scenario: Book donation unsuccessful
        When I make a query to donate a book
        And I enter incorrect book details, such as an incorrect title or author
        Then I shall see an error message indicating that the book details are incorrect and to try again.

    Scenario: Book donation error
        When I make a query to donate a book
        And I enter the book details, such as title, author, and condition
        And the system is under maintenance
        Then I shall see an error message indicating that the system is under maintenance and to try again later