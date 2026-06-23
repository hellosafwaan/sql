-- LENGTH() counts characters; > 15 means strictly more than 15
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
