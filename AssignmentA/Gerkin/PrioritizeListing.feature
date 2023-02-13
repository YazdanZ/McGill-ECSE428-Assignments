Feature: Paid Listing Promotion

    As a seller, I want to be able to pay to promote my listings to the top of the search results and suggestions, so that my items have greater visibility and are more likely to be purchased.

    Background:
        Given the following users exist:
            | username | password | role           |
            | jdoe     | jdoepass | student seller |
        And I am logged in with username "jsmith" and password "jsmithp"

        And  the following listings exist:
            | Title                        | Author       | Condition  | Price | Seller Username | promotion |
            | "Introduction to Python"     | "Van Rossum" | "Like new" | $50   | "jsmith"        | True      |
            | "Introduction to Psychology" | "Atkinson"   | "Good"     | $25   | "jsmith"        | False     |

    Scenario: Successful Promotion
        When I choose to promote the listing "Introduction to Psychology"
        And I pay to promote the listing
        Then the listing is promoted to the top of the search results and suggestions
        And the listing promotion status is updated:
            | Title                        | Author     | Condition | Price | Seller Username | promotion |
            | "Introduction to Psychology" | "Atkinson" | "Good"    | $25   | "jsmith"        | True      |
        And the payment is processed and saved:
            | Listing Title                | Promotion Fee | Payment Method |
            | "Introduction to Psychology" | $5.00         | Credit Card    |

    Scenario: Promotion Cancelled
        Given I have a promoted listing for "Introduction to Psychology":
            | Title                        | Author     | Condition | Price | Seller Username | promotion |
            | "Introduction to Psychology" | "Atkinson" | "Good"    | $25   | "jsmith"        | True      |
        And I choose to cancel the promotion
        Then the listing is removed from the promoted section
        And the listing is update:
            | Title                        | Author     | Condition | Price | Seller Username | promotion |
            | "Introduction to Psychology" | "Atkinson" | "Good"    | $25   | "jsmith"        | False     |

    Scenario: Promotion Payment Failed
        When I choose to promote the listing "Introduction to Psychology"
        And I try to make the payment for the promotion
        And the payment fails
        Then the listing remains unchanged:
            | Title                        | Author     | Condition | Price | Seller Username | promotion |
            | "Introduction to Psychology" | "Atkinson" | "Good"    | $25   | "jsmith"        | False     |

    Scenario: Listing Already Promoted
        When I try to promote the listing "Introduction to Python"
        But the listing is already promoted
        Then I shall see the error "Listing is already promoted"