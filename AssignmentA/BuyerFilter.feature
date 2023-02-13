Feature: Filter search

    As a buyer in the system, I want to be able to filter search results so that I can find the book that I am looking for fast.


    Background:
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
        When I specify the author of the book as "Stewart"
        And I make a search request
        Then I shall get a refined version of the previous search
        And I shall see the books of the author I have specified

        Examples:
            | Title        | Author    | Condition | Price | Seller Username |
            | "Calculus 2" | "Stewart" | "Good"    | $30   | "jdoe"          |


    Scenario: No item matches filter (alternate story)
        Given I am on the search result page
        When I specify the author of the book as "J.K. Rowling"
        And I make a search request
        Then I shall see the error "Items of the specified author does not exist"

    Scenario: Error in filtering
        Given I am on the search result page
        When I specify the price of the book to be "-$30"
        And I make a search request
        Then I shall see the error "Invalid price value"