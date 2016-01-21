From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [rp] [RFC PATCH urcu] urcu_ref_get: API change:
	return boolean
Date: Thu, 21 Jan 2016 13:59:35 -0800
Message-ID: <20160121215935.GA31648__32590.5157639228$1453413634$gmane$org@cloud>
References: <1453237059-8879-1-git-send-email-mathieu.desnoyers@efficios.com>
 <454299411.1865.1453394720076.JavaMail.zimbra@efficios.com>
 <20160121165944.GA30140@cloud>
 <1634246639.1893.1453395969036.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <josh@joshtriplett.org>) id 1aMNGV-0003Rr-Qj
 for lttng-dev@lists.lttng.org; Thu, 21 Jan 2016 16:59:43 -0500
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
Cc: rp@svcs.cs.pdx.edu, Lai Jiangshan <jiangshanlai@gmail.com>, Chris Mason <clm@fb.com>, lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
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

Ah.  In that case, nevermind.  Deprecation would make sense for a
version that can still overflow, but if you no longer have any such
version, great!

- Josh Triplett
