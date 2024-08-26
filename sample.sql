select * from `imdb_top_1000`;

-- update imdb_top_1000 set Gross=cast(replace(Gross,',','')as decimal);

select 
	director,
    sum(gross) as total_earning,
    count(series_title)as no_of_movies,
    avg(gross) as average_earning,
    max(gross) as maximum_earning_in_a_single_movie
from `imdb_top_1000`
group by director
order by total_earning desc;


-- alter table imdb_top_1000
-- add column genre1 varchar(255),
-- add column genre2 varchar(255),
-- add column genre3 varchar(255);


-- update imdb_top_1000
-- set genre1 = trim(SUBSTRING_INDEX(genre, ',', 1)),
--     genre2 = trim(
--         case when CHAR_LENGTH(genre) - CHAR_LENGTH(REPLACE(genre, ',', '')) >= 1
--             then SUBSTRING_INDEX(SUBSTRING_INDEX(genre, ',', 2), ',', -1)
--             else null
--         end
--     ),
--     genre3 = trim(
--          case when CHAR_LENGTH(genre) - CHAR_LENGTH(REPLACE(genre, ',', '')) >= 2
--             then SUBSTRING_INDEX(SUBSTRING_INDEX(genre, ',', 3), ',', -1)
--             else null
--         end
--     );



select 
	released_year,
    IMDB_Rating,
    genre1,
    count(genre1),
    genre2,
    count(genre2),
    genre3,
    count(genre3)
    
from imdb_top_1000
group by Released_Year,IMDB_Rating,genre1,genre2,genre3
order by Released_Year,IMDB_Rating desc;


select imdb_rating,min(gross),max(gross)
from imdb_top_1000
where IMDB_Rating is not null and gross is not null
group by IMDB_Rating;

-- UPDATE imdb_top_1000
-- SET Runtime =
--     case when Runtime LIKE '%min' then
--             cast(SUBSTRING_INDEX(runtime, ' ', 1) AS decimal)
--         else
--             null
--     end;

select Runtime,imdb_rating
from imdb_top_1000
where Runtime is not null
order by Runtime desc;

select imdb_rating,gross,star1,star2,star3,star4
from imdb_top_1000
where gross is not null;



with func as(
select
    star1 as actor,
    IMDB_Rating,
    gross
from imdb_top_1000
where star1 is not null
union all
select
    star2 as actor,
    IMDB_Rating,
    gross
from imdb_top_1000
where star2 is not null
union all
select
    star3 as actor,
    IMDB_Rating,
    gross
from imdb_top_1000
where star3 is not null
union all
select
    star4 as actor,
    IMDB_Rating,
    gross
from imdb_top_1000
where star4 is not null)


select
    actor,
    avg(IMDB_rating) as average_rating,
    sum(gross) as total_earnings
from func
where gross is not null
group by actor
order by total_earnings desc,average_rating;


-- alter table imdb_top_1000
-- modify column gross decimal;


select released_year, gross
from imdb_top_1000
where gross is not null and gross>400000000
order by gross desc,Released_Year
;






