-- Find the tags that are on the most uninteresting questions
-- Run on https://data.stackexchange.com/stackoverflow/query
    
SELECT TOP 50 TagName,
  COUNT (*) AS freq
FROM Tags
  INNER JOIN PostTags ON PostTags.TagId = Tags.id
  INNER JOIN Posts ON Posts.id = PostTags.PostId
WHERE Posts.Score = 0 AND
      Posts.AnswerCount = 0 AND 
      Posts.ClosedDate IS NULL AND 
      Posts.DeletionDate IS NULL AND
      Posts.CreationDate < DATEADD(week,-1,GETDATE())
GROUP BY TagName
ORDER BY freq DESC
