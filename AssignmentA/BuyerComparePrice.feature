Feature: Compare book prices

    As a buyer in the system, I want to be able to compare a book from different sellers so that I can make informed purchasing decision.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | chen     | chen21   | student seller |

        And  the following listings exist:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jdoe"          |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Biology 101"                | "Johnson"    | "New"      | $60   | "awang"         |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |
        Given I am logged in as a user "jsmith" with password "jsmithp"


    Scenario: Find multiple variants of a book
        When I search for the textbook "Biology 101" in the system
        Then I shall see all the listings with title "Biology 101" from all sellers:
            | Title         | Author    | Condition | Price | Seller Username |
            | "Biology 101" | "Johnson" | "Fair"    | $20   | "jdoe"          |
            | "Biology 101" | "Johnson" | "New"     | $60   | "awang"         |


    Scenario: No book found
        When I search for the textbook "Physics 101" in the system
        Then I shall see a message stating "No book found"

    Scenario: System under maintenance
        When I search for the textbook "Python for dummies" in the system
        And the system is under maintenance
        Then I shall see a message stating "System is under maintenance currently - please try again later"


