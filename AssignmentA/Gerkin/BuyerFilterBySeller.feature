Feature: Filter search by seller

    As a buyer in the system, I want to be able to filter search results by seller so that I can buy books from my preferred seller


    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "chen" with password "chen21"

        Given the following books exist in the system:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |

    Scenario: Successful filter
        Given I am on the search result page
        When I filter books by seller with "jdoe"
        And I click the Search button
        Then I shall get a refined version of the previous search
        And I shall see the books by the seller I have specified
            | Title              | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"       | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Biology 101"      | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "The Great Gatsby" | "Fitzgerald" | "Like new" | $15   | "jdoe"          |


    Scenario: No item matches filter (alternate story)
        Given I am on the search result page
        When I filter books by seller with "himel"
        And I make a search request
        Then I shall see the error "Items of the specified seller does not exist"


    Scenario: Error in filtering
        Given I am on the search result page
        When I filter books by seller with " "
        And I make a search request
        Then I shall see the error "Invalid seller username"