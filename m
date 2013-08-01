From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation for
 some pthread functions.
Date: Wed, 31 Jul 2013 23:16:43 -0400
Message-ID: <CA+jJMxv4oS0SbMqUF247jS0s0E+6DfdepNT8yHimY=TULHD+tQ__7324.39792850545$1375327068$gmane$org@mail.gmail.com>
References: <51F97688.30704@mentor.com>
	<CA+jJMxsoH8Rz6fwZJOPnG-4xvB2w8GO5eqi0JDtHUy7iM-n2WA@mail.gmail.com>
	<51F9A917.9010509@seefeld.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f178.google.com ([74.125.82.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V4jNh-0003cJ-Vj
	for lttng-dev@lists.lttng.org; Wed, 31 Jul 2013 23:16:53 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so1219952wes.23
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 20:16:44 -0700 (PDT)
In-Reply-To: <51F9A917.9010509@seefeld.name>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan@seefeld.name>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Wed, Jul 31, 2013 at 8:17 PM, Stefan Seefeld <stefan@seefeld.name> wrote:
> On 07/31/2013 06:00 PM, J=E9r=E9mie Galarneau wrote:
>> Hi Stefan,
>>
>> Please inline your patches in the future as it makes the review process =
simpler.
>> There are a number of stylistic problems, mostly misplaced braces.
>>
>> You can run your patches through the checkpatch.pl script found in
>> lttng-tools/extras. It will spot most coding-style related problems
>> right away.
>
> OK, will do, once the patch is approved functionally.
>
>> Also, I think lttng-ust-pthread-mutex.c may be a more appropriate name
>> than pthread.c
>
> Wouldn't that just be redundant ? (And I actually expect the file to
> grow instrumentation that's not mutex-specific.)

I'd keep the file name in line with what's already there, namely
lttng-ust-malloc.c.
If you plan on instrumenting other parts of the pthread API,
lttng-ust-pthread.c would make sense.

>
> Thanks,
>     Stefan
>
> --
>
>       ...ich hab' noch einen Koffer in Berlin...
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
