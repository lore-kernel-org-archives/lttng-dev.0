From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: [tracecompass-dev] Scalability
Date: Wed, 13 Mar 2019 08:29:50 -0400
Message-ID: <CAB4xu_0re+LuhMLMVfqf_GiFxMrOKFfW12ehqLzLQKkd8_9qVA__25495.6923703261$1552480234$gmane$org@mail.gmail.com>
References: <559e65b28a33c3a2d28bc5a32c3fdc4dfeacaf93.camel@blackberry.com>
 <DM6PR15MB3100B14E05117F439A6A08DE9E490@DM6PR15MB3100.namprd15.prod.outlook.com>
 <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>
 <20190312150314.GC13925@joraj-alpa>
 <484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com>
 <20190312153437.GA25992@joraj-alpa>
 <c2ef7a391ab1a7305d71fd0165729d130bc94f5c.camel@blackberry.com>
 <8adc08653d0246ce8b545a7c1374d8b9eb7aa6a3.camel@blackberry.com>
 <DM6PR15MB3100CFE23B0E9C736E903D759E4A0@DM6PR15MB3100.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by lists.lttng.org (Postfix) with ESMTPS id 44KB4r0XR6z176b
 for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2019 08:30:19 -0400 (EDT)
Received: by mail-lf1-x12f.google.com with SMTP id 10so1317272lfr.8
 for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2019 05:30:19 -0700 (PDT)
In-Reply-To: <DM6PR15MB3100CFE23B0E9C736E903D759E4A0@DM6PR15MB3100.namprd15.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Mar 13, 2019 at 8:13 AM Matthew Khouzam
<matthew.khouzam@ericsson.com> wrote:
>
> Hi Doug & Efficios,
>
>
> I suspect the issue is with libbabeltrace-ctf. When opening the trace in Trace Compass, it failed saying the sequence was 2gb big. When opening in babeltrace, it OOMed with 2gb allocations. When opening with a hex editor, I saw 2gb allocations.

Yes, byte order issues. Here's the fix:
<https://github.com/efficios/babeltrace/pull/103>.

Phil

>
>
> On another subject, fixing the trace made it scale well in both babeltrace and Trace Compass.
>
>
> I don't know why, data_length writes the wrong data. Hope this helps all parties.
>
>
> BR,
>
> Matthew
>
> ________________________________
> From: tracecompass-dev-bounces@eclipse.org <tracecompass-dev-bounces@eclipse.org> on behalf of Doug Schaefer <dschaefer@blackberry.com>
> Sent: Tuesday, March 12, 2019 2:50:29 PM
> To: jonathan.rajotte-julien@efficios.com
> Cc: lttng-dev@lists.lttng.org; tracecompass-dev@eclipse.org
> Subject: Re: [tracecompass-dev] [lttng-dev] Scalability
>
> I have attached the C file for a generator that creates a trace that reproduces the memory issue with babeltrace. The same issue happens with a custom program in the call to add a trace to a context.
>
> I am using babeltrace that I get from my Ubuntu 18.04 distro. It has the version number 1.5.5.
>
> Thanks for the help!
>
> On Tue, 2019-03-12 at 15:47 +0000, Doug Schaefer wrote:
>
> In the thread on the tracecompass list, I also mentioned that the babeltrace utility itself ran out of memory when reading the file. That's actually my biggest worry. I got around the generator issue by flushing every 100K events.
>
> I'll create a quick generator that shows the same issue and post it in a bit.
>
> Doug.
>
> On Tue, 2019-03-12 at 11:34 -0400, Jonathan Rajotte-Julien wrote:
>
> On Tue, Mar 12, 2019 at 03:23:23PM +0000, Doug Schaefer wrote:
>
> It should be easy to generate a random one with the class I mentioned below
>
> and fill it with 16 million events.
>
>
> Not if the problem is in the generator code ;).
>
>
> BTW, two of the int fields are 5 and 10
>
> bits respectively, but I'm not sure that matters (or at least it shouldn't).
>
>
> Make sure to check the endian-ness of those fields.
>
>
> What class? Not sure I see any reference to any.
>
>
> Since you are generating CTF the error can be in the generator code. Please
>
> provide either a trace reproducing the issue or a base reproducer. It will be
>
> much easier overall than us trying to reproduce it blindly.
>
>
> Cheers.
>
>
> _______________________________________________
>
> lttng-dev mailing list
>
> lttng-dev@lists.lttng.org
>
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.lttng.org_cgi-2Dbin_mailman_listinfo_lttng-2Ddev&d=DwICAg&c=yzoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp26wE&r=NrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&m=DWwlFfl5FD5R8-HPY3GfbG6l6m7y_o2gXPER8IkQstk&s=bPK6X3vufUtEAemGpslNIlIL4UslBsgK-SWnraL-e9g&e=
>
>
> ---------------------------------------------------------------------
> This transmission (including any attachments) may contain confidential information, privileged material (including material protected by the solicitor-client or other applicable privileges), or constitute non-public information. Any use of this information by anyone other than the intended recipient is prohibited. If you have received this transmission in error, please immediately reply to the sender and delete this information from your system. Use, dissemination, distribution, or reproduction of this transmission by unintended recipients is not authorized and may be unlawful.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
