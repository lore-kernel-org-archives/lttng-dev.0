From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Patch LTTng-ust 6/7] Add the macros to generate
 the data structures for CTF named enumerations
Date: Mon, 3 Feb 2014 16:17:31 +0000 (UTC)
Message-ID: <627045971.18225.1391444251887.JavaMail.zimbra__17893.104060977$1391444317$gmane$org@efficios.com>
References: <1390593885-7463-1-git-send-email-gbastien+lttng@versatic.net>
	<1390593885-7463-7-git-send-email-gbastien+lttng@versatic.net>
	<1490865069.16181.1391132259063.JavaMail.zimbra@efficios.com>
	<52EB0287.4000105@mentor.com>
	<1044692147.17858.1391441334987.JavaMail.zimbra@efficios.com>
	<52EFB89A.6040905@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAMDH-0004uf-6u
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 11:17:40 -0500
In-Reply-To: <52EFB89A.6040905@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Stefan Seefeld" <stefan_seefeld@mentor.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Monday, February 3, 2014 10:41:14 AM
> Subject: Re: [lttng-dev] [Patch LTTng-ust 6/7] Add the macros to generate the data structures for CTF named
> enumerations
> 
> On 02/03/2014 10:28 AM, Mathieu Desnoyers wrote:
> 
> > Hi Stefan,
> > 
> > Let's try to make sure I understand your intent here. Let's say we have
> > an event with a "weight" field (uint32_t). You would like to have
> > a multiplicative factor (e.g. *1000 for "kg") as a second field, that would
> > be entirely known from the metadata (pretty much a C literal in the
> > metadata,
> > so it does not have to be repeated for each event).
> 
> Right. The analogy with a C literal isn't entirely sufficient, as there
> is a range of situations where in fact "constant" doesn't map to
> compile-time constant in C/C++. Thus...

Can you provide a concrete example of what you envision ? What would
this look like an an "extended" CTF metadata ?

Thanks,

Mathieu

> 
> > There are various ways to do this I imagine: e.g.:
> > 
> > * Using the typing system
> 
> 
> [...]
> 
> ...the typing system can't quite capture values that are immutable
> within a running session, but not quite constant in the sense that they
> can be captured in a type system.
> 
> So perhaps another way to look at it is like a static class member, for
> which storage isn't part of each instance of the class, but rather
> somewhere that's associated with all instances of the class...
> 
> > But I don't see anything there that requires adding any top-level construct
> > to the CTF metadata.
> 
> ...and that "somewhere" would naturally be the metadata section of the
> traces.
> 
> > Hence, I am tempted to keep the name "global type declaration"
> > for the part of metadata located in the "global" section (opposed to within
> > a
> > trace, env, stream, and event scope). Anyway, all we can declare there are
> > types,
> > so it makes sense to use this name. If we ever add something to the CTF
> > spec in the
> > future that is global but is not a type, then we'll have to extend the
> > interfaces
> > and implementations (which should be expected if we extend the CTF spec).
> 
> Right. I wasn't arguing so much against the use of "global type
> declaration" for the case of named enums, but merely wanted to point out
> that the mechanism could be extended to cover non-type-related metadata.
> 
> Thanks,
> 		Stefan
> 
> 
> --
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
