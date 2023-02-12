Feature: Dispute Resolution

    As a user, I want to be able to open disputes with other users related to textbook transactions, so that I can ensure a fair and satisfactory outcome.

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

  Scenario: Initiate Dispute
    Given I have made a payment for textbook with title "Organic Chemistry" to the seller "awang"
    And there is a dispute over the item received
    When I open a dispute resolution case
    Then a dispute is created with decision "in review":
      | Title             | Buyer  | Seller | reason            | decision  |
      | Organic Chemistry | jsmith | awang  | false advertising | in review |
    Then the payment should be put on hold:
      | Title             | Payment Type | Price | Date       | Buyer  | Seller | status |
      | Organic Chemistry | paypal       | $10   | 01-01-2002 | jsmith | awang  | Onhold |

    And the seller should be notified
    And the administrator shall be notified for review
    And I should receive updates on the resolution status


  Scenario: Provide evidence for dispute
    Given a dispute has been initiated:
      | Title             | Buyer  | Seller | reason            | decision  | status |
      | Organic Chemistry | jsmith | awang  | false advertising | in review | open   |
    And I am a buyer or a seller in the opened dispute
    When I am asked to provide evidence to support my claim
    Then I can provide evidence such as photos "screenshot" and messages "messages.txt"
    And the decision should be set to "Proof provided"
    And the system should update my dispute:
      | Title             | Buyer  | Seller | reason            | decision       | status |
      | Organic Chemistry | jsmith | awang  | false advertising | Proof provided | open   |
    And the administrator(s) shall be notified


  Scenario Outline: Review evidence and make a decision
    Given I am an administrator logged in with username "admin" and password "admin123"
    When both the buyer and seller have provided evidence
    Then I can review the edispute and evidence and make a decision
    And update the dispute decision
    Examples:
      | Evidence   | Decision     |
      | Clear      | Buyer refund |
      | Unclear    | Further info |
      | Incomplete | No decision  |
    Then the decision shall be communicated to both the buyer and seller

  Scenario: Appeal a decision
    Given a decision has been made in a dispute:
      | Title             | Buyer  | Seller | reason            | decision           | Appeal | status |
      | Organic Chemistry | jsmith | awang  | false advertising | No refund to buyer | N/A    | close  |

    And I disagree with the decision
    When I attempt to appeal to the decision
    Then the dispute is reopened:
      | Title             | Buyer  | Seller | reason            | decision           | Appeal | status |
      | Organic Chemistry | jsmith | awang  | false advertising | No refund to buyer | N/A    | open   |
    And the administrators are notified of the reopened dispute

  Scenario: Dispute creation with invalid dispute reason
    Given I have made a payment for textbook with title "Organic Chemistry" to the seller "awang"
    When I attempt to open a dispute over an item
    But do not include a reason:
      | Title             | Buyer  | Seller | reason | decision  | Appeal | status |
      | Organic Chemistry | jsmith | awang  |        | in review | N/A    | open   |

    Then I shall receive an error: "reason for dispute shall be stated"
    And a dispute shall not be created

  Scenario: Dispute creation without a purchase
    Given I have not purchased a textbook from the seller "awang"
    When I attempt to open a distpute over an item
    Then I shall receive an error "You have not purchased an item from seller"
    And the dispute shall not be created

  Scenario: Cancel an opened dispute
    Given a dispute has been initiated:
      | Title             | Buyer  | Seller | reason            | decision  | status |
      | Organic Chemistry | jsmith | awang  | false advertising | in review | open   |
    When I attempt to cancel the dispute
    Then the dispute's status and decision shall be updated to "cancelled":
      | Title             | Buyer  | Seller | reason            | decision  | status    |
      | Organic Chemistry | jsmith | awang  | false advertising | cancelled | cancelled |

    And the seller and administrator shall be notified
