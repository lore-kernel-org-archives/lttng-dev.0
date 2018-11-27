From: Jeff Layton <jlayton@redhat.com>
Subject: making liburcu and lttng coexist in a LGPL'ed program
Date: Tue, 27 Nov 2018 13:17:55 -0500
Message-ID: <5fcdce0f9a2ed1f6e1337db191f3b97e872a8e2f.camel__47847.3106901676$1543342565$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
 [209.85.219.169])
 by lists.lttng.org (Postfix) with ESMTPS id 434Bpt5x6FzwPr
 for <lttng-dev@lists.lttng.org>; Tue, 27 Nov 2018 13:17:58 -0500 (EST)
Received: by mail-yb1-f169.google.com with SMTP id t13-v6so9459848ybb.8
 for <lttng-dev@lists.lttng.org>; Tue, 27 Nov 2018 10:17:58 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Thomas Serlin <tserlin@redhat.com>, "devel@lists.nfs-ganesha.org" <devel@lists.nfs-ganesha.org>
List-Id: lttng-dev@lists.lttng.org

The nfs-ganesha project has used lttng for quite some time to handle
tracing. Recently though, we decided to start building liburcu in as a
mandatory component, with an eye toward using it in certain areas.

Before this change, the code linked in liburcu-bp directly, but now we
just use liburcu. Unfortunately, when we enable tracepoints in the build
now, we get errors like this at link time:

--------------------8<----------------
[ 96%] Linking C executable ganesha.nfsd
/usr/bin/ld: libMainServices.a(nfs_worker_thread.c.o): undefined reference to symbol 'rcu_gp_bp'
/usr/bin/ld: //usr/lib64/liburcu-bp.so.6: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
make[2]: *** [MainNFSD/CMakeFiles/ganesha.nfsd.dir/build.make:308: MainNFSD/ganesha.nfsd] Error 1
make[1]: *** [CMakeFiles/Makefile2:2740: MainNFSD/CMakeFiles/ganesha.nfsd.dir/all] Error 2
make: *** [Makefile:152: all] Error 2
--------------------8<----------------

nfs-ganesha defines _LGPL_SOURCE, and that makes lttng use the
redefinitions in tracepoint-rcu.h. If I disable _LGPL_SOURCE, it all
builds as expected.

I found a similar bug here:

    https://bugs.lttng.org/issues/1156

Any thoughts on the right fix for this? We'd like to eat our cake and
have it too, so that we can have _LGPL_SOURCE defined, lttng enabled,
and the urcu flavor be determined at runtime.

Many thanks,
-- 
Jeff Layton <jlayton@redhat.com>
