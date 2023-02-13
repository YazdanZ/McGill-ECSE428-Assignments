Feature: Social media sharing

    As a user in the system, I want to be able to share the textbook exchange platform with my friends so that I can help them get a good resource of books.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "chen" with password "chen21"

    Scenario: Successfully share on Social Media platform
        When I make a query to share the exchange system
        And I select a social media platform to share on
        Then I shall be redirected to the selected social media platform to share the platform with my friends

    Scenario: Successfully share on Social Media platform from book description page
        Given I am checking the description of a book
        When I make a query to share the book
        And I select a social media platform to share on
        Then I shall be redirected to the selected social media platform to share the platform with the book with my friends

    Scenario: Unsuccessful sharing
        When I make a query to share the exchange system
        And the social media platform is unavailable to reach on server side
        Then I shall see an error message indicating the sharing has failed




