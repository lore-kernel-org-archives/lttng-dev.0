From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [RFC lttng-tools] Triggers
Date: Thu, 11 Apr 2013 12:30:20 -0400
Message-ID: <5166E51C.4030604__2886.61459130726$1365697851$gmane$org@efficios.com>
References: <5166DFE7.8020802@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1UQKOM-0000uS-7r
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 12:30:30 -0400
In-Reply-To: <5166DFE7.8020802@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Hi everyone,
> 
> Here is the second RFC of the day.
> 
> By reading this, your imagination will probably go pretty crazy with
> possibilities ;). The first implementation will only have one option
> describe in the RFC but note that with this kind of feature, the sky is
> the limit! and of course world domination is never far.

illustrace --> illustrate

"take a snapshot of the session where this" --> "take a snapshot of all
the sessions where this"

I would propose to add a "command" option to trigger, in order to allow
to add, list and del triggers, also a trigger name/alias might become
useful really soon.

Maybe something like that ?
$ lttng trigger [OPTIONS] {add|list|del} <NAME> <WHAT/WHERE> <ACTION>

Thanks,

Julien
