-- add extension
create extension pg_cron;
-- examples
SELECT cron.schedule('nightly-vacuum', '0 10 * * *', 'VACUUM'); -- add new job
SELECT cron.unschedule(2); -- remove job with id
select * from cron.job; -- all running jobs
select * from cron.job_run_details; -- all finished jobs

