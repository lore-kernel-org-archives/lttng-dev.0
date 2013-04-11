From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC lttng-tools] Triggers
Date: Thu, 11 Apr 2013 13:26:40 -0400
Message-ID: <5166F250.1030605__2724.06248045645$1365701232$gmane$org@efficios.com>
References: <5166DFE7.8020802@efficios.com> <5166E51C.4030604@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UQLGl-0001N5-RA
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 13:26:43 -0400
In-Reply-To: <5166E51C.4030604@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



Julien Desfossez:
>> Hi everyone,
>>
>> Here is the second RFC of the day.
>>
>> By reading this, your imagination will probably go pretty crazy with
>> possibilities ;). The first implementation will only have one option
>> describe in the RFC but note that with this kind of feature, the sky is
>> the limit! and of course world domination is never far.
> 
> illustrace --> illustrate
> 
> "take a snapshot of the session where this" --> "take a snapshot of all
> the sessions where this"
> 
> I would propose to add a "command" option to trigger, in order to allow
> to add, list and del triggers, also a trigger name/alias might become
> useful really soon.
> 
> Maybe something like that ?
> $ lttng trigger [OPTIONS] {add|list|del} <NAME> <WHAT/WHERE> <ACTION>

Hmmm yea, I think this will come handy in the future.

> 
> Thanks,
> 
> Julien
