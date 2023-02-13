Feature: Trade textbooks with other users

    As a student, I want to trade textbooks with other users on the platform, so that I can exchange textbooks that I need for those that I no longer need.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | chen     | chen21   | student seller |
        And the following trade requests exist:
            | Title                | Edition | Author    | Trade with               | trader |
            | The stranger         | 4th     | Camus     | War and Peace            | chen   |
            | The myth of sisyphus | 4th     | Camus     | anna karenina            | chen   |
            | Programming Java     | 2nd     | Mark Lutz | Database System Concepts | jsmith |
        And I am logged in as a user "jsmith" with password "jsmithp"

    Scenario: Create a trade listing
        When I create a trade listing for "Programming Python" to trade for "Database System Concepts"
        Then I get the message "the trade listing is created successfully"
        And the trade is added to the system:
            | Title              | Edition | Author    | Trade with               | trader |
            | Programming Python | 4th     | Mark Lutz | Database System Concepts | jsmith |

    Scenario: Create an invalid trade listing
        When I create a trade listing for "Programming Python"
        But leave the textbook to trade with blank
        Then I get the error message "The textbook to trade with is not inputted"
        And the trade is not added to the system

    Scenario: Update trade listing
        When I attempt to update the textbook to trade with "Programming Java" to "Chess endgames"
        Then I get the success message "Trade request updated"
        And the trade listing is updated in the system:
            | Title            | Edition | Author    | Trade with     | trader |
            | Programming Java | 2nd     | Mark Lutz | Chess endgames | jsmith |

    Scenario: Delete trade listing
        When I attempt to delete the trade listing to trade "Programming Java"
        Then I get the succes message "Removed trade listing"
        And the trade listing is removed from the system:
            | Title                | Edition | Author | Trade with    | trader |
            | The stranger         | 4th     | Camus  | War and Peace | chen   |
            | The myth of sisyphus | 4th     | Camus  | anna karenina | chen   |
        And the number of existing listings in the system is "2"

    Scenario: student responds to a trade listing
        When I respond to the trade listing for "<want_title>" and "<offer_title>"
        Then the trade request is sent successfully to the user "chen" listing the trade:

            | want_title           | offer_title   |
            | The stranger         | War and Peace |
            | The myth of sisyphus | anna karenina |

    Scenario: student receives a trade request
        Given user "chen" with password "chen21" is logged in
        When user "chen" views the trade requests for "<offer_title>" with <want_title>
        Then user "chen" can approve or deny the trade request:
            | offer_title          | want_title    | status  |
            | The stranger         | War and Peace | pending |
            | The myth of sisyphus | anna karenina | pending |
        And the trade listing status is updated

    Scenario: student attempts to create a listing for a textbook that is already in a trade listing
        When I creates a trade or sell listing for "Programming Java" for "The stranger"
        Then the error message is displayed: "textbook is already in a trade listing"
        And the trade of sell listings are not updated