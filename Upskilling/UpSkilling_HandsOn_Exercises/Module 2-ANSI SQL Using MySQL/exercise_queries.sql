USE EventPortalDB;

-- =====================================================
-- 1. User Upcoming Events
-- Show a list of all upcoming events a user is
-- registered for in their city, sorted by date.
-- =====================================================
SELECT u.full_name,
       e.title,
       e.city,
       e.start_date
FROM Users u
JOIN Registrations r ON u.user_id = r.user_id
JOIN Events e ON r.event_id = e.event_id
WHERE e.status = 'upcoming'
  AND u.city = e.city
ORDER BY e.start_date;

-- =====================================================
-- 2. Top Rated Events
-- Identify events with the highest average rating,
-- considering only those that have received at least
-- 10 feedback submissions.
-- =====================================================

SELECT e.event_id,
       e.title,
       AVG(f.rating) AS avg_rating,
       COUNT(*) AS feedback_count
FROM Events e
JOIN Feedback f ON e.event_id = f.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(*) >= 10
ORDER BY avg_rating DESC;


-- =====================================================
-- 3. Inactive Users
-- Retrieve users who have not registered for any events
-- in the last 90 days.
-- =====================================================

SELECT *
FROM Users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id
    FROM Registrations
    WHERE registration_date >= CURDATE() - INTERVAL 90 DAY
);


-- =====================================================
-- 4. Peak Session Hours
-- Count how many sessions are scheduled between
-- 10 AM and 12 PM for each event.
-- =====================================================

SELECT e.title,
       COUNT(s.session_id) AS session_count
FROM Events e
LEFT JOIN Sessions s
ON e.event_id = s.event_id
WHERE TIME(s.start_time) BETWEEN '10:00:00' AND '12:00:00'
GROUP BY e.event_id, e.title;


-- =====================================================
-- 5. Most Active Cities
-- List the top 5 cities with the highest number
-- of distinct user registrations.
-- =====================================================

SELECT u.city,
       COUNT(DISTINCT r.user_id) AS registrations
FROM Users u
JOIN Registrations r
ON u.user_id = r.user_id
GROUP BY u.city
ORDER BY registrations DESC
LIMIT 5;


-- =====================================================
-- 6. Event Resource Summary
-- Generate a report showing the number of resources
-- (PDFs, images, links) uploaded for each event.
-- =====================================================

SELECT e.title,
       COUNT(CASE WHEN resource_type='pdf' THEN 1 END) AS pdf_count,
       COUNT(CASE WHEN resource_type='image' THEN 1 END) AS image_count,
       COUNT(CASE WHEN resource_type='link' THEN 1 END) AS link_count
FROM Events e
LEFT JOIN Resources r
ON e.event_id = r.event_id
GROUP BY e.event_id, e.title;


-- =====================================================
-- 7. Low Feedback Alerts
-- List all users who gave feedback with rating
-- less than 3.
-- =====================================================

SELECT u.full_name,
       e.title,
       f.rating,
       f.comments
FROM Feedback f
JOIN Users u ON f.user_id = u.user_id
JOIN Events e ON f.event_id = e.event_id
WHERE f.rating < 3;


-- =====================================================
-- 8. Sessions per Upcoming Event
-- Display all upcoming events with the count
-- of sessions scheduled for them.
-- =====================================================

SELECT e.title,
       COUNT(s.session_id) AS total_sessions
FROM Events e
LEFT JOIN Sessions s
ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id, e.title;


-- =====================================================
-- 9. Organizer Event Summary
-- For each organizer, show number of events created
-- and current status.
-- =====================================================

SELECT u.full_name,
       e.status,
       COUNT(*) AS total_events
FROM Events e
JOIN Users u
ON e.organizer_id = u.user_id
GROUP BY u.full_name, e.status;


-- =====================================================
-- 10. Feedback Gap
-- Identify events that had registrations
-- but received no feedback.
-- =====================================================

SELECT e.title
FROM Events e
JOIN Registrations r
ON e.event_id = r.event_id
LEFT JOIN Feedback f
ON e.event_id = f.event_id
WHERE f.feedback_id IS NULL
GROUP BY e.event_id, e.title;


-- =====================================================
-- 11. Daily New User Count
-- Find number of users who registered each day
-- in the last 7 days.
-- =====================================================

SELECT registration_date,
       COUNT(*) AS new_users
FROM Users
WHERE registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY registration_date;


-- =====================================================
-- 12. Event with Maximum Sessions
-- List event(s) with highest number of sessions.
-- =====================================================

SELECT e.title,
       COUNT(s.session_id) AS total_sessions
