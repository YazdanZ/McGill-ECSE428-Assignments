Feature: List E-books

    As a seller in the system, I want to be able to list e-books as an option with physical copy, so that buyers can choose the one that is most convenient for them.


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


    Scenario: Successful e-book listing with new listing
        When I fill in the book information in order to submit a new book in the system with title "Harry Potter", author "J.K. Rowling", condition "Good", price "$25", available as e-book "Yes"
        And I submit the listing
        And I check all the listing in the system
        Then I shall see my listing with e-book in the system:

            | Title                        | Author         | Condition  | Price | Seller Username | Available as e-book |
            | "Calculus 2"                 | "Stewart"      | "Good"     | $30   | "jdoe"          | Yes                 |
            | "Introduction to Python"     | "Van Rossum"   | "Like new" | $50   | "jsmith"        | No                  |
            | "Biology 101"                | "Johnson"      | "Fair"     | $20   | "jdoe"          | No                  |
            | "C++ Programming"            | "Stroustrup"   | "New"      | $60   | "awang"         | No                  |
            | "Introduction to Psychology" | "Atkinson"     | "Good"     | $25   | "jsmith"        | No                  |
            | "The Great Gatsby"           | "Fitzgerald"   | "Like new" | $15   | "jdoe"          | No                  |
            | "Organic Chemistry"          | "Klein"        | "Fair"     | $10   | "awang"         | No                  |
            | "Harry Potter"               | "J.K. Rowling" | "Good"     | $25   | "chen"          | Yes                 |



    Scenario: Successful e-book listing with existing listing
        When I attempt to update an existing listing in the system with title "Harry Potter", change available as e-book option from "No" to "Yes"
        And I submit the updated listing
        And I check all the listing in the system
        Then I shall see my listing with e-book in the system:

            | Title                        | Author         | Condition  | Price | Seller Username | Available as e-book |
            | "Calculus 2"                 | "Stewart"      | "Good"     | $30   | "jdoe"          | Yes                 |
            | "Introduction to Python"     | "Van Rossum"   | "Like new" | $50   | "jsmith"        | No                  |
            | "Biology 101"                | "Johnson"      | "Fair"     | $20   | "jdoe"          | No                  |
            | "C++ Programming"            | "Stroustrup"   | "New"      | $60   | "awang"         | No                  |
            | "Introduction to Psychology" | "Atkinson"     | "Good"     | $25   | "jsmith"        | No                  |
            | "The Great Gatsby"           | "Fitzgerald"   | "Like new" | $15   | "jdoe"          | No                  |
            | "Organic Chemistry"          | "Klein"        | "Fair"     | $10   | "awang"         | No                  |
            | "Harry Potter"               | "J.K. Rowling" | "Good"     | $25   | "chen"          | Yes                 |


    Scenario: Unsuccessful e-book listing with existing listing
        When I attempt to update an existing listing in the system with title "Harry Potter", change available as e-book option from "No" to "Yes"
        And I submit the updated listing
        And the system is undergoing storage maintenance
        Then I shall see an error message stating "System undergoing storage maintenance - upload failed"
        And the existing listing is not updated:

            | Title                        | Author         | Condition  | Price | Seller Username | Available as e-book |
            | "Calculus 2"                 | "Stewart"      | "Good"     | $30   | "jdoe"          | Yes                 |
            | "Introduction to Python"     | "Van Rossum"   | "Like new" | $50   | "jsmith"        | No                  |
            | "Biology 101"                | "Johnson"      | "Fair"     | $20   | "jdoe"          | No                  |
            | "C++ Programming"            | "Stroustrup"   | "New"      | $60   | "awang"         | No                  |
            | "Introduction to Psychology" | "Atkinson"     | "Good"     | $25   | "jsmith"        | No                  |
            | "The Great Gatsby"           | "Fitzgerald"   | "Like new" | $15   | "jdoe"          | No                  |
            | "Organic Chemistry"          | "Klein"        | "Fair"     | $10   | "awang"         | No                  |
            | "Harry Potter"               | "J.K. Rowling" | "Good"     | $25   | "chen"          | No                  |
