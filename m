From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [RFC 0/4] userspace-rcu: Add lock-free,
 ordered singly linked list rculflist
Date: Wed, 10 Jul 2019 11:14:10 -0400
Message-ID: <20190710151410.GB3812__38076.5244293556$1562771677$gmane$org@joraj-alpa>
References: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45kN561xrqz16YN
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jul 2019 11:14:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Junchang Wang <junchangwang@gmail.com>
Cc: lttng-dev@lists.lttng.org, paulmck@linux.ibm.com
List-Id: lttng-dev@lists.lttng.org

Hi Junchang,

Thanks for contributing to URCU.

I just wanted to let you know that Mathieu is currently on vacation for ~2 weeks
so do not expect much feedback until his return.

Cheers

On Wed, Jul 10, 2019 at 11:28:06AM +0800, Junchang Wang wrote:
> Hi Mathieu and the list,
> 
> I'm recently using userspace-rcu to build lock-free data structures. Thanks for
> sharing this excellent project!
> 
> In building a hash table, I am looking for an ordered singly linked list
> that is lock-free. It seems such a list is missing in userspace-rcu. I
> discussed this with Paul in the mailing list of perfbook, and he kindly
> suggested me to submit my implementation to userspace-rcu. So here is the
> RFC. Any comments and suggestions are warmly welcome.
> 
> This singly linked list is based on the following research paper:
>  - Maged M. Michael. High performance dynamic lock-free hash tables
>    and list-based sets. In Proceedings of the fourteenth annual ACM
>    symposium on Parallel algorithms and architectures, ACM Press,
>    (2002), 73-82.
> 
> And this implementation has the following unique features:
>  (1) Insert, Delete, and Find operations are protected by RCU read_lock,
>      such that the existence guarantees are provided by the RCU mechanism,
>      and that no special memory management schemes (e.g., hazard pointers)
>      is required anymore.
>  (2) The use of the RCU mechanism can naturally prevent the ABA problem,
>      such that no flag field is required in this implementation. Hence,
>      we save a long integer (typically 8 bytes) for each node.
> 
> This is my first patch to this mailing list, so please let me know if
> I messed anything up. Any comments and suggestions are warmly welcome.
> 
> Thanks,
> --Junchang
> 
> Junchang Wang (4):
>   userspace-rcu: Add lock-free singly linked list rculflist
>   userspace-rcu: Add sample code of rculflist
>   userspace-rcu: Update Makefile.am to include rculflist into the
>     project
>   userspace-rcu: Add a brief description of rculflist in cds-api.md
> 
>  doc/cds-api.md                                     |   7 +
>  doc/examples/Makefile.am                           |  13 +-
>  .../rculflist/Makefile.cds_lflist_delete_rcu       |  21 ++
>  .../rculflist/Makefile.cds_lflist_find_rcu         |  21 ++
>  .../rculflist/Makefile.cds_lflist_insert_rcu       |  21 ++
>  doc/examples/rculflist/cds_lflist_delete_rcu.c     | 100 ++++++++
>  doc/examples/rculflist/cds_lflist_find_rcu.c       |  96 +++++++
>  doc/examples/rculflist/cds_lflist_insert_rcu.c     |  66 +++++
>  include/Makefile.am                                |   1 +
>  include/urcu/cds.h                                 |   1 +
>  include/urcu/rculflist.h                           | 279 +++++++++++++++++++++
>  11 files changed, 625 insertions(+), 1 deletion(-)
>  create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
>  create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_find_rcu
>  create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
>  create mode 100644 doc/examples/rculflist/cds_lflist_delete_rcu.c
>  create mode 100644 doc/examples/rculflist/cds_lflist_find_rcu.c
>  create mode 100644 doc/examples/rculflist/cds_lflist_insert_rcu.c
>  create mode 100644 include/urcu/rculflist.h
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan Rajotte-Julien
EfficiOS