FROM Events e
JOIN Sessions s
ON e.event_id = s.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(s.session_id) = (
    SELECT MAX(session_count)
    FROM (
        SELECT COUNT(*) AS session_count
        FROM Sessions
        GROUP BY event_id
    ) x
);


-- =====================================================
-- 13. Average Rating per City
-- Calculate average feedback rating of events
-- conducted in each city.
-- =====================================================

SELECT e.city,
       AVG(f.rating) AS avg_rating
FROM Events e
JOIN Feedback f
ON e.event_id = f.event_id
GROUP BY e.city;


-- =====================================================
-- 14. Most Registered Events
-- List top 3 events based on registrations.
-- =====================================================

SELECT e.title,
       COUNT(r.registration_id) AS registrations
FROM Events e
JOIN Registrations r
ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
ORDER BY registrations DESC
LIMIT 3;


-- =====================================================
-- 15. Event Session Time Conflict
-- Identify overlapping sessions within same event.
-- =====================================================

SELECT s1.event_id,
       s1.title,
       s2.title AS conflicting_session
FROM Sessions s1
JOIN Sessions s2
ON s1.event_id = s2.event_id
AND s1.session_id < s2.session_id
AND s1.start_time < s2.end_time
AND s1.end_time > s2.start_time;


-- =====================================================
-- 16. Unregistered Active Users
-- Find users created in last 30 days but
-- not registered for any event.
-- =====================================================

SELECT *
FROM Users u
WHERE registration_date >= CURDATE() - INTERVAL 30 DAY
AND NOT EXISTS (
    SELECT 1
    FROM Registrations r
    WHERE r.user_id = u.user_id
);


-- =====================================================
-- 17. Multi-Session Speakers
-- Identify speakers handling more than one session.
-- =====================================================

SELECT speaker_name,
       COUNT(*) AS sessions_handled
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(*) > 1;


-- =====================================================
-- 18. Resource Availability Check
-- List events with no resources uploaded.
-- =====================================================

SELECT e.title
FROM Events e
LEFT JOIN Resources r
ON e.event_id = r.event_id
WHERE r.resource_id IS NULL;


-- =====================================================
-- 19. Completed Events with Feedback Summary
-- Show registrations and average rating
-- for completed events.
-- =====================================================

SELECT e.title,
       COUNT(DISTINCT r.registration_id) AS registrations,
       AVG(f.rating) AS avg_rating
FROM Events e
LEFT JOIN Registrations r
ON e.event_id = r.event_id
LEFT JOIN Feedback f
ON e.event_id = f.event_id
WHERE e.status = 'completed'
GROUP BY e.event_id, e.title;


-- =====================================================
-- 20. User Engagement Index
-- Calculate events attended and feedbacks submitted.
-- =====================================================

SELECT u.full_name,
       COUNT(DISTINCT r.event_id) AS attended_events,
       COUNT(DISTINCT f.feedback_id) AS feedbacks_submitted
FROM Users u
LEFT JOIN Registrations r
ON u.user_id = r.user_id
LEFT JOIN Feedback f
ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name;


-- =====================================================
-- 21. Top Feedback Providers
-- Top 5 users with most feedback entries.
-- =====================================================

SELECT u.full_name,
       COUNT(*) AS feedback_count
FROM Users u
JOIN Feedback f
ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name
ORDER BY feedback_count DESC
LIMIT 5;


-- =====================================================
-- 22. Duplicate Registrations Check
-- Detect duplicate registrations.
-- =====================================================

SELECT user_id,
       event_id,
       COUNT(*) AS duplicate_count
FROM Registrations
GROUP BY user_id, event_id
HAVING COUNT(*) > 1;


-- =====================================================
-- 23. Registration Trends
-- Month-wise registration count over last 12 months.
-- =====================================================

SELECT DATE_FORMAT(registration_date,'%Y-%m') AS month,
       COUNT(*) AS registrations
FROM Registrations
WHERE registration_date >= CURDATE() - INTERVAL 12 MONTH
GROUP BY month
ORDER BY month;


-- =====================================================
-- 24. Average Session Duration per Event
-- Compute average session duration in minutes.
-- =====================================================

SELECT e.title,
       AVG(
           TIMESTAMPDIFF(
               MINUTE,
               s.start_time,
               s.end_time
           )
       ) AS avg_duration_minutes
FROM Events e
JOIN Sessions s
ON e.event_id = s.event_id
GROUP BY e.event_id, e.title;


-- =====================================================
-- 25. Events Without Sessions
-- List events with no sessions scheduled.
-- =====================================================

SELECT e.title
FROM Events e
LEFT JOIN Sessions s
ON e.event_id = s.event_id
WHERE s.session_id IS NULL;