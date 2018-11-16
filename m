From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: A question on protocols
Date: Fri, 16 Nov 2018 12:15:57 -0500
Message-ID: <20181116171557.GA23758__14448.5934557908$1542388446$gmane$org@joraj-alpa>
References: <CANzOjBhikh_81hsu4b3pvneBNEX+PWjzWfx_K-jc-s0X0==zDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42xPyV40nKzs9k
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 12:16:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CANzOjBhikh_81hsu4b3pvneBNEX+PWjzWfx_K-jc-s0X0==zDQ@mail.gmail.com>
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

On Fri, Nov 16, 2018 at 09:49:52AM +0100, mrx wrote:
> Hi,
> =

> I have a need to collect LTTng live-traces from systems with very limited
> RAM
> and flash resources. This tracing will be running continuesly for months
> monitoring our systems. The only way for me to transport those CTF records
> somewhere else is via HTTP proxy. LTTng doesn't seem to have support for
> sending
> over proxies at all. So I think I really have a challenge a head of me, if
> this
> is at all possible.

VPN through http proxy. Better alternative would be to speak with your sysa=
dmin
and see what you can do. Keep in mind that the protocol between relayd and
consumer is in no way "secure".

> =

> The plan is to write my own relayd from which I can then stream the
> received CTF
> records + metadata to where I can analyze them. For this to work I need
> documentation on the protocol between consumerd and relayd. I cannot find
> the
> documentation for this, where can I find it?

The source code.

> =

> Do you think this is a viable solution?

Doubt it. But we never know.

> =

> Once I receive the data where I have the possiblity to analyze it. Then I=
'm
> not
> sure if I'm required to write everything to the file system to be able to
> analyze the data. How would I then rotate the logs on disc so I can clean
> up?

The 2.11 release will include a new feature for session rotation.

See this presentation [1] from J=E9r=E9mie Galarneau explaining how the ses=
sion rotation
can be used.

[1] https://events.linuxfoundation.org/wp-content/uploads/2017/12/Fine-grai=
ned-Distributed-Application-Monitoring-Using-LTTng-J%C3%A9r%C3%A9mie-Galarn=
eau-EfficiOS.pdf


> The best for me would be if I didn't have to go via disc at all I think.
> =

> Are there any others working on similar solution, if so, how are they
> solving this?
> How would you recommend I solve this?

I would go for session rotation via relayd (not in live mode) with a daemon
watching for ready-to-consume chunks. You can adjust for the granularity
you need at the target level.

This could be done close to the target then compress the trace chunks and s=
end them
over http(s) to the monitoring pipeline.

> =

> The reason the current relayd doesn't work for me is two-fold:
> 1. I cannot get relayd to not write down the trace to disc. Can you contr=
ol
> this at all for live tracing?

What is the real reason for not writing to disk on the relayd side?

> 2. I cannot find the documentation for the relayd <-> viewer protocol.
> Where can I find it?

Source code. The initial design proposal is under doc/ in the lttng-tools t=
ree.

> =

> It might be that storing the traces on disc is a pre-requisite for servin=
g a
> viewer properly. Perhaps it's just something required by relayd based on
> how it works internally. I don't know.

You can look at relayd as a specialized ftp server. The user is responsible=
 in
managing the lifetime of the traces generated. The live protocol simply all=
ow a
viewer to see the trace as it get received/stored.

Nothing prevent you to output on a tmpfs (ramdisk) if hitting the disk is s=
uch a
problem.

Keep in mind that trace production is normally much more quicker than trace
reading/analysis. A buffering scheme is mostly always necessary.

You can also use the --trace-file-size and --trace-file-count to limit the =
disk
footprint of each live session. Make sure to have enough buffer for live
reading if still using live.

Cheers
-- =

Jonathan Rajotte-Julien
EfficiOS
