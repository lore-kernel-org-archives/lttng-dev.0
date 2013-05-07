From: Richard Braun <rbraun@sceen.net>
Subject: Re: Quick questions about liburcu and RCU in general
Date: Tue, 7 May 2013 16:51:12 +0200
Message-ID: <20130507145112.GA29086__20684.9503600553$1367938305$gmane$org@mail.sceen.net>
References: <20130507094636.GA6151@mail.sceen.net>
	<20130507115914.GB3875@Krystal>
	<20130507142352.GA3648@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from shattrath.sceen.net ([94.23.252.191] helo=mail.sceen.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rbraun@sceen.net>) id 1UZjEX-0002Vg-Bs
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 10:51:13 -0400
Content-Disposition: inline
In-Reply-To: <20130507142352.GA3648@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On Tue, May 07, 2013 at 07:23:52AM -0700, Paul E. McKenney wrote:
> Yes, LGPLv2+ allows you to migrate to LGPLv3+, which is compatible with
> GPLv3+.  So as long as you derive the code from lttng's userspace-rcu
> library, you are set.
> 
> That said, you could also just link userspace-rcu into your GPLv3+
> application.

My question is rather about the techniques than the existing
implementations. Is it safe to implement RCU in an unrelated project under
GPLv3+, considering it's patented ?

-- 
Richard Braun
