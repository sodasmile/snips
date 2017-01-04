select segment_name, sum(bytes)/1024/1024 "Size MB" from dba_extents where lower(segment_name) like 'idx_%'
group by segment_name
order by "Size MB" desc;

