From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] urcu: add notice to URCU_TLS() for	it
 is not async-signal-safe
Date: Fri, 10 Aug 2012 11:23:02 +0800
Message-ID: <50247E96.9080909__43504.907450597$1344568963$gmane$org@cn.fujitsu.com>
References: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>	<1344414673-14714-2-git-send-email-laijs@cn.fujitsu.com>	<20120809141417.GC9064@Krystal>	<CACvQF53CY6UuoZzDzT-VE25wAyaNa_r=0vsOdTVzVF6dmScH1g@mail.gmail.com>
	<20120809200211.GA14409@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1Szfnb-00008V-Bm
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 23:22:07 -0400
In-Reply-To: <20120809200211.GA14409@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>
List-Id: lttng-dev@lists.lttng.org

On 08/10/2012 04:02 AM, Mathieu Desnoyers wrote:
> Looking at the result of a quick google search:
> 
> http://curl.haxx.se/mail/lib-2006-09/0224.html
> http://www.slamb.org/projects/sigsafe/api/patternref.html
> 
> "Additionally, it makes the same assumption as all other methods for
> handling thread-directed signals (with the exception of kevent(2)
> handling), that pthread_getspecific(2) is async signal-safe. This is not
> guaranteed by SUSv3."
> 
> and
> 
> https://groups.google.com/forum/?fromgroups#!topic/comp.os.linux.development/nZfmndKbzJw[1-25]
> 
> it looks like using pthread_getspecific from a signal handler is not
> always safe, mainly due to possible use of sigaltstack. So disabling
> signals works for the "pthread_key_create" part, but we still have an
> issue with pthread_getspecific.
> 
> Ideas are welcome on how to best deal with this issue.

What's the problem with disabling signals + pthread_getspecific()?
Waht's the problem with disabling signals + __tls_access_ ## name()?
