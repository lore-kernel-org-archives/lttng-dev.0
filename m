From: "Kim, Seongab via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: [EXTERNAL] Re: babeltrace cannot open the trace but
 Trace Compass can open
Date: Thu, 23 Jul 2020 09:08:47 +0000
Message-ID: <7cb6526a78a9468e969a0fe36f42c6d7@HIMDWSMB06.ad.harman.com>
References: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
 <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
Reply-To: "Kim, Seongab" <Seongab.Kim@harman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.114])
 by lists.lttng.org (Postfix) with ESMTP id 4BC63D2c1tz1fGH
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 05:09:27 -0400 (EDT)
In-Reply-To: <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
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
> Sent: Wednesday, July 22, 2020 5:06 PM
> To: Kim, Seongab <Seongab.Kim@harman.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: [EXTERNAL] Re: [lttng-dev] babeltrace cannot open the trace but
> Trace Compass can open
> 
> Thank you for the bug report.
> 
> Can I kindly ask you to create an official issue for this?
> 
> Go to
> <https://clicktime.symantec.com/38qgEsYhBTfCNnYpLPoAn647Vc?u=https%
> 3A%2F%2Fbugs.lttng.org%2Fprojects%2Fbabeltrace%2Fissues%2Fnew>.
> 
> I'd also like you to attach the offending CTF trace so that I can analyze it if it
> doesn't contain sensitive data and is somewhat small.

I created an account in Redmine, but I'm still waiting for the account activation mail. I tried to click the resend mail link two times without success.
Also the trace is big (1.4 GB) and it contains sensitive data.

> If it's not possible, do:
> 
>     $ babeltrace2 -o ctf-metadata /mnt/ssd/work/skim/traces/kernel | grep -
> A10 '^clock {'
> 
> and copy the output to the Redmine issue's description.

Here is the result.

skim@d54030999178:~/ssd_work/traces$ babeltrace2 -o ctf-metadata ./kernel | grep -A10 '^clock {'
clock {
        name = "monotonic";
        uuid = "e00bcef2-1ef1-4f02-a241-8561834511fd";
        description = "Monotonic Clock";
        freq = 1000000000; /* Frequency, in Hz */
        /* clock value offset from Epoch is: offset * (1/freq) */
        offset = -48;
};

typealias integer {
        size = 27; align = 1; signed = false;

> 
> BR,
> 
> Phil

Best regards,
Seongab
