From: "Kim, Seongab via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: [EXTERNAL] Re: babeltrace cannot open the trace but
 Trace Compass can open
Date: Thu, 23 Jul 2020 14:10:42 +0000
Message-ID: <1b1cfdcc72fb4cbb8a81a1a0b13c6c15@HIMDWSMB06.ad.harman.com>
References: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
 <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
 <7cb6526a78a9468e969a0fe36f42c6d7@HIMDWSMB06.ad.harman.com>
 <CAB4xu_1p0AYHhb1GASzOM9e-pdWmSkeTfZq2tQoyacso1MCUNA@mail.gmail.com>
Reply-To: "Kim, Seongab" <Seongab.Kim@harman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com
 [67.219.246.116])
 by lists.lttng.org (Postfix) with ESMTPS id 4BCDky69Qtz1g3v
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 10:10:50 -0400 (EDT)
In-Reply-To: <CAB4xu_1p0AYHhb1GASzOM9e-pdWmSkeTfZq2tQoyacso1MCUNA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello Phil,

> -----Original Message-----
> From: Philippe Proulx <eeppeliteloop@gmail.com>
> Sent: Thursday, July 23, 2020 4:00 PM
> To: Kim, Seongab <Seongab.Kim@harman.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [EXTERNAL] Re: [lttng-dev] babeltrace cannot open the trace but
> Trace Compass can open
> > Here is the result.
> >
> > skim@d54030999178:~/ssd_work/traces$ babeltrace2 -o ctf-
> metadata ./kernel | grep -A10 '^clock {'
> > clock {
> >         name = "monotonic";
> >         uuid = "e00bcef2-1ef1-4f02-a241-8561834511fd";
> >         description = "Monotonic Clock";
> >         freq = 1000000000; /* Frequency, in Hz */
> >         /* clock value offset from Epoch is: offset * (1/freq) */
> >         offset = -48;
> 
> Thanks, this is enough for us.
> 
> When your account gets activated, could you copy this into the new issue's
> description?
> 
> This way you can receive notifications when the issue gets updated.
> 

FYI, I have created an issue, https://bugs.lttng.org/issues/1277.

Best regards,
Seongab
