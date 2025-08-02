/* find the number of availalbe copies of the book (Dracula)      */
SELECT (SELECT COUNT(*) FROM Books WHERE Title = 'Dracula') -
(SELECT COUNT(*) FROM Loans as l inner join books as b on b.BookID=l.BookID
where  b.Title = 'Dracula' AND ReturnedDate IS NULL) as available_copies;
select *from books;

/* Add new books to the library*/
insert into books values(201,"old man","wiliam",1977,1234567890);

/* Check out Books: books(4043822646, 2855934983) whose patron_email(jvaan@wisdompets.com), loandate=2020-08-25, duedate=2020-09-08, loanid=by_your_choice*/
insert into loans (LoanID, BookID, PatronID, LoanDate, DueDate, ReturnedDate) values
(3001,(select bookid from books where Barcode=4043822646),
(select PatronID from patrons where email="jvaan@wisdompets.com"),"2020-08-25","2020-09-08",null),
(3002,(select bookid from books where Barcode=2855934983),
(select PatronID from patrons where email="jvaan@wisdompets.com"),"2020-08-25","2020-09-08",null);

/* Check books for Due back                             */
/* generate a report of books due back on July 13, 2020 */
/* with patron contact information                      */

select *from books as b 
inner join loans as l on b.BookID=l.BookID
inner join patrons as p on p.PatronID=l.PatronID 
where DueDate="2020-07-13" ;

/* Return books to the library (which have barcode=6435968624) and return this book at this date(2020-07-05)*/
UPDATE Loans SET ReturnedDate = '2020-07-05' 
WHERE BookID = (SELECT BookID FROM Books WHERE Barcode = 6435968624) 
AND ReturnedDate IS NULL;

/* Encourage Patrons to check out books                */
/* generate a report of showing 10 patrons who have
checked out the fewest books.                          */

select p.PatronID ,p.FirstName,count(l.LoanID) as count_of_books_cheked_out from patrons as p
inner join loans AS l on p.PatronID=l.BookID
group by p.PatronID ,p.FirstName
order by count_of_books_cheked_out asc 
limit 4;

/* Find books to feature for an event                  
 create a list of books from 1890s that are
 currently available   */
 
select *from books;
 
 select b.bookid,b.title,b.Published from books as b 
 inner join loans as l on l.BookID=b.BookID 
 where  b.Published >=1890 and l.ReturnedDate is null
 order by b.Published asc;

/* Book Statistics 
/* create a report to show how many books were 
published each year.                                    */
/*******************************************************/
SELECT Published, COUNT(DISTINCT(Title)) AS TotalNumberOfPublishedBooks FROM Books
GROUP BY Published
ORDER BY TotalNumberOfPublishedBooks DESC; 
 
/* Book Statistics                                           */
/* create a report to show 5 most popular Books to check out */
/*************************************************************/

SELECT b.Title, b.Author, b.Published, COUNT(b.Title) AS TotalTimesOfLoans FROM Books b
JOIN Loans l ON b.BookID = l.BookID
GROUP BY b.Title, b.Author, b.Published
ORDER BY 4 DESC
LIMIT 5;












