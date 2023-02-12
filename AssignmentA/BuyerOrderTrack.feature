Feature: Track Order

    As a buyer in the system, I want to be able to track my order so that I can know the status of my purchase

    Background:
        Given the following users exist in the system:
            | username | password    | role           |
            | admin    | twofactor   | administrator  |
            | jdoe     | password456 | student seller |
            | himel    | password123 | student seller |
            | jsmith   | password    | student buyer  |
        And I am logged in the system as "jsmith"




    Scenario Outline: Successfully tracking orders
        Given the following books that are ordered by the logged in user:
            | Title                        | Author       |
            | "Introduction to Psychology" | "Atkinson"   |
            | "The Great Gatsby"           | "Fitzgerald" |
            | "Organic Chemistry"          | "Klein"      |

        When I make a track orders request
        Then I shall get a list of my orders with the status

        Examples:
            | Title                        | Author       | Status     |
            | "Introduction to Psychology" | "Atkinson"   | Delivered  |
            | "The Great Gatsby"           | "Fitzgerald" | In transit |
            | "Organic Chemistry"          | "Klein"      | Cancelled  |


    Scenario Outline: Tracking orders unsuccessful
        Given the user has no orders
        When I make a track orders request
        Then I shall see an error "No past orders"

