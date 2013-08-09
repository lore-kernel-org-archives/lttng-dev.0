From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: one sessiond for multiuser system
Date: Fri, 9 Aug 2013 10:54:49 -0400
Message-ID: <CA+jJMxuJ2itGEqM0Y7VLabttNuwfogD448bUEPtQeuoz_RpWyA__30860.9983571388$1376060151$gmane$org@mail.gmail.com>
References: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A223B68@ESESSMB105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f172.google.com ([74.125.82.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V7o5f-0002zj-DW
	for lttng-dev@lists.lttng.org; Fri, 09 Aug 2013 10:54:58 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so3615101wes.17
	for <lttng-dev@lists.lttng.org>; Fri, 09 Aug 2013 07:54:49 -0700 (PDT)
In-Reply-To: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A223B68@ESESSMB105.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stanislav Vovk <stanislav.vovk@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Aug 9, 2013 at 4:01 AM, Stanislav Vovk
<stanislav.vovk@ericsson.com> wrote:
> Hi,
>
> Have a few questions regarding lttng configuration in a multi user system.
>
> In my system there are two users, root and Bob. I am starting sessiond at=
 boot as root user. And instrumented programs are started as either root or=
 Bob. I am logged in to the system and controlling lttng as root user.
>
> - When executing "lttng list -u" I see events registered by programs star=
ted as root. I don't see events from programs started as Bob. Why? Did I fo=
rget something?
>
> - Now I switch user to Bob in the shell. Executing "lttng list -u" does n=
ot give any output at all, instead a new sessiond is started. How can I hav=
e one sessiond for the whole system?

Hi Stanislav,

A non-privileged user can only interact with a root session daemon if
he is part of the "tracing" group. Is it the case for "Bob" in this
example?

Reproducing your scenario here with "Bob" being part of the tracing group:
- Root can list its own sessions as well as Bob's
- Bob's user space events can also be seen by root
- Bob can't see the sessions created by root.

Regards,
J=E9r=E9mie

>
> Cheers,
> Stanislav
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
