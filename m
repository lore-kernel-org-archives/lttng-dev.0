From: Mikael Beckius <mikael.beckius@ericsson.com>
Subject: Re: Sessions are disconnected when disk is full on
 remote host
Date: Tue, 29 Sep 2015 08:06:19 +0000
Message-ID: <FEF43CBBC4664F4D80C53B178C850ADE7317E3__42227.525675162$1443544003$gmane$org@ESESSMB305.ericsson.se>
References: <FEF43CBBC4664F4D80C53B178C850ADE730271@ESESSMB305.ericsson.se>,
 <CA+jJMxsAFJ+MgYYRxhcJUuoyUT8bUWfuiH6WJXSPyVg65zLGWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sesbmg23.ericsson.net ([193.180.251.37])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mikael.beckius@ericsson.com>) id 1Zgpva-0008Ko-Oy
 for lttng-dev@lists.lttng.org; Tue, 29 Sep 2015 04:06:25 -0400
In-Reply-To: <CA+jJMxsAFJ+MgYYRxhcJUuoyUT8bUWfuiH6WJXSPyVg65zLGWw@mail.gmail.com>
Content-Language: sv-SE
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

________________________________________
Fr=E5n: jeremie.galarneau@gmail.com [jeremie.galarneau@gmail.com] f&#246;r =
J=E9r=E9mie Galarneau [jeremie.galarneau@efficios.com]
Skickat: den 25 september 2015 21:50
Till: Mikael Beckius
Kopia: lttng-dev@lists.lttng.org
=C4mne: Re: [lttng-dev] Sessions are disconnected when disk is full on remo=
te host

On Wed, Sep 23, 2015 at 5:48 AM, Mikael Beckius
<mikael.beckius@ericsson.com> wrote:
> Hello!
>
> I am trying to verify the expected behaviour in the event a machine hosti=
ng
> an lttng relay daemon runs out of disk space.
>
> Currently it appears from testing and inspecting the source code that
> whenever the lttng relay daemon hits an error caused by the lack of disk
> space all failing sessions will be disconnected. It also appears that the
> only way to recover from this situation once disk space has been restored=
 is
> to recreate all the disconnected sessions.
>
> I have also played around with different combinations of the below lttng
> enable-channel options:
> --discard
> --overwrite
> --tracefile-count <trace file count>
> --tracefile-size <trace file size>
>
> The initial channel configuration was using the options --tracefile-count
> --tracefile-size but both were abandoned as Babeltrace faced constant
> streaming errors during heavy live tracing and now the trace files are
> growing continuously until there is no available disk space.
>
> I assume that --overwrite would not make any difference compared to
> --discard with regards to a disk full scenario. Even if you specify
> --tracefile-count and --tracefile-size to limit the amount of trace data
> from a single session you may still face the same issue with disconnected
> sessions if you for some reason run out of disk space.
>
> Testing was carried out on the latest 2.6 releases and all sessions were
> live sessions.
>
> So my questions are:
> - Is there any way to keep sessions alive even if you run out of disk spa=
ce?
> - How can you clean up old traces once you have collected them without
> recreating sessions?

Hi Mikael,

LTTng currently doesn't support these recovery modes.

However, the file rotation issues you mentioned should be resolved in
lttng-tools 2.6.1. Any chance you can give it a try?
The website will be updated later today. In the meantime, here's a
direct link to the release:

https://lttng.org/files/lttng-tools/lttng-tools-2.6.1.tar.bz2

Regards,
J=E9r=E9mie

Hello J=E9r=E9mie!

Thanks for the hint. I will give the new 2.6.1 and 2.7.0 releases of lttng-=
tools a try and see if they work better than 2.6.0.

Micke

>
> Micke
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
