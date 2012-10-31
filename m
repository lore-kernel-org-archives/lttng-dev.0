From: Julien Desfossez <jdesfossez@efficios.com>
Subject: RFC live trace reading use-cases
Date: Wed, 31 Oct 2012 15:09:18 -0400
Message-ID: <5091775E.5040609__1183.2794094973$1351710598$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TTdfJ-0003Sb-Hi
	for lttng-dev@lists.lttng.org; Wed, 31 Oct 2012 15:09:25 -0400
Received: from [132.207.72.34] (dyn34.dorsal.polymtl.ca [132.207.72.34])
	by fukushima.klipix.org (Postfix) with ESMTPSA id DF9D2120515
	for <lttng-dev@lists.lttng.org>; Wed, 31 Oct 2012 20:09:19 +0100 (CET)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

We are currently working on defining a design for live trace reading and
before commiting to one, we would like to have a list of all the
relevant use-cases we have to take into account.

Just to clarify, live trace reading means displaying/analyzing a trace
while it is being recorded by a tracer.

Here are the use-cases I have collected so far :
- reading a trace from the disk of the machine that is currently being
traced;
- reading a trace from a remote machine on the disk of the machine
running lttng-relayd (receiving the trace on the network);
- reading the trace directly from the memory of the local tracer (mmap
shared buffers);
- reading the trace from the memory of a lttng-relayd daemon receiving
the trace from the network but never writing it to disk.

In all these cases, the tracing session might be a new one or a session
already started. If the session is already started we could want to
"attach" the viewer to it and read the data either from the beginning or
from "now".

Of course we want to keep the privilege separation and make sure the
viewer is allowed to read the trace.

We at least want to support the C/C++ and Java viewers and for the
remote use-cases we might have to support viewers running on Windows as
well.
So we need an interface between the consumerd/relayd that will be common
to all these possible viewers.

I will not discuss here the early solutions we have right now to avoid
influencing the decision, I am just interested in collecting the
use-cases first.

If you have other use-cases that you think might be interesting to
support, please send them as soon as possible.
We are in brainstorm mode, after that phase we will decide the use-cases
we want to support/prioritize.

Thanks,

Julien
