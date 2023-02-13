    Feature: Manage Wishlist 
    As a student buyer, I want to be able to create a wishlist for the textbooks I'm looking for so that I can get notified when someone is selling them.

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
        And the following wishlists exist:
            | student buyer | Title       | Author     | Edition | ISBN            |
            | jsmith        | Biology 103 | Fitzgerald | 2nd     | 129781285741550 |
        Given I am logged in as a user "jsmith" with password "jsmithp"

    Scenario: Add a textbook to wishlist
        When I attempt to add a textbook to my wishlist
        And I fill in the required fields:
            | Field         | Value         |
            | Textbook Name | Calculus 2    |
            | Author        | James Stewart |
            | Edition       | 8th Edition   |
            | ISBN          | 9781285741550 |
        Then I should see a confirmation message that the textbook has been added to my wishlist
        And my wishlist should now contain the added textbook:
            | student buyer | Title       | Author        | Edition     | ISBN            |
            | jsmith        | Biology 103 | Fitzgerald    | 2nd         | 129781285741550 |
            | jsmith        | Calculus 2  | James Stewart | 8th Edition | 9781285741550   |
        And I shall receive a notification if the textbook is listed by a seller


    Scenario: View wishlist
        When I attempt to view my wishlist
        Then I should see a table with my existing wishlist items:
            | student buyer | Title       | Author     | Edition | ISBN            |
            | jsmith        | Biology 103 | Fitzgerald | 2nd     | 129781285741550 |

    Scenario: Delete wishlist item
        When I attempt to delete the textbook titled "Biology 103" authored by "Fitzgerald" from my wishlist
        Then I should see a confirmation message that the item has been removed from my wishlist
        And my wishlist should contain "0" items


    Scenario: Edit wishlist item
        When I attempt to eddit a textbook from my wishlist
        And I update the fields:
            | Field         | Value         |
            | Textbook Name | Calculus II   |
            | Author        | James Stewart |
            | Edition       | 9th Edition   |
            | ISBN          | 9781305266643 |
        And I click on the "Save" button
        Then I should see a confirmation message that the wishlist item has been updated
        And my wishlist shall be updated:
            | student buyer | Title       | Author        | Edition     | ISBN          |
            | jsmith        | Calculus II | James Stewart | 9th Edition | 9781305266643 |


    Scenario: Wishlist Item is missing required fields
        When I attempt to add a textbook to my wishlist
        And I fill in the required fields:
            | Field         | Value         |
            | Textbook Name |               |
            | Author        | James Stewart |
            | Edition       | 8th Edition   |
            | ISBN          | 9781285741550 |
        But leave a field blank
        Then I should see the error message "One or more required fields are missing"
        And the wishlist item shall not be added to my wishlist

    Scenario: Wishlist item is duplicated
        When I attempt to add a textbook to my wishlist
        And I fill in the required fields:
            | Field         | Value           |
            | Textbook Name | Biology 103     |
            | Author        | Fitzgerald      |
            | Edition       | 2nd             |
            | ISBN          | 129781285741550 |
        And I enter a textbook that is already on my wishlist
        Then I should see the error message "Textbook is already on my wishlist"
        And a duplicate entry shall not be created

    Scenario: Wishlist item is made available
        Given the listing gets updates and my wishlist Textbook "Biology 103" is made available:
            | Title         | Author       | Condition | Price | Seller Username |
            | "Biology 103" | "Fitzgerald" | "Good"    | $30   | "jdoe"          |

        When I log into the application
        Then shall receive a message notifying me of the updated availability of my wishlist item "Biology 103"