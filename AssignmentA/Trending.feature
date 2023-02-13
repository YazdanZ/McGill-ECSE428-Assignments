Feature: Trending books

    As a user in the system, I want to be able to find the most popular books in the system so that I can stay up-to-date with what's in demand.


    Background:
        Given the following users exist:
            | username | password | role           |
            | admin    | admin123 | administrator  |
            | jdoe     | jdoepass | student seller |
            | jsmith   | jsmithp  | student buyer  |
            | jdoe     | jdoep    | student buyer  |
            | chen     | chen21   | student seller |

        And I am logged in as a user "jsmith" with password "jsmithp"



    Scenario: View trending books
        When I visit the trending books section
        Then I shall see a list of the most popular books ranked in different categories with popularity statistics

        Examples:

            | Title                        | Author       | Category    | Price | Popularity                          |
            | "Calculus 2"                 | "Stewart"    | Science     | $30   | Top 10 this week in North America   |
            | "Introduction to Python"     | "Van Rossum" | Programming | $50   | Top 3 this week worldwide           |
            | "Biology 101"                | "Johnson"    | Science     | $20   | Top 50 this week in Europe          |
            | "C++ Programming"            | "Stroustrup" | Programming | $60   | 68 units sold in the last 4 hours   |
            | "Introduction to Psychology" | "Atkinson"   | Psychology  | $25   | Top 5 under $25                     |
            | "The Great Gatsby"           | "Fitzgerald" | Novel       | $15   | 215 units sold in the last 48 hours |
            | "Organic Chemistry"          | "Klein"      | Science     | $10   | Number 1 is science worldwide       |


    Scenario: View trending books by category
        When I visit the trending books section
        And select a "Science" as category from the drop-down menu
        Then I shall see a list of the most popular books ranked in "Science" category with popularity statistics

        Examples:

            | Title               | Author    | Category | Price | Popularity                        |
            | "Calculus 2"        | "Stewart" | Science  | $30   | Top 10 this week in North America |
            | "Biology 101"       | "Johnson" | Science  | $20   | Top 50 this week in Europe        |
            | "Organic Chemistry" | "Klein"   | Science  | $10   | Number 1 is science worldwide     |



    Scenario: No trending books found - system under maintenance
        When I visit the trending books section
        Then I shall see a message stating "No trending book right now - system is under maintenance"