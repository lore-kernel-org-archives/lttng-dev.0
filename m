From: Attel Raghavendra <attel.raghavendra@gmail.com>
Subject: Re: LTTng undefined reference while building the sample
	application.
Date: Thu, 2 Aug 2018 11:40:49 +0530
Message-ID: <CAEN7SXNggOTubKvvAOJ8FTmJLpORGEauk1D7+MX6QwThk1uxEg__29197.9373353117$1533190246$gmane$org@mail.gmail.com>
References: <CAEN7SXPpZKTgHDU91AwwrzdVQeM+fr=06CKmLJqKUn6uiRbZwg@mail.gmail.com>
 <365f8241-e04e-95b7-881a-f9ffc6d0e555@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6538110654254277108=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com
 [IPv6:2607:f8b0:4003:c06::233])
 by lists.lttng.org (Postfix) with ESMTPS id 41h0D53MFCz15PS
 for <lttng-dev@lists.lttng.org>; Thu,  2 Aug 2018 02:11:01 -0400 (EDT)
Received: by mail-oi0-x233.google.com with SMTP id n21-v6so1941023oig.3
 for <lttng-dev@lists.lttng.org>; Wed, 01 Aug 2018 23:11:01 -0700 (PDT)
In-Reply-To: <365f8241-e04e-95b7-881a-f9ffc6d0e555@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mjeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============6538110654254277108==
Content-Type: multipart/alternative; boundary="000000000000ced56f05726dac43"

--000000000000ced56f05726dac43
Content-Type: text/plain; charset="UTF-8"

Thank you for your help!
Raghu

On Wed, Aug 1, 2018 at 8:36 PM Michael Jeanson <mjeanson@efficios.com>
wrote:

> On 2018-08-01 07:22 AM, Attel Raghavendra wrote:
> > Hi Team,
> >
> > I have new to the LTTng. I am trying to build a sample application to
> > test the LTTng.
> > I was able to compile the sample application successfully, however
> > facing the following linker problems. Please help to resolve the same.
> >
> > xx_app.o:(__tracepoints+0x18): undefined reference to
> > `__tracepoint_provider_rttLogger'
> > xx_tpp.o: In function `__tracepoint_provider_check_rttlogger':
> > xx_tpp.c:(.text+0x271): undefined reference to
> > `__tracepoint_provider_mismatch_rttLogger'
> > xx_tpp.c:(.text+0x27b): undefined reference to
> > `__tracepoint_provider_mismatch_rttLogger'
> > collect2: error: ld returned 1 exit status
> >
> >
> > Thank you,
> > Raghu.
> >
> Hi Raghu,
>
> The correct address to reach the mailing list is:
>
>  lttng-dev@lists.lttng.org
>
> I've CC'd the list so someone can answer your question.
>
> Cheers,
>
> Michael
>

--000000000000ced56f05726dac43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for your help!=C2=A0<br><div>Raghu</div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Aug 1, 2018 at 8:36 P=
M Michael Jeanson &lt;<a href=3D"mailto:mjeanson@efficios.com">mjeanson@eff=
icios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 2018-=
08-01 07:22 AM, Attel Raghavendra wrote:<br>
&gt; Hi Team,<br>
&gt; <br>
&gt; I have new to the LTTng. I am trying to build a sample application to<=
br>
&gt; test the LTTng.<br>
&gt; I was able to compile the sample application successfully, however<br>
&gt; facing the following linker problems. Please help to resolve the same.=
=C2=A0=C2=A0<br>
&gt; <br>
&gt; xx_app.o:(__tracepoints+0x18): undefined reference to<br>
&gt; `__tracepoint_provider_rttLogger&#39;<br>
&gt; xx_tpp.o: In function `__tracepoint_provider_check_rttlogger&#39;:<br>
&gt; xx_tpp.c:(.text+0x271): undefined reference to<br>
&gt; `__tracepoint_provider_mismatch_rttLogger&#39;<br>
&gt; xx_tpp.c:(.text+0x27b): undefined reference to<br>
&gt; `__tracepoint_provider_mismatch_rttLogger&#39;<br>
&gt; collect2: error: ld returned 1 exit status<br>
&gt; <br>
&gt; <br>
&gt; Thank you,<br>
&gt; Raghu.<br>
&gt; <br>
Hi Raghu,<br>
<br>
The correct address to reach the mailing list is:<br>
<br>
=C2=A0<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br>
<br>
I&#39;ve CC&#39;d the list so someone can answer your question.<br>
<br>
Cheers,<br>
<br>
Michael<br>
</blockquote></div>

--000000000000ced56f05726dac43--

--===============6538110654254277108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6538110654254277108==--
