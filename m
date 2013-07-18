From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Question about filtering bytecode
Date: Thu, 18 Jul 2013 12:10:50 -0400
Message-ID: <CA+jJMxtsA04qYmOiLeHEy2X03VK_Q0g3jf3Duj7Ax5ySBycC-Q__26161.9033910849$1374163914$gmane$org@mail.gmail.com>
References: <OFA394F5DC.943733C6-ONC2257BAC.00273BA0-C2257BAC.00277FA2@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f178.google.com ([74.125.82.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UzqnA-0001RC-OV
	for lttng-dev@lists.lttng.org; Thu, 18 Jul 2013 12:11:01 -0400
Received: by mail-we0-f178.google.com with SMTP id u53so3077251wes.37
	for <lttng-dev@lists.lttng.org>; Thu, 18 Jul 2013 09:10:50 -0700 (PDT)
In-Reply-To: <OFA394F5DC.943733C6-ONC2257BAC.00273BA0-C2257BAC.00277FA2@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Amit,

You may find information on the Babeltrace API in babeltrace/doc/API.txt
The filtering mechanism used by the user space tracer is unrelated to
Babeltrace.

As for the sequence of events, this is how I understand it.

When invoking the "lttng" binary with --enable-event and a filter
option, a byte code is generated from the filtering rules
(lttng-tools/src/lib/lttng-ctl/lttng-ctl.c:704). This byte code is
then handed off to the session-daemon.

Then, when an instrumented application is launched and connects to the
session-daemon, it receives the byte code while its events are being
enabled. To answer your question directly, that byte code will be
executed by the tracee when the event is "triggered"
(lttng-ust/liblttng-ust/lttng-filter-interpreter.c:175).

I'm not sure I understand your question about filter/event linking. A
filter has to be linked to an event since its rules (expressions) are
applied on that event's values. Could you clarify if that's not what
you meant?

Regards,
J=E9r=E9mie

On Thu, Jul 18, 2013 at 3:12 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hi,
>
> I'm considering whether I can write a wrapper for the libbabeltrace ctf
> iterator which provides a filtered "next()" method.
>
> I've started reading the code in the hopes of understanding how to do thi=
s,
> and yet, I'd really appreciate a link to some ordered documentation, or -
> any other kind of explanation.
>
> For example, one thing I still don't understand is the exact sequence, and
> where the bytecode is actually executed? What is the meaning and purpose =
of
> "linking" the filter to an event.
>
> Thanks,
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
