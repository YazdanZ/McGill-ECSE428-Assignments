Feature: Seller Analytics

    As a seller on the textbook exchange service I want to view my selling statistics and analytics so that I can better my sales strategy

    Background:
        Given the following users exist:
            | username | password | role           |
            | jdoe     | jdoepass | student seller |
        And I am logged in with username "jdoe" and password "jdoepass"
        And the following payment histories exist:
            | Title              | Payment Type | Price | Date       | Buyer  | Seller | Payment Info |
            | Organic Chemistry  | paypal       | $10   | 01-01-2002 | jsmith | jdoe   | xxxxx        |
            | 100 chess endhames | cash         | $20   | 01-3-2023  | jsmith | jdoe   | xxaxxx       |

    Scenario: View sales performance
        When I attempt to view my sales performance and analytics
        Then I should see sold <total_books_sold> textbooks, and earned $<total_earnings> in total revenue
        And I shall see a breakdown of sales by year:
            | year | Number of Books Sold | Revenue Earned |
            | 2023 | 1                    | $20            |
            | 2002 | 1                    | $10            |

    Scenario: View popular search terms
        When I attempt to view search analytics
        Then I should see a table of the most popular search terms for my listings
            | Search Term   | Number of Clicks | Number of views |
            | Biology       | 15               | 100             |
            | Calculus      | 12               | 200             |
            | American Lit. | 7                | 343             |

    Scenario: View sales by date range
        When I attempt to filter sales analytics by date range
        And I select the "sales by date range" option
        And I select a start date of "2001-01-01" and an end date of "2003-02-01"
        Then I should see a summary of my sales performance during the specified date range
            | Metric             | Value |
            | Total sales        | 1     |
            | Total sale price   | $10   |
            | Average sale price | $10   |

    Scenario: Invalid date range
        When I navigate to the analytics section of my account
        And I select the "sales by date range" option
        And I select a start date of "2001-02-01" and an end date of "2003-02-01"
        Then I shall see the error "invalid date range"