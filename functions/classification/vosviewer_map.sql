set nocount on

-- manually create the header of the tsv output
-- sqlcmd only outputs the header with a dashed line under it
select
    'id',
    'label',
    'description',
    'cluster',
    'weight<No. of pub. ($(classification_min_pub_year_core_pub_set)-$(classification_max_pub_year_core_pub_set))>',
    'score<Avg. pub. year>'

select
    [id],
    [label],
    [description],
    [cluster],
    [weight<No. of pub. ($(classification_min_pub_year_core_pub_set)-$(classification_max_pub_year_core_pub_set))>],
    [score<Avg. pub. year>]
from vosviewer.map_$(level)_clusters
order by 1
