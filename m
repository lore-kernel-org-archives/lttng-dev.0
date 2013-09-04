From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Request information on "Live" view of traces
Date: Wed, 04 Sep 2013 10:30:55 -0400
Message-ID: <5227441F.4050908__36581.6969461322$1378305127$gmane$org@efficios.com>
References: <CAFw4v59-2FvgVtQ=YCNhYXX3B9+y+hNdFpb0JnpOHxNCvc5vCA@mail.gmail.com>
	<CAGDH53n23sZ30Uh+7DUmfM2oujb3R6yu-CroROztqhDchffJKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VHE6u-0006iV-JK
	for lttng-dev@lists.lttng.org; Wed, 04 Sep 2013 10:31:15 -0400
In-Reply-To: <CAGDH53n23sZ30Uh+7DUmfM2oujb3R6yu-CroROztqhDchffJKA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dror Granot <dror@reduxio.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

[...]

> 
>> I would really appreciate if you can update me on the time frame of "live"
>> view of traces. If you know, what will it include and when it is supposed to
>> be, it can help us much in our decision.

The 2.4 release will include a major upgrade in the lttng-relayd to
support live trace viewing.
The trace viewers will be able to connect to a new TCP port on the relay
to list the tracing sessions currently established, attach to a session,
receive all the streams for this session, and then ask for metadata and
trace packets.
The live trace reading mechanism offers guarantees that the viewer can
never be in a position where it has to assume that it can read the trace
safely. It is forced to fetch all the metadata before being able to read
the trace and it receives information on all streams at a regular
interval (user-defined).

Along with this release of lttng-tools, we will provide a reference
client in C for Babeltrace that will handle this new protocol.

As of now, the live trace reading is working as a prototype in my
development branches on github, if you want to try them I can send you
the details, but I don't have much time to provide support on these
branches.

I will send updates on this mailing-list as soon as I consider this
feature ready to test.
I hope it answers your question, if you want more details, please don't
hesitate to ask.

Thanks,

Julien
