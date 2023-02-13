Feature: Compare offers

    As a seller in the system, I want to be able to compare offer from different buyers so that I can make informed selling decision.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "chen" with password "chen21"

        And the following are my current listings in the system:
            | Title                    | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"             | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python" | "Van Rossum" | "Like new" | $50   | "jdoe"          |
            | "Biology 101"            | "Johnson"    | "New"      | $60   | "awang"         |
            | "Organic Chemistry"      | "Klein"      | "Fair"     | $10   | "awang"         |


    Scenario: Have multiple offers for a book
        When I query for all the offers for "Calculus 2" book
        Then I shall see all the offers for "Calculus 2" from different buyers:
            | Title        | Author    | Price | Buyer Username |
            | "Calculus 2" | "Stewart" | $30   | "jsmith"       |
            | "Calculus 2" | "Stewart" | $25   | "jdoe"         |


    Scenario: Have no offers for a book
        When I query for all the offers for "Calculus 2" book
        And there are no offers made for the book
        Then I shall see a message stating "No offers have been made yet for the listing"

    Scenario: Erro - System policy violated
        When I query for all the offers for "Calculus 2" book
        And the admin has removed the book from the system due to policy violation
        Then I shall see a message stating "Listing has been removed by admin because it does not comply with system policy"


