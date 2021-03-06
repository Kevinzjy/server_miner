#!/bin/bash
export PATH=$PATH:/usr/bin:/bin:/usr/local/bin:.:/usr:.
PATH=$PATH:/usr/bin:/bin:/usr/local/bin:.:/usr:.
w |awk '{
if (NR!=1){ 
if($5 ~ /days/){ 
    split($5,d,"days");
    print d[1]*86400" "
}
else if( $5 ~ /:|s/){
    if ($5 ~/s/) { sub(/s/,"",$5); split($5,s,"."); print s[1]" " }
    else if ( $5 ~/m/) { split($5,m,":"); print (m[1]*60+m[2])*60" " }
    else { split($5,m,":"); print m[1]*60+m[2]" " }
}
}}'|sort -n|head -1
