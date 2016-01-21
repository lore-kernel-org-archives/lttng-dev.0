From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [rp] [RFC PATCH urcu] urcu_ref_get: API change:
	return boolean
Date: Thu, 21 Jan 2016 08:59:44 -0800
Message-ID: <20160121165944.GA30140__33390.6605876566$1453395636$gmane$org@cloud>
References: <1453237059-8879-1-git-send-email-mathieu.desnoyers@efficios.com>
 <454299411.1865.1453394720076.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <josh@joshtriplett.org>) id 1aMIaK-0001iP-Bg
 for lttng-dev@lists.lttng.org; Thu, 21 Jan 2016 11:59:49 -0500
Content-Disposition: inline
In-Reply-To: <454299411.1865.1453394720076.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rp@svcs.cs.pdx.edu, Lai Jiangshan <jiangshanlai@gmail.com>, Chris Mason <clm@fb.com>, lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On Thu, Jan 21, 2016 at 04:45:20PM +0000, Mathieu Desnoyers wrote:
> ----- On Jan 19, 2016, at 3:57 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > This is a RFC of a follow up patch based on urcu commit 7d7c5d467 "Fix:
> > handle reference count overflow".
> > 
> > Change the urcu_ref_get prototype to return a boolean, which takes the
> > value false if a LONG_MAX overflow would occur (get has not been
> > performed), or true otherwise.
> > 
> > This interface change also introduces a "warn_unused_result" gcc
> > function attribute, which will show warnings if users don't handle the
> > return value.
> > 
> > I'm wondering whether this change is useful enough to justify breaking
> > the API (need to bump the major library version), or if introducing a
> > new "urcu_ref_get_safe()" or such would be a better option ?
> 
> After some thinking, I will go for adding a new urcu_ref_get_safe() API,
> thus not requiring to bump the library major version.

You may want to add a deprecated __attribute__ to the unsafe version in
the header.

- Josh Triplett
