From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [tracecompass-dev] Scalability
Date: Tue, 12 Mar 2019 11:03:14 -0400
Message-ID: <20190312150314.GC13925__5590.73860510893$1552403015$gmane$org@joraj-alpa>
References: <559e65b28a33c3a2d28bc5a32c3fdc4dfeacaf93.camel@blackberry.com>
 <DM6PR15MB3100B14E05117F439A6A08DE9E490@DM6PR15MB3100.namprd15.prod.outlook.com>
 <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44JdWm6l3Wz15tS
 for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2019 11:03:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Doug Schaefer <dschaefer@blackberry.com>, tracecompass developer discussions <tracecompass-dev@eclipse.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Doug,

On Tue, Mar 12, 2019 at 02:56:26PM +0000, Doug Schaefer wrote:
> Thanks, Matthew, I ended up flushing every 100K events and that seemed OK.
> 
> My biggest worry is on the read side. Babeltrace blew up on that file. It's a pretty simple trace (for now) with a single event class with 4 ints and a sequence of 32-bit unsigned ints which is usually only 2 elements long.

This is not I expect. Still eithet jgalar or eep might have a more insight on
this. CCing the lttng-dev mailing list.

Is there any way to share us a similar trace? Either with a generator or we can
provide a link for you to upload it. The current limit on bugs.lttng.org is a
bit too small for such trace.

> 
> Aside from that, am very pleased with the how easy CTF is to work with. Looking forward to doing more.
> 
> Doug.
> 
> On Tue, 2019-03-12 at 14:41 +0000, Matthew Khouzam wrote:
> 
> Hi Doug,
> 
> 
> Great to hear you're coming to a standard! I don't know if trace compass will scale properly as I don't know what the trace configuration is.
> 
> 
> > I have one of our trace which has 16 million events, the size of each event is around 32 bytes giving me a 540MB file. My first attempt at simply writing out the CTF events without a flush ran out of virtual memory. I then flushed after every event which made each event take 32K. So I found a middle ground and the resulting stream file is close to the same size.
> 
> 
> 
> My suggestion is to have 1 MB packets. This makes seeking very efficient. If each event is 32 bytes, basically flush every 25k events or so.
> 
> 
> Please keep us posted!
> 
> 
> Matthew.
> 
> ________________________________
> From: tracecompass-dev-bounces@eclipse.org <tracecompass-dev-bounces@eclipse.org> on behalf of Doug Schaefer <dschaefer@blackberry.com>
> Sent: Tuesday, March 12, 2019 10:30:15 AM
> To: tracecompass-dev@eclipse.org
> Subject: [tracecompass-dev] Scalability
> 
> Hey gang,
> 
> We're finally starting to look at converting our custom traces into CTF so we can leverage tools like TraceCompass and, of course, contribute to it. One thing I quickly ran into is a scalability issue I'm seeing with libbabeltrace.
> 
> I have one of our trace which has 16 million events, the size of each event is around 32 bytes giving me a 540MB file. My first attempt at simply writing out the CTF events without a flush ran out of virtual memory. I then flushed after every event which made each event take 32K. So I found a middle ground and the resulting stream file is close to the same size.
> 
> But when I use babeltrace to print it out, I ran out of virtual memory. I then hand coded a reader and simply adding the trace to the context caused the memory issue. It really looks like libbabeltrace (version 1.5 from the Ubuntu 18.04 distro), tries to inflate the events into it's internal representation for the entire trace. I need to do more investigation to confirm that.
> 
> So my question for this list, would TraceCompass do better? Does it have it's own parsing libraries?
> 
> Thanks,
> Doug

> _______________________________________________
> tracecompass-dev mailing list
> tracecompass-dev@eclipse.org
> To change your delivery options, retrieve your password, or unsubscribe from this list, visit
> https://www.eclipse.org/mailman/listinfo/tracecompass-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
