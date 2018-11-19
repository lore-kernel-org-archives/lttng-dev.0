From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: A question on protocols
Date: Mon, 19 Nov 2018 13:46:41 -0500
Message-ID: <20181119184641.GA8739__35689.200476236$1542653096$gmane$org@joraj-alpa>
References: <CANzOjBhikh_81hsu4b3pvneBNEX+PWjzWfx_K-jc-s0X0==zDQ@mail.gmail.com>
 <20181116171557.GA23758@joraj-alpa>
 <CANzOjBgXXbPXHw6oZetVr3pOJq51Pg+aWUpRP0f0WhZUqEdB8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42zHqw0v3Bzrym
 for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2018 13:46:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CANzOjBgXXbPXHw6oZetVr3pOJq51Pg+aWUpRP0f0WhZUqEdB8g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mrx <patrik.mrx@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Patrick,

> The security between consumerd and relayd isn't an issue as we'd be forced
> to keep both on the device. This because we have no way of transporting the
> consumerd <-> relayd communication over the HTTP proxy, which is our only
> choice. We have already talked to the team in charge of the network paths.

In that case using lttng-relayd yield no advantage unless you are able to have
a device running only lttng-relayd and gathering data from other devices and
then sending the data via http.


> 
> The relayd side have to be on the device. The device has very limited
> amounts of free flash. Even if there were flash available it would wear
> down the flash faster than what we'd like.

Not sure I follow here. The whole point of lttng-relayd is to be off the device
being traced and to relay trace data using network only (skipping disk).

> A RAM-based disc might have been a solution if we would have had any
> mentionable amounts of RAM to spare for this. Unfortunately we don't have
> that.

In all cases you will need some RAM somewhere if using LTTng (and I think any
other monitoring/tracing tools) since we need to allocate tracing buffer.

> >
> > Keep in mind that trace production is normally much more quicker than trace
> > reading/analysis. A buffering scheme is mostly always necessary.
> >
> 
> Very valid point, I'll for sure keep that in mind.
> 
> This speaks strongly against replacing relayd with something homebrewed, as
> was the original plan. We'd probably not be able to shuffle the data fast
> enough over the network to keep up with the pace.

If you are unable to "reserve" RAM/network bandwidth and/or use FLASH this is
slowly becoming a "you can't have your cake and eat it too" situation. This must
be frustrating...

> >
> > You can also use the --trace-file-size and --trace-file-count to limit the
> > disk
> > footprint of each live session. Make sure to have enough buffer for live
> > reading if still using live.
> >
> 
> This isn't an option as our disc is flash based and we'd like to limit the
> wear due to collecting metrics.

I was under the impression that the lttng-relayd process was on another device.
I misunderstood the situation.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
