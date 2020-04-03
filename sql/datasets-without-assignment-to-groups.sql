SELECT "Dataset Title", Organisation[1], 'https://ckan.myclimateservice.eu/dataset/' || "Dataset Name" AS URL FROM 
  (SELECT package.name as "Dataset Name", package.title as "Dataset Title", array_agg(grp.title) as Organisation FROM package 
     JOIN MEMBER member ON member.table_id = package.id AND member.state = 'active'
     LEFT JOIN "group" as grp ON grp.id = member.group_id AND grp.state = 'active'  
        --and g.is_organization = true
     GROUP BY package.name, package.title HAVING COUNT(grp.id) = 1) as foo
	 ORDER BY Organisation[1], "Dataset Name"