From: Junchang Wang <junchangwang@gmail.com>
Subject: [PATCH v2 0/4] userspace-rcu: Add lock-free,
 ordered singly linked list
Date: Mon, 29 Jul 2019 21:35:27 +0800
Message-ID: <1564407331-25820-1-git-send-email-junchangwang__22168.3702942514$1564407408$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 by lists.lttng.org (Postfix) with ESMTPS id 45y11X6zg6z17wj
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 09:36:32 -0400 (EDT)
Received: by mail-pl1-x644.google.com with SMTP id b7so27580376pls.6
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 06:36:32 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
Cc: paulmck@linux.ibm.com
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu and the list,

I'm recently using userspace-rcu to build lock-free data structures. Thanks for
sharing this excellent project!

In building a hash table, I am looking for an ordered singly linked list
that is lock-free. It seems such a list is missing in userspace-rcu. I
discussed this with Paul in the mailing list of perfbook, and he kindly
suggested me to submit my implementation to userspace-rcu. So here is the
RFC. Any comments and suggestions are warmly welcome.

This singly linked list is based on the following research paper:
 - Maged M. Michael. High performance dynamic lock-free hash tables
   and list-based sets. In Proceedings of the fourteenth annual ACM
   symposium on Parallel algorithms and architectures, ACM Press,
   (2002), 73-82.

And we made the following two major improvements:
 (1) Insert, Delete, and Find operations are protected by RCU read_lock,
     such that the existence guarantees are provided by the RCU mechanism,
     and that no special memory management schemes (e.g., hazard pointers)
     is required anymore.
 (2) The use of the RCU mechanism can naturally prevent the ABA problem,
     such that no flag field is required in this implementation. Hence,
     we save a variable of 8 bytes (typically sizeof(long)) for each node.

In the past two weeks, I found some bugs in the first version of the
list in building a lock-free hash table on top it. So this is the second
version which fixes the known issues. Please review this version, if
possible. The major changes are as follows. Sorry for the inconvenience.
Any suggestions and comments are warmly welcome.

v1 -> v2:
  - Functions insert(), delete(), and find() return 0 in success, and
    return -Exxx otherwise.
  - Fix a bug in function is_removed().

Cheers,
--Junchang

Junchang Wang (4):
  userspace-rcu: Add lock-free singly linked list rculflist
  userspace-rcu: Add sample code of rculflist
  userspace-rcu: Update Makefile.am to include rculflist into the
    project
  userspace-rcu: Add a brief description of rculflist in cds-api.md

 doc/cds-api.md                                     |   7 +
 doc/examples/rculflist/Makefile                    |  24 ++
 .../rculflist/Makefile.cds_lflist_delete_rcu       |  21 ++
 .../rculflist/Makefile.cds_lflist_find_rcu         |  21 ++
 .../rculflist/Makefile.cds_lflist_insert_rcu       |  21 ++
 doc/examples/rculflist/cds_lflist_delete_rcu.c     | 101 ++++++++
 doc/examples/rculflist/cds_lflist_find_rcu.c       |  96 +++++++
 doc/examples/rculflist/cds_lflist_insert_rcu.c     |  69 +++++
 include/Makefile.am                                |   1 +
 include/urcu/cds.h                                 |   1 +
 include/urcu/rculflist.h                           | 284 +++++++++++++++++++++
 11 files changed, 646 insertions(+)
 create mode 100644 doc/examples/rculflist/Makefile
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_find_rcu
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
 create mode 100644 doc/examples/rculflist/cds_lflist_delete_rcu.c
 create mode 100644 doc/examples/rculflist/cds_lflist_find_rcu.c
 create mode 100644 doc/examples/rculflist/cds_lflist_insert_rcu.c
 create mode 100644 include/urcu/rculflist.h

-- 
1.8.3.1
