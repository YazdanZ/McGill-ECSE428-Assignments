Feature: Multi-Language Support

    As a user in the system, I want to be able to select my preferred language so that I can easily navigate the platform comfortably.


    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "jsmith" with password "jsmith"


    Scenario: User selects a preferred language
        When I navigate to the settings page
        And I select a preferred language from the language selection dropdown
        Then the system shall be displayed the selected language and the book choices in the system adapt accordingly

    Scenario: Error when selecting a language
        When I navigate to the settings page
        And I select a language from the language options
        And the system encounters an error while loading the system in the selected language
        Then I shall see an error message indicating that the selected language cannot be loaded at this time
