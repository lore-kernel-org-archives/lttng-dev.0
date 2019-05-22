From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: [PATCH v2] mm: Rename mm_vmscan_lru_shrink_inactive
 trace event variables
Date: Wed, 22 May 2019 10:39:44 -0400
Message-ID: <a187c72c-9ca2-7668-fc60-e9c310c30d5c__19646.2981448107$1558536016$gmane$org@gydle.com>
References: <155851455676.7870.1951762540769724271.stgit@localhost.localdomain>
 <9b9a8da4-556a-8972-cf87-071ce5099ad0@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 458Ff071Dsz12WM
 for <lttng-dev@lists.lttng.org>; Wed, 22 May 2019 10:39:52 -0400 (EDT)
In-Reply-To: <9b9a8da4-556a-8972-cf87-071ce5099ad0@virtuozzo.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org, mjeanson@efficios.com, rostedt@goodmis.org, lttng-dev@lists.lttng.org, linux-kernel@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org



On 2019-05-22 6:17 a.m., Kirill Tkhai wrote:
> Rename nr_activate{0,1} into nr_activate{anon,file} since this

Rename nr_activate{0,1} into nr_activate{anon,file}
                                        ^
                                         add an underscore here
 (nr_activate_anon, nr_activate_file).


> is exported into userspace, e.g., it's shown here:
> 
> /sys/kernel/debug/tracing/events/vmscan/mm_vmscan_lru_shrink_inactive/format
> 
> v2: Changed suggested person (sorry, Mathieu :))
> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/trace/events/vmscan.h |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index a5ab2973e8dc..c316279715f4 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -348,8 +348,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>  		__field(unsigned long, nr_writeback)
>  		__field(unsigned long, nr_congested)
>  		__field(unsigned long, nr_immediate)
> -		__field(unsigned int, nr_activate0)
> -		__field(unsigned int, nr_activate1)
> +		__field(unsigned int, nr_activate_anon)
> +		__field(unsigned int, nr_activate_file)
>  		__field(unsigned long, nr_ref_keep)
>  		__field(unsigned long, nr_unmap_fail)
>  		__field(int, priority)
> @@ -364,8 +364,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>  		__entry->nr_writeback = stat->nr_writeback;
>  		__entry->nr_congested = stat->nr_congested;
>  		__entry->nr_immediate = stat->nr_immediate;
> -		__entry->nr_activate0 = stat->nr_activate[0];
> -		__entry->nr_activate1 = stat->nr_activate[1];
> +		__entry->nr_activate_anon = stat->nr_activate[0];
> +		__entry->nr_activate_file = stat->nr_activate[1];
>  		__entry->nr_ref_keep = stat->nr_ref_keep;
>  		__entry->nr_unmap_fail = stat->nr_unmap_fail;
>  		__entry->priority = priority;
> @@ -377,7 +377,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>  		__entry->nr_scanned, __entry->nr_reclaimed,
>  		__entry->nr_dirty, __entry->nr_writeback,
>  		__entry->nr_congested, __entry->nr_immediate,
> -		__entry->nr_activate0, __entry->nr_activate1,
> +		__entry->nr_activate_anon, __entry->nr_activate_file,
>  		__entry->nr_ref_keep, __entry->nr_unmap_fail,
>  		__entry->priority,
>  		show_reclaim_flags(__entry->reclaim_flags))
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
