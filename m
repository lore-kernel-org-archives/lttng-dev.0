From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: New article about Userspace RCU on LWN
Date: Tue, 19 Nov 2013 14:55:44 +0000 (UTC)
Message-ID: <68750827.70735.1384872944475.JavaMail.zimbra__48782.4123389602$1384873031$gmane$org@efficios.com>
References: <226335696.70249.1384791646740.JavaMail.zimbra@efficios.com>
	<528B265F.1000500@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VimiV-00078n-90
	for lttng-dev@lists.lttng.org; Tue, 19 Nov 2013 09:55:57 -0500
In-Reply-To: <528B265F.1000500@free.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Duncan Sands <baldrick@free.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Duncan Sands" <baldrick@free.fr>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, November 19, 2013 3:50:39 AM
> Subject: Re: [lttng-dev] New article about Userspace RCU on LWN
> 
> Hi Mathieu, nice articles, now I can point my co-workers at it when they ask
> me
> what this RCU stuff is all about :)  I noticed that the article
>   http://lwn.net/Articles/573431/
> says
> 
> "The hash table can then be allocated:
> 
>      ht = cds_lfht_new(1, 1, 0, CDS_LFHT_AUTO_RESIZE, NULL);
>   The first 1 specifies the initial number of hash buckets in the table, the
>   second 1 specifies the minimum number of hash buckets, and the 0 specifies
>   the
>   maximum number of hash buckets. All three quantities must be powers of two,
>   except for the special case of 0 for the third argument, which specifies an
>   unlimited maximum number of hash buckets."
> 
> However the rculfhash.h header doesn't say that the third argument can be
> zero.
> All it says is:
> 
>   * @max_nr_buckets: the maximum number of hash table buckets allowed.
>   *                  (must be power of two)

Hi Duncan,

I'm glad you like the paper! Indeed, this info was missing from the source code. I just pushed a commit that fixes things up.

Thanks!

Mathieu

> 
> Best wishes, Duncan.
> 
> On 18/11/13 17:20, Mathieu Desnoyers wrote:
> > Hi,
> >
> > Paul McKenney, Lai Jianshan, Josh Triplett and myself just published a
> > series of articles on Userspace RCU on Linux Weekly News. You can find the
> > top-level article at this URL:
> >
> > https://lwn.net/Articles/573424/
> >
> > Those articles introduce the Userspace RCU library, explaining how to use
> > RCU and the data structures it contains. Access to those articles is
> > restricted to LWN subscribers for a week after publication, and should be
> > freely available afterward.
> >
> > Feedback is welcome!
> >
> > Thanks,
> >
> > Mathieu
> >
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
