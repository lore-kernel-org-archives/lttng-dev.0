From: Junchang Wang <junchangwang@gmail.com>
Subject: Re: [PATCH v2 0/4] userspace-rcu: Add lock-free,
 ordered singly linked list
Date: Tue, 30 Jul 2019 21:34:19 +0800
Message-ID: <CABoNC821qnePU4Enrs8mSseVq-_Hp3Cehh93DO0+s=cKtDTZXQ__22161.6179029056$1564493686$gmane$org@mail.gmail.com>
References: <1564407331-25820-1-git-send-email-junchangwang@gmail.com>
 <1759632476.1182.1564408558415.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 by lists.lttng.org (Postfix) with ESMTPS id 45ycwm2xWjz1J7c
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2019 09:34:32 -0400 (EDT)
Received: by mail-oi1-x242.google.com with SMTP id m202so47904911oig.6
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2019 06:34:32 -0700 (PDT)
In-Reply-To: <1759632476.1182.1564408558415.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@linux.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On Mon, Jul 29, 2019 at 9:55 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jul 29, 2019, at 9:35 AM, Junchang Wang junchangwang@gmail.com wrote:
>
> > Hi Mathieu and the list,
> >
> > I'm recently using userspace-rcu to build lock-free data structures. Thanks for
> > sharing this excellent project!
> >
> > In building a hash table, I am looking for an ordered singly linked list
> > that is lock-free. It seems such a list is missing in userspace-rcu. I
> > discussed this with Paul in the mailing list of perfbook, and he kindly
> > suggested me to submit my implementation to userspace-rcu. So here is the
> > RFC. Any comments and suggestions are warmly welcome.
>
> One point worth mentioning: the rculfhash data structure (rcu lock-free hash
> table) already implements such list internally. You might want to have a look
> at it, and perhaps just lift out its implementation into a separate .c file
> and header file so we can expose its implementation publicly ?
>
> Items are linked through the struct cds_lfht_node next field.
>
> The struct cds_lfht_iter is used as a iterator on the list.
>
> struct cds_lfht tbl_oder, tbl_chunk and tbl_mmap contain the
> linked lists heads for each memory allocation scheme.

Hi Mathieu,

Thanks for the note. I checked rculfhash today, and the list
implementation within rculfhash is indeed quite similar to the one I'm
working on. I will check to see if we can merge the two versions and
provide an independent rculflist.

>
> I'm wondering why you need to re-implement a hash table though. What is
> missing from rculfhash to suit your needs ?
>

The major reason is that I want a hash table that can change its hash
function on-the-fly. Split-ordered list is not adequate because it can
only increase/decrease the number of buckets. Besides, I doubt the
reverse operation is always efficient on platforms where hardware
cannot help reverse bit strings. Hence I'm working on the new hash
table algorithm, which, of course, is built on top of the linked list
we are working on :-).

Thanks,
--Junchang

> Thanks,
>
> Mathieu
>
>
> >
> > This singly linked list is based on the following research paper:
> > - Maged M. Michael. High performance dynamic lock-free hash tables
> >   and list-based sets. In Proceedings of the fourteenth annual ACM
> >   symposium on Parallel algorithms and architectures, ACM Press,
> >   (2002), 73-82.
> >
> > And we made the following two major improvements:
> > (1) Insert, Delete, and Find operations are protected by RCU read_lock,
> >     such that the existence guarantees are provided by the RCU mechanism,
> >     and that no special memory management schemes (e.g., hazard pointers)
> >     is required anymore.
> > (2) The use of the RCU mechanism can naturally prevent the ABA problem,
> >     such that no flag field is required in this implementation. Hence,
> >     we save a variable of 8 bytes (typically sizeof(long)) for each node.
> >
> > In the past two weeks, I found some bugs in the first version of the
> > list in building a lock-free hash table on top it. So this is the second
> > version which fixes the known issues. Please review this version, if
> > possible. The major changes are as follows. Sorry for the inconvenience.
> > Any suggestions and comments are warmly welcome.
> >
> > v1 -> v2:
> >  - Functions insert(), delete(), and find() return 0 in success, and
> >    return -Exxx otherwise.
> >  - Fix a bug in function is_removed().
> >
> > Cheers,
> > --Junchang
> >
> > Junchang Wang (4):
> >  userspace-rcu: Add lock-free singly linked list rculflist
> >  userspace-rcu: Add sample code of rculflist
> >  userspace-rcu: Update Makefile.am to include rculflist into the
> >    project
> >  userspace-rcu: Add a brief description of rculflist in cds-api.md
> >
> > doc/cds-api.md                                     |   7 +
> > doc/examples/rculflist/Makefile                    |  24 ++
> > .../rculflist/Makefile.cds_lflist_delete_rcu       |  21 ++
> > .../rculflist/Makefile.cds_lflist_find_rcu         |  21 ++
> > .../rculflist/Makefile.cds_lflist_insert_rcu       |  21 ++
> > doc/examples/rculflist/cds_lflist_delete_rcu.c     | 101 ++++++++
> > doc/examples/rculflist/cds_lflist_find_rcu.c       |  96 +++++++
> > doc/examples/rculflist/cds_lflist_insert_rcu.c     |  69 +++++
> > include/Makefile.am                                |   1 +
> > include/urcu/cds.h                                 |   1 +
> > include/urcu/rculflist.h                           | 284 +++++++++++++++++++++
> > 11 files changed, 646 insertions(+)
> > create mode 100644 doc/examples/rculflist/Makefile
> > create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
> > create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_find_rcu
> > create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
> > create mode 100644 doc/examples/rculflist/cds_lflist_delete_rcu.c
> > create mode 100644 doc/examples/rculflist/cds_lflist_find_rcu.c
> > create mode 100644 doc/examples/rculflist/cds_lflist_insert_rcu.c
> > create mode 100644 include/urcu/rculflist.h
> >
> > --
> > 1.8.3.1
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
