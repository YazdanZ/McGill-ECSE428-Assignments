Feature: Manage Listing

    As an administrator, I want to view and manage all listings on the platform, so that I can ensure that they meet our community guidelines.

    Background:


        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |

        And  the following listings exist:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |
        And  I am logged in as "admin" with password "admin123"



    Scenario Outline: Administrator views all listings
        When I go to the "Listings" page
        Then I should see all the listings
        And the number of available listings shall be "7"
        And each listing should have a title, author, condition, price, and seller username
        Examples:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |


    Scenario Outline: Administrator deletes a listing
        When I attempt to delete the listing with title "Calculus 2"
        Then I see a success message
        And the listing with title "Calculus 2", Author "Stewart", Condition "Good", Price "$30", and seller username "jdoe" should no longer be visible
        And the number of available listings shall be "6"
        And the user with role "student seller" with seller Username "jdoe" is notified of the deletion
        Examples:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |

    Scenario Outline: Administrator edits a listing
        When I attempt to edit the listing with title "Calculus 2"
        And modify the Condition to "Fair"
        Then the listing with title "Calculus 2" should be updated to have Condition "Fair"
        And the user with role "student seller" with seller Username "jdoe" is notified of the change
        Examples:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"    | "Fair"     | $30   | "jdoe"          |


    Scenario Outline: Administrator undoes the deletion of a listing
        When I attempt to undo the listin with title "Calculus 2"
        Then I see a sucess message
        And the listing with title "Calculus 2", Author "Stewart", Condition "Good", Price "$30", and seller username "jdoe" shall become visible again
        And the "Calculus 2" listing should still exist in the database
        And the number of available listings shall be "7"
        Examples:
            | Title                        | Author       | Condition  | Price | Seller Username |
            | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |

    Scenario Outline: Administrator attempts to delete non-existent listing
        When I attempt to delete a listing with title "The stranger" by "Camus"
        Then I shall see the error "Listing does not exist"
        And the database should not be modified