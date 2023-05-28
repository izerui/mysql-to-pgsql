~/dev/pgloader ./build/bin/pgloader --with "batch rows = 1000" mysql://root@localhost/skippr pgsql:///skippr
2016-01-25T00:18:06.161000+01:00 LOG Main logs in '/private/tmp/pgloader/pgloader.log'
2016-01-25T00:18:06.165000+01:00 LOG Data errors in '/private/tmp/pgloader/'
             table name       read   imported     errors      total time       read      write
-----------------------  ---------  ---------  ---------  --------------  ---------  ---------
        fetch meta data          6          6          0          0.556s
           create, drop          0          0          0          0.258s
-----------------------  ---------  ---------  ---------  --------------  ---------  ---------
                  posts     994163     994163          0         43.193s    46.827s   43.192s
-----------------------  ---------  ---------  ---------  --------------  ---------  ---------
COPY Threads Completion          3          3          0        1m7.498s
 Index Build Completion          5          5          0         49.297s
         Create Indexes          5          5          0       1m31.614s
        Reset Sequences          0          0          0          0.268s
           Primary Keys          1          1          0          0.019s
           Foreign Keys          0          0          0          0.000s
       Install comments          0          0          0          0.000s
-----------------------  ---------  ---------  ---------  --------------  ---------  ---------
      Total import time     994163     994163          0       1m58.295s    46.827s   43.192s