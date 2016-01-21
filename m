From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [rp] [RFC PATCH urcu] urcu_ref_get: API change:
	return boolean
Date: Thu, 21 Jan 2016 09:59:05 -0800
Message-ID: <20160121175905.GY3818__32827.2455175922$1453399222$gmane$org@linux.vnet.ibm.com>
References: <1453237059-8879-1-git-send-email-mathieu.desnoyers@efficios.com>
 <454299411.1865.1453394720076.JavaMail.zimbra@efficios.com>
 <20160121165944.GA30140@cloud>
 <1634246639.1893.1453395969036.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <paulmck@linux.vnet.ibm.com>) id 1aMJVp-000297-SM
 for lttng-dev@lists.lttng.org; Thu, 21 Jan 2016 12:59:15 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 10:59:05 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BBA2B3E40030
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jan 2016 10:59:03 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u0LHx3CP30933174
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jan 2016 10:59:03 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LHwwFd001172
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jan 2016 10:59:01 -0700
Content-Disposition: inline
In-Reply-To: <1634246639.1893.1453395969036.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rp@svcs.cs.pdx.edu, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Chris Mason <clm@fb.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Jan 21, 2016 at 05:06:09PM +0000, Mathieu Desnoyers wrote:
> ----- On Jan 21, 2016, at 11:59 AM, Josh Triplett josh@joshtriplett.org wrote:
> 
> > On Thu, Jan 21, 2016 at 04:45:20PM +0000, Mathieu Desnoyers wrote:
> >> ----- On Jan 19, 2016, at 3:57 PM, Mathieu Desnoyers
> >> mathieu.desnoyers@efficios.com wrote:
> >> 
> >> > This is a RFC of a follow up patch based on urcu commit 7d7c5d467 "Fix:
> >> > handle reference count overflow".
> >> > 
> >> > Change the urcu_ref_get prototype to return a boolean, which takes the
> >> > value false if a LONG_MAX overflow would occur (get has not been
> >> > performed), or true otherwise.
> >> > 
> >> > This interface change also introduces a "warn_unused_result" gcc
> >> > function attribute, which will show warnings if users don't handle the
> >> > return value.
> >> > 
> >> > I'm wondering whether this change is useful enough to justify breaking
> >> > the API (need to bump the major library version), or if introducing a
> >> > new "urcu_ref_get_safe()" or such would be a better option ?
> >> 
> >> After some thinking, I will go for adding a new urcu_ref_get_safe() API,
> >> thus not requiring to bump the library major version.
> > 
> > You may want to add a deprecated __attribute__ to the unsafe version in
> > the header.
> 
> The "unsafe" version now does a "abort()" in case of detected overflow,
> so it's not a security concern per-se, but could theoretically lead to
> an application denial of service.
> 
> I'm tempted to keep urcu_ref_get() as it is (not deprecate it) because
> there appears to be valid use-cases for it: for instance, if an application
> fully controls the reference counting (refcount value don't depend on
> external inputs), urcu_ref_get would still seem like a good API to use.

This seems to me to be a good tradeoff.  If experience shows that
urcu_ref_get() is "unsafe at any speed", then Josh's suggestion of
deprecating it would make a lot of sense.

							Thanx, Paul
