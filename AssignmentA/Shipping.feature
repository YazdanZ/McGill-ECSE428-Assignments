Feature: Shipping Information

    As a student buyer, I want to enter and my shipping information, so that I can receive textbooks I purchase.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | chen     | chen21   | student seller |
        And I am logged in with username "jsmith" and password "jsmithp"
        And I have purchased a textbook:
            | Title             | Payment Type | Price | Date       | Buyer  | Seller | Payment Info |
            | Organic Chemistry | paypal       | $10   | 01-01-2002 | jsmith | jdoe   | xxxxx        |


    Scenario: Enter shipping information
        Given I am on the purchase confirmation page
        When I attempt to enter shipping information button
        And I fill in the following information:
            | Field          | Value           |
            | username       | jsmith          |
            | Address Line 1 | 123 Main Street |
            | Address Line 2 | Apartment 4B    |
            | City           | New York        |
            | State          | NY              |
            | Postal Code    | 100129          |
            | Country        | US              |
        Then my shipping information shall be saved :
            | username | Address Line 1  | Address Line 2 | City     | State | Postal Code | Country |
            | jsmith   | 123 Main Street | Apartment 4B   | New York | NY    | 100129      | US      |

        And I should see a confirmation message

    Scenario: Edit shipping information
        Given I have an existing shipping information:
            | username | Address Line 1  | Address Line 2 | City     | State | Postal Code | Country |
            | jsmith   | 123 Main Street | Apartment 4B   | New York | NY    | 100129      | US      |
        When I attempt to edit my shipping information
        And I update the following information:
            | Field          | Value          |
            | username       | jsmith         |
            | Address Line 1 | 456 Elm Street |
            | Address Line 2 | Suite 500      |
            | City           | San Francisco  |
            | State          | CA             |
            | ZIP Code       | 94105          |
            | Country        | US             |
        Then my updated shipping information shall be saved:
            | username | Address Line 1 | Address Line 2 | City          | State | Postal Code | Country |
            | jsmith   | 456 Elm Street | Suite 500      | San Francisco | CA    | 94105       | US      |

        And I should see a confirmation message

    Scenario: View shipping information
        Given I have an existing shipping information:
            | username | Address Line 1  | Address Line 2 | City     | State | Postal Code | Country |
            | jsmith   | 123 Main Street | Apartment 4B   | New York | NY    | 100129      | US      |
        When I attempt to view my shipping information
        Then I should see my saved shipping information

    Scenario: Enter invalid shipping information
        When I attempt to update of create shipping information
        And I fill in the following information:
            | Field          | Value |
            | First Name     |       |
            | Last Name      |       |
            | Address Line 1 |       |
            | City           |       |
            | State          |       |
            | ZIP Code       |       |
            | Country        |       |
        Then I should see an error message "Invalid shipping information due to empty fields"
        And my shipping information shall not be saved

    Scenario: Duplicate shipping information
        Given I have an existing shipping information:
            | username | Address Line 1  | Address Line 2 | City     | State | Postal Code | Country |
            | jsmith   | 123 Main Street | Apartment 4B   | New York | NY    | 100129      | US      |
        When I attempt to create a new shipping information item
        And I fill in the following information:
            | Field          | Value           |
            | username       | jsmith          |
            | Address Line 1 | 123 Main Street |
            | Address Line 2 | Apartment 4B    |
            | City           | New York        |
            | State          | NY              |
            | Postal Code    | 100129          |
            | Country        | US              |
        Then I should see an error message "Duplicate shipping information"
        And my shipping information should not be saved to the system
    Scenario: Delete shipping information
        Given I have an existing shipping information:
            | username | Address Line 1  | Address Line 2 | City     | State | Postal Code | Country |
            | jsmith   | 123 Main Street | Apartment 4B   | New York | NY    | 100129      | US      |
        When I attempt to delete the existing shipping information
        Then the shipping information shall be deleted from the system
        And my number of existing shipping informations shall be "0"
