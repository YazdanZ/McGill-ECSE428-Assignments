Feature: Report Seller

    As a buyer, I want to be able to report a seller if they violate the community guidelines, so that they can be reviewed by administrators and appropriate action can be taken.

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
            | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
            | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
            | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |

        And the following payment histories exist:
            | Title             | Payment Type | Price | Date       | Buyer  | Seller | Payment Info |
            | Organic Chemistry | paypal       | $10   | 01-01-2002 | jsmith | jdoe   | xxxxx        |
        Given I am logged in as a user "jsmith" with password "jsmithp"
        And I am on the seller's profile page

    Scenario: Report a seller for violating community guidelines
        Given I have purchased a textbook titled "Organic Chemistry" from "jdoe"
        When I attempt to report the seller "jdoe"
        And I select the reason for reporting as "false advertisement"
        And I enter a detailed explanation "The seller lists texbook as new but texbook is used"
        Then I should see a message confirming submisson of my report
            | Title             | Buyer  | Seller | Report Reason       | Report Description                                  | Decision  |
            | Organic Chemistry | jsmith | jdoe   | false advertisement | The seller lists texbook as new but texbook is used | in review |


    Scenario: Report a seller with no reason selected
        Given I have purchased a textbook titled "Organic Chemistry" from "jdoe"
        When I attempt to report the seller "jdoe"
        And I submit the report without selecting a reason
        But I include a detailed explanation "The seller lists texbook as new but texbook is used"
        Then I should see the error message "You should select the reason for the report"

    Scenario: Report a seller with no explanation entered
        Given I have purchased a textbook titled "Organic Chemistry" from "jdoe"
        When I attempt to report the seller "jdoe"
        And I submit the report selecting the reason "false advertisement"
        But I do not include a detailed explanation
        Then I should see the error message "You should write an explanation supporting your report"

    Scenario: Report a seller I have not had contact
        Given I have never had a chat with seller "chen"
        And I have not purchased a textbook from the seller
        When I attempt to report the seller "chen"
        Then I shall see the error message "You cannot report a seller you have not contacted or purchased from"
