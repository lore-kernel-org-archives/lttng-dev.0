From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: baddr feature triggers deadlock in lttng-ust
Date: Fri, 28 Feb 2014 00:07:51 +0000 (UTC)
Message-ID: <864476638.31953.1393546071335.JavaMail.zimbra__17764.3066308976$1393546135$gmane$org@efficios.com>
References: <561294755.31915.1393536606539.JavaMail.zimbra@efficios.com>
	<530FCC33.4050200@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJAzY-00037F-Gp
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 19:07:58 -0500
In-Reply-To: <530FCC33.4050200@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

As fixing it will very likely require a major rethinking of the locking strategy
for the entire UST, I'm not very keen to make that kind of change within stable
versions.

Unless an elegant solution shows up by tomorrow, I plan to disable the feature
(leaving the code there), and think up a solution for 2.5.

Thoughts ?

Thanks,

Mathieu

----- Original Message -----
> From: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Paul Woegerer" <paul_woegerer@mentor.com>, lttng-dev@lists.lttng.org
> Sent: Thursday, February 27, 2014 6:37:23 PM
> Subject: Re: [lttng-dev] baddr feature triggers deadlock in lttng-ust
> 
> Could it be hidden behind a non-default configure option, instead of
> completely removed?
> 
> Alex
> 
> 
> On 14-02-27 04:30 PM, Mathieu Desnoyers wrote:
> > Hi Paul,
> >
> > Please see http://bugs.lttng.org/issues/745, which explains a deadlock
> > we just found out.
> >
> > We might have to disable the baddr dump feature, since our release is
> > tomorrow. We'll have to re-think our locking to protect operations
> > using the dynamic loader lock against fork, clone, and daemon.
> >
> > Thanks,
> >
> > Mathieu
> >
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
