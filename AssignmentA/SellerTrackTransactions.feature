Feature: Track past transactions

    As a seller in the system, I want to be able to track my past transactions so that I can know my total earning.

    Background:
        Given the following users exist in the system:
            | username | password    | role           |
            | admin    | twofactor   | administrator  |
            | jdoe     | password456 | student seller |
            | himel    | password123 | student seller |
            | jsmith   | password    | student buyer  |
        And I am logged in the system as "himel"


    Scenario: Successfully tracking past transactions
        Given the following books that are sold by the logged in user:
            | Title                    | Author       | Condition  | Price |
            | "Calculus 2"             | "Stewart"    | "Good"     | $30   |
            | "Introduction to Python" | "Van Rossum" | "Like new" | $50   |
            | "Biology 101"            | "Johnson"    | "Fair"     | $20   |
            | "C++ Programming"        | "Stroustrup" | "New"      | $60   |

        When I make a request to track my past transactions
        Then I shall get a list of all my past transaction to date

        Examples:
            | Title                        | Price | Date              | Type      |
            | "Introduction to Psychology" | $30   | 20-June-2022      | Sold      |
            | "The Great Gatsby"           | $20   | 04-September-2022 | Sold      |
            | "Organic Chemistry"          | $45   | 09-January-2023   | Sold      |
            | "The Great Gatsby"           | $17   | 22-January-2023   | Purchased |


    Scenario: No past transactions
        Given I have no past transactions
        When I make a request to track my past transactions
        Then I shall get a message stating "No past transactions"

    Scenario: Unsuccessful tracking of past transactions - System error
        When I make a request to track my past transactions
        And there is a system error
        Then I shall see an error message "An error has occurred. Please try again later."



