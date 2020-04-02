From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Babeltrace 2.0.2 performance issue
Date: Thu, 2 Apr 2020 12:53:00 -0400
Message-ID: <20200402165300.GB695@joraj-alpa>
References: <76e78e538b804aa2b78f320510e8c10d@yadro.com>
 <9ee46aeb-1b9b-c7d4-94ea-c15772bc05eb@efficios.com>
 <5f3249fe30e040b5b4a444fba495de62@yadro.com>
 <6992879d-d139-06f5-d325-02530ad2c1b1@efficios.com>
 <e21e3ce3-0180-7aa7-aa16-9e889b69269b@efficios.com>
 <a095fcdafcf24edf85e047e9c177b0d0@yadro.com>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48tTdq30T0z1bT3
 for <lttng-dev@lists.lttng.org>; Thu,  2 Apr 2020 12:53:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <a095fcdafcf24edf85e047e9c177b0d0@yadro.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Aleksander Aleksandrov <a.aleksandrov@yadro.com>
Cc: Simon Marchi <simon.marchi@efficios.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Aleksander,

On Thu, Apr 02, 2020 at 04:32:03PM +0000, Aleksander Aleksandrov via lttng-dev wrote:
> Hi Simon,
> 
> 
> Thank you for your message! Unfortunately, I missed your previous message, sorry for this.
> 
> 
> I processed the CI's trace logs, I got the following performance: bt2 (140.51s) vs bt1 (122.00s). In my opinion, the values are quite similar comparing with my other measurements.

Well, in that case we will augment the data gathered on our CI to better
understand what is happening here an why we have such discrepancy. I should be
able to allocate some time in the following weeks.

Feel free to contribute to the optimization effort on your end if you see any
big culprit. For now, the babeltrace team effort is primary on completing
documentation and internal cleanup.

On my laptop (Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz) with scaling enabled
(~3.2Ghz mean of freq used during the 5 run of each bt1 and bt2) I get extremely
similar result for both bt1 (~46s) and bt2(~45s).

On my desktop as Simon reported, (Ryzen 7 3700x , max freq 3.6Ghz), bt1 is ~33s and bt2 ~36s.

All of this using the dummy output for both bt1 and bt2.

Cheers

> 
> 
> Best regards,
> 
> Aleksandr
> 
> 
> On 2020-03-13 4:58 p.m., Simon Marchi wrote:
> > Hi Aleksander,
> >
> > I just noticed you did not send your original email to the lttng-dev mailing list,
> > please send such request on that mailing list, as it's of public interest:
> >
> >   https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> > See my previous response here:
> >
> >   https://pastebin.com/raw/3Q5PbYXn
> >
> > Simon
> >
> 
> Hi Aleksander,
> 
> Sorry, I forgot to follow up.  Did you get my last message?
> 
> This is the trace we use for benchmarking: https://files.efficios.com/s/pog5raGkBkH63y9
> 
> Could you try to compare bt1 and bt2 using that trace?
> 
> On the CI benchmark system, we get some similar performance with both bt1 and bt2.  Although
> a colleague tried on a recent AMD Ryzen 3700X CPU, and he says bt2 is slower than bt1 for
> him (36s vs 33s).  I'd be curious to know what kind of numbers you get.
> 
> Simon

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
