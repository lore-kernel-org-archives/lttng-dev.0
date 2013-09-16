From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES PATCH 4/4] Metadata flush writes data from
	the cache
Date: Mon, 16 Sep 2013 13:29:42 -0400
Message-ID: <20130916172942.GA25658__28617.0511194088$1379352637$gmane$org@Krystal>
References: <1379344713-9185-1-git-send-email-jdesfossez@efficios.com>
	<1379344713-9185-4-git-send-email-jdesfossez@efficios.com>
	<20130916163632.GD25275@Krystal> <52373E6B.3050109@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VLccL-0005Wu-LT
	for lttng-dev@lists.lttng.org; Mon, 16 Sep 2013 13:29:51 -0400
Content-Disposition: inline
In-Reply-To: <52373E6B.3050109@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> Hi,
> 
> On 13-09-16 12:36 PM, Mathieu Desnoyers wrote:
[...]
> > This comment says "Before doing the actual rb flush". But where is it
> > done ? Do we need it at all, or is it done by the following get_subbuf ?
> > I think the code might be right, but the comment does not match the
> > implementation.
> When we exit this switch, we end up in lib_ring_buffer_ioctl() performs
> the RB flush.
> 
> Is it ok ?

yep, I missed that. All good then, merging,

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
