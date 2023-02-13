Feature: Delivery option

    As a buyer in the system, I want to have multiple delivery options so that I can choose the most convenient one.

    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "jsmith" with password "jsmithp"


    Scenario: Select local pickup as delivery option
        Given I have added items for purchase in the cart
        When I proceed to checkout
        And select the "Local Pickup" option
        Then I shall see the address for pickup
        And the shipping fee should be zero
        And I shall be able to complete the checkout process


    Scenario: Select shipping at certain fee
        Given I have added items for purchase in the cart
        When I proceed to checkout
        And select the "Shipping" option
        Then I shall be able to enter the shipping address
        And the shipping fee shall be calculated based on the address and estimated delivery date displayed
        And I shall be able to complete the checkout process


    Scenario: Invalid shipping address

        Given I have added items for purchase in the cart
        When I proceed to checkout
        And select the "Shipping" option
        Then I shall be able to enter the shipping address
        And I enter an invalid shipping address
        Then I shall see an error message stating "Address is invalid"
        And the shipping fee shall not be calculated based and the estimated delivery date is not displayed
        And the checkout process shall be stopped



