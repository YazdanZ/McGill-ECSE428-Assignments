Feature: Payment System

  As a student buyer and seller, I want to be able to make and receive payments through the platform so that I can buy items.

  Background:
    Given the following users exist:
      | username | password | role           |
      | admin    | admin123 | administrator  |
      | jdoe     | jdoepass | student seller |
      | jsmith   | jsmithp  | student buyer  |

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

  Scenario: Make a Payment
    Given I have the textbook "Introduction to Python" in my cart
    When I enter the valid payment information "xxxxxx"
    And I attempt to pay "$50" for the texbook
    Then I should see a confirmation message
    And the item should be marked as "sold":
      | Title                    | Author       | Condition  | Price | Seller Username | Status |
      | "Introduction to Python" | "Van Rossum" | "Like new" | $50   | "jsmith"        | sold   |
    And the seller "jdoe" shall be notified
    And a payment shall be added to my payment history with the current date
      | Title                    | Payment Type | Price | Date       | Buyer  | Seller | Payment Info |
      | Organic Chemistry        | paypal       | $10   | 01-01-2002 | jsmith | jdoe   | xxxxx        |
      | "Introduction to Python" | credit card  | $50   | 01-01-2023 | jsmith | jdoe   | xxyajx       |

  Scenario: View Payment History
    Given I have made one or more payments
    When I navigate to the payment history page
    Then I should see a list of my previous payments
    And I should see the date, price, payment type, title, and seller purchased for each payment:
      | Title             | Payment Type | Price | Date       | Buyer  | Seller |
      | Organic Chemistry | paypal       | $10   | 01-01-2002 | jsmith | awang  |

  Scenario: Refund a Payment
    Given I have made a payment for textbook with title "Organic Chemistry"
    And the item is eligible for a refund
    When I request a refund
    Then the payment should be reversed
    And the item should be marked as "for sale" again:
      | Title               | Author       | Condition  | Price | Seller Username | Status   |
      | "Organic Chemistry" | "Van Rossum" | "Like new" | $50   | "jsmith"        | for sale |
    And the payment  shall be removed from my history:
      | Title | Payment Type | Price | Date | Buyer | Seller |

  Scenario: Payment Failure
    Given I have the textbook with title "Introduction to Python" in my cart
    When I enter the invalid payment information "xxxxxx"
    And I attempt to pay "$50" for the texbook
    Then I should see an error message "Invalid payment information"
    And the item should still be marked as "for sale"
    And no payment should be added to the system

  Scenario: Payment Dispute
    Given I have made a payment for textbook with title "Organic Chemistry"
    And there is a dispute over the item received
    When I open a dispute resolution case
    Then a dispute is created:
      | Title             | Buyer  | Seller | reason            |
      | Organic Chemistry | jsmith | awang  | false advertising |
    Then the payment should be put on hold:
      | Title             | Payment Type | Price | Date       | Buyer  | Seller | status |
      | Organic Chemistry | paypal       | $10   | 01-01-2002 | jsmith | awang  | Onhold |

    And the seller should be notified
    And the administrator shall be notified for review
    And I should receive updates on the resolution status
