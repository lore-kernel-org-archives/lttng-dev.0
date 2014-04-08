From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Problem running lttng enable-channel shortly after
 lttng create
Date: Tue, 8 Apr 2014 15:12:57 -0400
Message-ID: <CA+jJMxu9c4M2snnrJvB_kK5beFWri+bQy9NgnuxDJ_wFQLCr0g__33028.6431745209$1396984537$gmane$org@mail.gmail.com>
References: <OFBB2685C6.309D33C4-ONC2257CAE.0034A252-C2257CAE.003C2323@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WXbSB-0002VK-0h
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 15:13:08 -0400
Received: by mail-qa0-f43.google.com with SMTP id j15so1440734qaq.30
 for <lttng-dev@lists.lttng.org>; Tue, 08 Apr 2014 12:12:57 -0700 (PDT)
In-Reply-To: <OFBB2685C6.309D33C4-ONC2257CAE.0034A252-C2257CAE.003C2323@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Apr 2, 2014 at 6:56 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hello,
>
> I keep getting the following error from lttng enable-channel:
>
> libust[2984/2986]: Error: Timed out waiting for lttng-sessiond (in
> lttng_ust_init() at lttng-ust-comm.c:1444)
>
> The scenario is quite simple - during boot of the system, we create a
> session, enable a channel, etc., like this:
>
> # /usr/bin/lttng-sessiond --no-kernel -b
> Warning: No tracing group detected
> # /usr/bin/lttng create nextra -o /local/traces/lttng/20140402123725
> Session nextra created.
> Traces will be written in /local/traces/lttng/20140402123725
> # /usr/bin/lttng enable-channel channel0 -u --tracefile-size 67108864
> --tracefile-count 40 --buffers-uid --switch-timer 1000000 --num-subbuf 16
> --subbuf-size 262144
> libust[2984/2986]: Error: Timed out waiting for lttng-sessiond (in
> lttng_ust_init() at lttng-ust-comm.c:1444)
> Warning: No tracing group detected
>
> The PID 2984 belongs to the lttng-consumerd. At that point in time I see =
the
> following in syslog:
>
> 2014/04/02 12:38:03.370576 kernel   error    nextra-6663235-module-1  [
> 56.376155] proc lttng-sessiond with pid 632 goes to delayed retry in
> epoll_wait(): start jiffies 4294904844, stop jiffies=3D4294906390 (+1546),
> expected final stop jiffies=3D9223372041149680651 (+9223372036854775807),=
 next
> stop jiffies=3D9223372041149682197 (+9223372036854775807)
> 2014/04/02 12:38:03.399245 kernel   error    nextra-6663235-module-1  [
> 56.405166] proc lttng-sessiond with pid 632 goes to delayed retry in
> epoll_wait(): start jiffies 4294904844, stop jiffies=3D4294906397 (+1553),
> expected final stop jiffies=3D9223372041149680651 (+9223372036854775807),=
 next
> stop jiffies=3D9223372041149682204 (+9223372036854775807)
> 2014/04/02 12:38:03.405700 kernel   error    nextra-6663235-module-1  [
> 56.411791] proc lttng-sessiond with pid 632 goes to delayed retry in
> epoll_wait(): start jiffies 4294904844, stop jiffies=3D4294906398 (+1554),
> expected final stop jiffies=3D9223372041149680651 (+9223372036854775807),=
 next
> stop jiffies=3D9223372041149682205 (+9223372036854775807)
>
> And finally, the command succeeds:
>
> UST channel channel0 enabled for session nextra
>
> My guess is that the boot sequence is loading some traced application bef=
ore
> the channel is enabled, and the consumerd is started, which under heavy
> system load (exists during initial boot time) times out waiting for the
> sessiond. If that was the case, I could try to increase the timeout time,
> but that also delays my booting, which I cannot afford to do.
>
> Suggestions?
>

How many apps are trying to register to the session daemon at that
moment? Also, can you give us an idea of the system on which this is
running?

By the way, bumping your own thread after ~24 hours is generally
considered rude and won't get you more answers...

Regards,
J=E9r=E9mie

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
