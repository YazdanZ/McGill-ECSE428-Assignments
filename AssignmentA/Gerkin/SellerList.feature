Feature: List textbook for sale

    As a seller in the system, I want to be able to list books for sale, specifying the title, author, condition, and price so that I can make profit.

    Background:
        Given the following users exist:
            | username | password    | role           |
            | admin    | twofactor   | administrator  |
            | jdoe     | password456 | student seller |
            | himel    | password123 | student seller |
            | jsmith   | password    | student buyer  |

        Given the following books exist in the system:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |
        And I am logged in the system as "himel"

    Scenario: Successful listing
        When I fill in the book information in order to submit it with title "Harry Potter", author "J.K. Rowling", condition "Good", price "$25"
        And I submit the listing
        And I check all the listing in the system
        Then I shall see my listing in the system

        Examples:
            | Title                        | Author         | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"      | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python"     | "Van Rossum"   | "Like new" | $50   | "jsmith"        |
            | "Biology 101"                | "Johnson"      | "Fair"     | $20   | "jdoe"          |
            | "C++ Programming"            | "Stroustrup"   | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"     | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald"   | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"        | "Fair"     | $10   | "awang"         |
            | "Harry Potter"               | "J.K. Rowling" | "Good"     | $25   | "himel"         |

    Scenario: Unsuccessful listing
        When I fill in the book information in order to submit it with title "Harry Potter", author "", condition "Good", price "$25"
        And I submit the listing
        Then I shall see the error "Author cannot be empty"
        And the listing in the system shall not be updated


    Scenario: Error in listing
        When I fill in the book information in order to submit it with title "Harry Potter", author "J.K. Rowling", condition "Good", price "-$25"
        And I submit the listing
        Then I shall see the error "Invalid price value"
        And the listing in the system shall not be updated



