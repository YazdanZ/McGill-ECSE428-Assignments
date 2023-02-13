Feature: Communication between buyer and seller

  As a student buyer and seller, I want to be able to communicate with the seller or buyer through the platform, so that I can ask questions or negotiate prices before making a purchase.

  Background:
    Given the following users exist:
      | username | password  | role           | status |
      | admin    | admin123  | administrator  | normal |
      | admin1   | adminxhas | administrator  | normal |
      | jdoe     | jdoepass  | student seller | normal |
      | jsmith   | jsmithp   | student buyer  | normal |
    And the following conversations exist:
      | from   | to     | message                       |
      | admin  | jdoe   | Welcome to the platform       |
      | jdoe   | admin  | Thank you                     |
      | jsmith | admin  | Hey your platform is awesome! |
      | admin  | jsmith | I know                        |
    And  the following listings exist:
      | Title                        | Author       | Condition  | Price | Seller Username |
      | "Calculus 2"                 | "Stewart"    | "Good"     | $30   | "jdoe"          |
      | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        |
      | "Biology 101"                | "Johnson"    | "Fair"     | $20   | "jdoe"          |
      | "C++ Programming"            | "Stroustrup" | "New"      | $60   | "awang"         |
      | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        |
      | "The Great Gatsby"           | "Fitzgerald" | "Like new" | $15   | "jdoe"          |
      | "Organic Chemistry"          | "Klein"      | "Fair"     | $10   | "awang"         |



    Given I am logged in as "jsmith" with password "jsmithp"

  Scenario: View previous conversations
    When I attempt to view my previous conversations
    Then I can see a list of my previous conversations with sellers and administrators
      | from   | to     | message                       |
      | jsmith | admin  | Hey your platform is awesome! |
      | admin  | jsmith | I know                        |

    And I cannot see the conversations which I am not part of

  Scenario: Ask seller a question
    When I attempt to ask the seller "jdoe" a question
    And I enter the question "Is it still available?"
    Then the seller "jdoe" receives my question
    And I am notified that my question was sent
    And a new conversation is created from "jsmith" to "jdoe":
      | from   | to    | message                 |
      | admin  | jdoe  | Welcome to the platform |
      | jdoe   | admin | Thank you               |
      | jsmith | jdoe  | Is it still available?  |

  Scenario: Negotiate price with seller
    When I attempt to negotiate price with seller for the book with title "Calculus 2"
    And I submit my proposed price "$25"
    Then the seller "jdoe" receives my proposed price
    And I am notified that my proposal was sent
    And the following entry shall be created:
      | title      | proposed price | proposer |
      | Calculus 2 | $25            | jsmith   |

  Scenario: Negotiate an invalid price with seller
    When I attempt to negotiate price with seller for the book with title "Calculus 2"
    And I submit my proposed price "$0"
    Then the seller "jdoe" does not receive my proposed price
    Then I should see an error message that says "Please enter a valid proposed price"

  Scenario: Sent message contains banned words
    When I attempt to negotiate price with seller for the book with title "Calculus 2"
    And I enter a message containing banned words like "f**k" or "sh*t"
    Then I should see an error message that says "Your message contains one or more banned words. Please check our community guidelines for harassement."
