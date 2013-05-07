From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Quick questions about liburcu and RCU in general
Date: Tue, 7 May 2013 08:24:37 -0700
Message-ID: <20130507152437.GE3648__39564.3841977746$1367940330$gmane$org@linux.vnet.ibm.com>
References: <20130507094636.GA6151@mail.sceen.net>
	<20130507115914.GB3875@Krystal>
	<20130507142352.GA3648@linux.vnet.ibm.com>
	<20130507145112.GA29086@mail.sceen.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1UZjl2-0002sB-Eg
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 11:24:48 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 7 May 2013 11:24:43 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4216238C8045
	for <lttng-dev@lists.lttng.org>; Tue,  7 May 2013 11:24:40 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r47FOeID25296940
	for <lttng-dev@lists.lttng.org>; Tue, 7 May 2013 11:24:40 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r47FRZQ7007629
	for <lttng-dev@lists.lttng.org>; Tue, 7 May 2013 09:27:35 -0600
Content-Disposition: inline
In-Reply-To: <20130507145112.GA29086@mail.sceen.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Richard Braun <rbraun@sceen.net>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On Tue, May 07, 2013 at 04:51:12PM +0200, Richard Braun wrote:
> On Tue, May 07, 2013 at 07:23:52AM -0700, Paul E. McKenney wrote:
> > Yes, LGPLv2+ allows you to migrate to LGPLv3+, which is compatible with
> > GPLv3+.  So as long as you derive the code from lttng's userspace-rcu
> > library, you are set.
> > 
> > That said, you could also just link userspace-rcu into your GPLv3+
> > application.
> 
> My question is rather about the techniques than the existing
> implementations. Is it safe to implement RCU in an unrelated project under
> GPLv3+, considering it's patented ?

I am not a lawyer, but my understanding is that the GPL patent protection
applies to derived works.  So if you start with userspace-rcu, adapt it
to your application, and relicense to GPLv3+, you should be OK.  I do
not believe this works if you do a cleanroom implementation, but again,
I am not a lawyer.

							Thanx, Paul
