#1. Find the number of users in the database.
SELECT COUNT(*)
FROM Users;

#2. Find the number of items in "New York", (i.e., items whose location is exactly the string "New York"). Pay special attention to case sensitivity. You should match the items in "New York" but not in "new york".
SELECT COUNT(ItemID)
FROM Items
WHERE Location = 'New York';


#3. Find the number of auctions belonging to exactly four categories. 
SELECT COUNT(*)
FROM Bids
WHERE Bids.ItemID IN (SELECT ItemCategory.ItemID 
				FROM ItemCategory
				GROUP BY ItemCategory.ItemID
				HAVING COUNT(Category) = 4);


#4. Find the ID(s) of current (unsold) auction(s) with the highest bid. Remember that the data was captured at the point in time December 20th, 2001, one second after midnight, so you can use this time point to decide which auction(s) are current. Pay special attention to the current auctions without any bid.
SELECT ItemID, NumberOfBids 
FROM Items 
WHERE NumberOfBids > 0 AND Currently = (SELECT MAX(Currently) 
											FROM Items 
											WHERE Ends > '2001-12-20 00:00:01' AND NumberOfBids > 0);


#5. Find the number of sellers whose rating is higher than 1000.
SELECT COUNT(*)
FROM Sellers
WHERE rating > 1000;


#6. Find the number of users who are both sellers and bidders.
SELECT COUNT(*)
FROM Sellers, Bidders
WHERE Sellers.UserID = Bidders.UserID;



#7. Find the number of categories that include at least one item with a bid of more than $100.
SELECT COUNT(*) 
FROM (SELECT DISTINCT Category 
		FROM Categories 
		WHERE ItemID in (SELECT DISTINCT ItemID 
							FROM Bids WHERE Amount > 100.00));




