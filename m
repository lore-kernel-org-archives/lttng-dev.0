From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 4/5] fix: mm: move
 recent_rotated pages calculation to shrink_inactive_list() (v5.2)
Date: Tue, 21 May 2019 16:53:36 -0400 (EDT)
Message-ID: <1045726286.6695.1558472016130.JavaMail.zimbra__35641.436166928$1558472032$gmane$org@efficios.com>
References: <20190521203314.8577-1-mjeanson@efficios.com>
 <20190521203314.8577-4-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 457nzk0mZ2z10bK
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 16:53:37 -0400 (EDT)
In-Reply-To: <20190521203314.8577-4-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel <linux-kernel@vger.kernel.org>, rostedt <rostedt@goodmis.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 21, 2019, at 4:33 PM, Michael Jeanson mjeanson@efficios.com wrote:

> See upstream commit:
> 
>  commit 886cf1901db962cee5f8b82b9b260079a5e8a4eb
>  Author: Kirill Tkhai <ktkhai@virtuozzo.com>
>  Date:   Mon May 13 17:16:51 2019 -0700
> 
>    mm: move recent_rotated pages calculation to shrink_inactive_list()
> 
>    Patch series "mm: Generalize putback functions"]
> 
>    putback_inactive_pages() and move_active_pages_to_lru() are almost
>    similar, so this patchset merges them ina single function.
> 
>    This patch (of 4):
> 
>    The patch moves the calculation from putback_inactive_pages() to
>    shrink_inactive_list().  This makes putback_inactive_pages() looking more
>    similar to move_active_pages_to_lru().
> 
>    To do that, we account activated pages in reclaim_stat::nr_activate.
>    Since a page may change its LRU type from anon to file cache inside
>    shrink_page_list() (see ClearPageSwapBacked()), we have to account pages
>    for the both types.  So, nr_activate becomes an array.
> 
>    Previously we used nr_activate to account PGACTIVATE events, but now we
>    account them into pgactivate variable (since they are about number of
>    pages in general, not about sum of hpage_nr_pages).
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> instrumentation/events/lttng-module/mm_vmscan.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/mm_vmscan.h
> b/instrumentation/events/lttng-module/mm_vmscan.h
> index 417472c..3f9ffde 100644
> --- a/instrumentation/events/lttng-module/mm_vmscan.h
> +++ b/instrumentation/events/lttng-module/mm_vmscan.h
> @@ -625,7 +625,8 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
> 		ctf_integer(unsigned long, nr_writeback, stat->nr_writeback)
> 		ctf_integer(unsigned long, nr_congested, stat->nr_congested)
> 		ctf_integer(unsigned long, nr_immediate, stat->nr_immediate)
> -		ctf_integer(unsigned long, nr_activate, stat->nr_activate)
> +		ctf_integer(unsigned long, nr_activate0, stat->nr_activate[0])
> +		ctf_integer(unsigned long, nr_activate1, stat->nr_activate[1])

This patch is for lttng-modules, but I'm adding Kirill Tkhai (author of the Linux
kernel commit causing the need for this change in lttng-modules) and Steven Rostedt
in CC, because I feel they might want to join this discussion naming of
userspace-visible TRACE_EVENT() fields.

Based on the upstream Linux commit, it looks like only the TP_printk() has
sane names for event fields, but could really improve on the naming for the
binary version of those fields:

-       TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate=%ld nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+       TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
                __entry->nid,
                __entry->nr_scanned, __entry->nr_reclaimed,
                __entry->nr_dirty, __entry->nr_writeback,
                __entry->nr_congested, __entry->nr_immediate,
-               __entry->nr_activate, __entry->nr_ref_keep,
-               __entry->nr_unmap_fail, __entry->priority,
+               __entry->nr_activate0, __entry->nr_activate1,
+               __entry->nr_ref_keep, __entry->nr_unmap_fail,
+               __entry->priority,
                show_reclaim_flags(__entry->reclaim_flags))
 );

So I recommend we do the following in lttng-modules:

Rename the field nr_activate0 to nr_activate_anon,
Rename the field nr_activate1 to nr_activate_file.

So users can make something out of those tracepoints without digging
into the kernel source code.

Even if Steven and Kirill end up choosing to change the name of those
fields upstream in trace-event, it won't have any impact on lttng-modules.

It would make sense to change those newly introduced exposed names in the
upstream kernel as well though.

Thanks,

Mathieu


> 		ctf_integer(unsigned long, nr_ref_keep, stat->nr_ref_keep)
> 		ctf_integer(unsigned long, nr_unmap_fail, stat->nr_unmap_fail)
> 		ctf_integer(int, priority, priority)
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
