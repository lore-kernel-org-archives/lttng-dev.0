From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: A question on protocols
Date: Tue, 20 Nov 2018 12:16:39 -0500
Message-ID: <20181120171639.GA12088__16220.6941786737$1542734090$gmane$org@joraj-alpa>
References: <CANzOjBhikh_81hsu4b3pvneBNEX+PWjzWfx_K-jc-s0X0==zDQ@mail.gmail.com>
 <20181116171557.GA23758@joraj-alpa>
 <CANzOjBgXXbPXHw6oZetVr3pOJq51Pg+aWUpRP0f0WhZUqEdB8g@mail.gmail.com>
 <20181119184641.GA8739@joraj-alpa>
 <CANzOjBg2J-N=BaVesc=WKWwJMiOUX+FsunTdzZBUM-tNvOC7bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42zsnR4GLBzqxs
 for <lttng-dev@lists.lttng.org>; Tue, 20 Nov 2018 12:16:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CANzOjBg2J-N=BaVesc=WKWwJMiOUX+FsunTdzZBUM-tNvOC7bw@mail.gmail.com>
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

> Sure, so given this I cannot use relayd for our purposes. The only other
> option would be to set LTTng to local tracing, which we don't have flash
> for. My hope was that we could somehow stream the CTF records somewhere
> else, over that HTTP proxy, ot be analyzed. As you explained earlier, the
> relayd can be viewed as a FTP server of sorts. So that will most likely not
> work.

A possibility would be to spare some RAM (not easy I know), mount a tmpfs,
configure the session to output to the tmpfs, use session rotation based on
size, send the data, remove the data, rinse and repeat. Now the question is what
is the amount of tracing data generated and the amount of RAM available.

> We have RAM for the tracing buffer, no issues there. The tracing buffer is
> just a temporary medium until you get the trace on disc, possibly via
> relayd. Correct?

Yes.

The consumerd is responsible for fetching the data from the buffers, then it
output it locally or send it over the network to lttng-relayd.

You can take a look at the interaction here:

https://lttng.org/docs/v2.10/#doc-plumbing

> 
> I interpretted your RAM disc suggestion as a place where I could store the
> trace instead of using flash.

This was the correct interpretation.

> 
> Perhaps i could have been more clear on the situation as well.
> 
> We have LTTng tracing capabilites on our devices. During development we can
> use LTTng on the device and relayd on our dev machines and everything works
> great.

Glad to hear it.

> 
> In production, the situation is different.
> 
> The only means we have of transporting anything from the device is a HTTP
> proxy. We're trying to find a way where we can keep a conitnuous LTTng
> trace on the device, tunnel it through the HTTP proxy and analyze the data
> remotely.
> 
> The devices are in the embedded realm, limited amounts of RAM, CPU, and
> flash. This limits what we can do on the device when it comes to storage
> for example.
> 
> Hopefully I've made our situation a bit more clear.
> 
> Based on our discussion so far, I have to say that LTTng is starting to
> look less and less as a viable way forward for us.

It would be quite disappointing if you would not be able to reuse the work done
for instrumenting your applications.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
