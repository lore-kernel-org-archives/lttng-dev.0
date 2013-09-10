From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Request information on "Live" view of traces
Date: Tue, 10 Sep 2013 07:38:05 -0700
Message-ID: <522F2ECD.7030509__9361.53802690587$1378823959$gmane$org@efficios.com>
References: <CAFw4v59-2FvgVtQ=YCNhYXX3B9+y+hNdFpb0JnpOHxNCvc5vCA@mail.gmail.com>	<CAGDH53n23sZ30Uh+7DUmfM2oujb3R6yu-CroROztqhDchffJKA@mail.gmail.com>
	<5227441F.4050908@efficios.com>
	<OF4342D089.5717C1CD-ONC2257BE2.003AD21A-C2257BE2.003B13DD@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1VJP50-0006wU-Hq
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 10:38:18 -0400
In-Reply-To: <OF4342D089.5717C1CD-ONC2257BE2.003AD21A-C2257BE2.003B13DD@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Dror Granot <dror@reduxio.com>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 10/09/13 03:45 AM, Amit Margalit wrote:
> Hi,
>
> > The 2.4 release will include a major upgrade in the lttng-relayd to
> > support live trace viewing.
> > The trace viewers will be able to connect to a new TCP port on the relay
> > to list the tracing sessions currently established, attach to a session,
> > receive all the streams for this session, and then ask for metadata and
> > trace packets.
>
> Is relayd going to be the only way that a viewer can achieve this?
>
> I'm actually only interested in having libbabeltrace be able to read
> the trace up to the last valid event at a specific time, and not
> interested in "live" viewing of the events as they happen.

I guess that you are mostly interested in making sure your traces are
readable after a crash from the system that produces them, right ?

Thanks,

Mathieu


>
> Thanks,
>
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
>
>
>
> From:        Julien Desfossez <jdesfossez@efficios.com>
> To:        Dror Granot <dror@reduxio.com>
> Cc:        "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
> Date:        09/04/2013 05:32 PM
> Subject:        Re: [lttng-dev] Request information on "Live" view of
> traces
> ------------------------------------------------------------------------
>
>
>
> Hi,
>
> [...]
>
> >
> >> I would really appreciate if you can update me on the time frame of
> "live"
> >> view of traces. If you know, what will it include and when it is
> supposed to
> >> be, it can help us much in our decision.
>
> The 2.4 release will include a major upgrade in the lttng-relayd to
> support live trace viewing.
> The trace viewers will be able to connect to a new TCP port on the relay
> to list the tracing sessions currently established, attach to a session,
> receive all the streams for this session, and then ask for metadata and
> trace packets.
> The live trace reading mechanism offers guarantees that the viewer can
> never be in a position where it has to assume that it can read the trace
> safely. It is forced to fetch all the metadata before being able to read
> the trace and it receives information on all streams at a regular
> interval (user-defined).
>
> Along with this release of lttng-tools, we will provide a reference
> client in C for Babeltrace that will handle this new protocol.
>
> As of now, the live trace reading is working as a prototype in my
> development branches on github, if you want to try them I can send you
> the details, but I don't have much time to provide support on these
> branches.
>
> I will send updates on this mailing-list as soon as I consider this
> feature ready to test.
> I hope it answers your question, if you want more details, please don't
> hesitate to ask.
>
> Thanks,
>
> Julien
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
