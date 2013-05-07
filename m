From: Richard Braun <rbraun@sceen.net>
Subject: Re: Quick questions about liburcu and RCU in general
Date: Tue, 7 May 2013 22:07:12 +0200
Message-ID: <20130507200711.GA23006__3020.30424722961$1367957319$gmane$org@mail.sceen.net>
References: <20130507094636.GA6151@mail.sceen.net>
	<20130507115914.GB3875@Krystal>
	<20130507142352.GA3648@linux.vnet.ibm.com>
	<20130507145112.GA29086@mail.sceen.net>
	<20130507152437.GE3648@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from shattrath.sceen.net ([94.23.252.191] helo=mail.sceen.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rbraun@sceen.net>) id 1UZoAQ-0005MP-Cr
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 16:07:18 -0400
Content-Disposition: inline
In-Reply-To: <20130507152437.GE3648@linux.vnet.ibm.com>
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

On Tue, May 07, 2013 at 08:24:37AM -0700, Paul E. McKenney wrote:
> > My question is rather about the techniques than the existing
> > implementations. Is it safe to implement RCU in an unrelated project under
> > GPLv3+, considering it's patented ?
> 
> I am not a lawyer, but my understanding is that the GPL patent protection
> applies to derived works.  So if you start with userspace-rcu, adapt it
> to your application, and relicense to GPLv3+, you should be OK.  I do
> not believe this works if you do a cleanroom implementation, but again,
> I am not a lawyer.

Noted. Thank you both for your answers.

-- 
Richard Braun
