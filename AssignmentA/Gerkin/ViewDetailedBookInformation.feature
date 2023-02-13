Feature: View detailed book information

    As a buyer in the system, I want to be able to view detailed information about each textbook to .

    Background:
        Given the following users exist:
            | username | password    | role           |
            | admin    | twofactor   | administrator  |
            | jdoe     | password456 | student seller |
            | himel    | password123 | student seller |
            | jsmith   | password    | student buyer  |

        Given the following books exist in the system:
            | Title                        | Author       |
            | "Calculus 2"                 | "Stewart"    |
            | "Introduction to Python"     | "Van Rossum" |
            | "Biology 101"                | "Johnson"    |
            | "C++ Programming"            | "Stroustrup" |
            | "Introduction to Psychology" | "Atkinson"   |
            | "The Great Gatsby"           | "Fitzgerald" |
            | "Organic Chemistry"          | "Klein"      |
        And I am logged in as "jsmith"


    Scenario: View detailed description of a book successfully
        Given I am on the search result page
        When I make a request to view details of the book "Calculus 2"
        Then I shall see all the details of the book:


            | Title        | Author    | Condition | Price | Seller Username |
            | "Calculus 2" | "Stewart" | "Good"    | $30   | "jdoe"          |

    Scenario: View detailed description of a book not successful
        Given I am on the search result page
        When I make a request to view details of the book "Calculus 2"
        And the book has been sold out in the background to another buyer
        Then I shall see the error "Book is not available in the system anymore"