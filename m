From: Henrik Hautakoski <henrik@fiktivkod.org>
Subject: Re: More LTTng problems
Date: Mon, 20 Aug 2012 16:13:51 +0200
Message-ID: <CAGya9MmYVXXT8uF3p06o-7K-moTm_n3wWJ4My+PK_6yo0HaAAA__26350.6883559332$1345472066$gmane$org@mail.gmail.com>
References: <CAGya9MmuQi2U6sneqEPwWUrF=1rNNA-zE9yrfneGZ6QBZhBeTg@mail.gmail.com>
	<20120817150806.GA15919@Krystal> <502E6022.60208@efficios.com>
	<CAGya9MmT494LQVy_UfR_50i64-_29bZx+eeSv96Fy+9NzZvJgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <henrik@fiktivkod.org>) id 1T3Sjt-0002ud-6z
	for lttng-dev@lists.lttng.org; Mon, 20 Aug 2012 10:13:57 -0400
Received: by vcbfl11 with SMTP id fl11so6333789vcb.35
	for <lttng-dev@lists.lttng.org>; Mon, 20 Aug 2012 07:13:51 -0700 (PDT)
In-Reply-To: <CAGya9MmT494LQVy_UfR_50i64-_29bZx+eeSv96Fy+9NzZvJgQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: =?UTF-8?Q?Daniel_Flemstr=C3=B6m?= <daniel.flemstrom@mdh.se>, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Stefan Karlsson S12 <skn07007@student.mdh.se>
List-Id: lttng-dev@lists.lttng.org

Oh yeah. for the record.

DEBUG1: Using 32-bit UST consumer at:
/opt/xcompile/powerpc-e500-linux-gnu-lttng/lib/lttng/libexec/lttng-consumerd
[in spawn_consumerd() at main.c:1776]
Error: Spawning consumerd failed

I tried to change the patch with --consumerd32-path flag after. but it
did not change the result.

On Mon, Aug 20, 2012 at 3:14 PM, Henrik Hautakoski <henrik@fiktivkod.org> wrote:
> Ok so I attached the output from lttng-sessiond (it's large).
>
> the commands was:
>
> # lttng-sessiond --vvv --no-kernel --verbose-consumer
>
> # lttng list -u
>
> # lttng create mysession
>
> # lttng enable-event -a -u
>
> Nothing shows up in dmesg.
>
> On Fri, Aug 17, 2012 at 5:15 PM, David Goulet <dgoulet@efficios.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA512
>>
>> Hi,
>>
>> Actually, this error means that a problem occurred *during* the 32 bit
>> consumer spawning process... It seems the binary was found but failed
>> to exec it.
>>
>> Running the session daemon (lttng-sessiond) with options "-vvv
>> - --verbose-consumer" will help us pin down the problem.
>>
>> Send me back the output, I'll be able to tell you what's going on (and
>> also the series of command you guys did before the enable-event).
>>
>> Last thing, make sure the lttng-consumerd did not segfault (dmesg) or
>> any other lttng-tools component.
>>
>> Thanks!
>> David
>>
>> Mathieu Desnoyers:
>>> It looks like you did not build a 32-bit consumer. I'm ccing David
>>> Goulet, maintainer of lttng-tools.
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>> * Henrik Hautakoski (henrik@fiktivkod.org) wrote:
>>>> Hi. got lttng working now. but when given the following command,
>>>> we get an error.
>>>>
>>>> $ lttng enable-event -a -u Error: Events: 32-bit UST consumer
>>>> start failed (channel channel0, session mysession)
>>>>
>>>> Could not find any information about this error massage. do you
>>>> have any ideas?
>>>>
>>>> -- Henrik Hautakoski henrik@fiktivkod.org
>>>
>> -----BEGIN PGP SIGNATURE-----
>>
>> iQEcBAEBCgAGBQJQLmAfAAoJEELoaioR9I02rqEH/2w2QXXmpLE0iEYnl2FMrfYq
>> 5e6p0TH1Qb4NSKvyAuSOfFJYWpNXjAKKDC/ajUuEH5PZiFtPZqiNK/jQQcTwns9t
>> dwZb1WSLm4Ue5z7jRV3yk8Gae/IaFQqbS5l3tTdKkE7rFOVO9Iew5+BPORHtBYA3
>> Bvmx9CcwxeOVizKMab5Y0JK9RbuFcnurUV33tUI9DAisloutrItm84GdKyE5wZ92
>> mXaneN+a0PhI68GsAmBq7dJMdjo+XABurr8oVL/kdWvUo8T1Sn298b5ki+se4zLL
>> kIfAXv7x+5K8tp6jnXznG6COsjbxf7Zt3nXouyled+oKr7muhGBDi5ul1r3W9IM=
>> =p8bq
>> -----END PGP SIGNATURE-----
>
>
>
> --
> Henrik Hautakoski
> henrik@fiktivkod.org



-- 
Henrik Hautakoski
henrik@fiktivkod.org
