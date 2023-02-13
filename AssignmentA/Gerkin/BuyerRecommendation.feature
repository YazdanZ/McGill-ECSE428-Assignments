Feature: Book recommendation

    As a buyer in the system, I want to be able to see recommendation based on my purchase history, so that I can buy books other than the ones that I am aware of.


    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "jsmith" with password "jsmith"

        Given the following books exist in the system:
            | Title                        | Author       | Condition  | Price | Seller Username | Category    |
            | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          | Science     |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        | Programming |
            | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          | Science     |
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         | Programming |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        | Psychology  |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          | Novel       |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         | Science     |


    Scenario: Successful book recommendation
        Given my past book purchases:
            | Title        | Author    | Condition | Price | Seller Username | Category |
            | "Calculus 2" | "Stewart" | "Good"    | $30   | "jdoe"          | Science  |


        When I visit the recommendation section
        Then I shall recommendations based on my purchase history:
            | Title               | Author    | Condition | Price | Seller Username | Category |
            | "Biology 101"       | "Johnson" | "Fair"    | $20   | "jdoe"          | Science  |
            | "Organic Chemistry" | "Klein"   | "Fair"    | $10   | "awang"         | Science  |


    Scenario: Successful e-book listing with existing listing
        Given I have not made any purchase from the system
        When I visit the recommendation section
        Then I see a message stating "Buy books to see curated list of recommended books for you"
