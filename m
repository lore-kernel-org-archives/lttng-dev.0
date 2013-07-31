From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation for
 some pthread functions.
Date: Wed, 31 Jul 2013 18:00:14 -0400
Message-ID: <CA+jJMxsoH8Rz6fwZJOPnG-4xvB2w8GO5eqi0JDtHUy7iM-n2WA__6343.51987760073$1375308085$gmane$org@mail.gmail.com>
References: <51F97688.30704@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V4eRQ-0000uY-Hw
	for lttng-dev@lists.lttng.org; Wed, 31 Jul 2013 18:00:26 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so1067281wgh.8
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 15:00:14 -0700 (PDT)
In-Reply-To: <51F97688.30704@mentor.com>
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

Hi Stefan,

Please inline your patches in the future as it makes the review process sim=
pler.
There are a number of stylistic problems, mostly misplaced braces.

You can run your patches through the checkpatch.pl script found in
lttng-tools/extras. It will spot most coding-style related problems
right away.

Also, I think lttng-ust-pthread-mutex.c may be a more appropriate name
than pthread.c

Thanks,
J=E9r=E9mie

On Wed, Jul 31, 2013 at 4:41 PM, Stefan Seefeld
<stefan_seefeld@mentor.com> wrote:
> The attached patch introduces a pthread wrapper library with initial
> instrumentation for pthread_mutex_lock, pthread_mutex_trylock, and
> pthread_mutex_unlock.
> New tracepoints are introduced for each of those. For the lock function,
> two distinct tracepoints are emitted: one before the lock is requested,
> another after it has been acquired.
>
> --
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
