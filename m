From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: rculfhash alternative allocator?
Date: Tue, 22 Oct 2013 05:16:14 +0000 (UTC)
Message-ID: <399935727.47162.1382418974675.JavaMail.zimbra__44782.8324548484$1382419028$gmane$org@efficios.com>
References: <20131018181125.114c20aa@nehalam.linuxnetplumber.net>
	<1675163151.47155.1382418871096.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VYUKK-0002qV-KV
	for lttng-dev@lists.lttng.org; Tue, 22 Oct 2013 01:16:22 -0400
In-Reply-To: <1675163151.47155.1382418871096.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

(replying to my own reply, fixing the lttng-dev mailing list address)

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Stephen Hemminger" <stephen@networkplumber.org>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lttng-dev@list.lttng.org
> Sent: Tuesday, October 22, 2013 6:14:31 AM
> Subject: Re: rculfhash alternative allocator?
> 
> ----- Original Message -----
> > From: "Stephen Hemminger" <stephen@networkplumber.org>
> > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Paul E.
> > McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: lttng-dev@list.lttng.org
> > Sent: Saturday, October 19, 2013 2:11:25 AM
> > Subject: rculfhash alternative allocator?
> 
> Hi Stephen,
> 
> > 
> > Would it be possible to expose the allocation handle for RCU lfhash?
> > In the Intel DPDK there is support for a version of malloc that allocates
> > out of the huge page pool. This is a fixed memory area that has lower
> > overhead because it is covered by a single TLB entry.
> > 
> > Internally rculfhash supports changing allocators but it doesn't have
> > an exposed API (for LGPL apps).
> 
> Well actually, rculfhash does expose an API allowing exactly this. If we look
> at URCU 0.8.0 _cds_lfht_new(), it takes a const struct cds_lfht_mm_type *mm
> parameter, which can be provided by the hash table user. Given it is not a
> typical use-case, this is hidden by the cds_lfht_new() wrapper, but the
> underscore-prefixed version can be used by advanced users.
> 
> The callbacks that need to be implemented by a memory management plugin are
> detailed in urcu/rculfhash.h too:
> 
> struct cds_lfht_mm_type {
>         struct cds_lfht *(*alloc_cds_lfht)(unsigned long
>         min_nr_alloc_buckets,
>                         unsigned long max_nr_buckets);
>         void (*alloc_bucket_table)(struct cds_lfht *ht, unsigned long order);
>         void (*free_bucket_table)(struct cds_lfht *ht, unsigned long order);
>         struct cds_lfht_node *(*bucket_at)(struct cds_lfht *ht,
>                         unsigned long index);
> };
> 
> So my recommendation would be to create a new memory management plugin
> derived from one already closely matching your constraints.
> 
> Thoughts ?
> 
> > 
> > 
> > Ps: would be good to add mailing list to README?
> > 
> 
> I wanted to wait until we create a mailing list specifically for URCU, but
> indeed, it might not hurt to point to the lttng-dev mailing list meanwhile.
> I've just added it to the README file.
> 
> Thanks!
> 
> Mathieu
> 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
