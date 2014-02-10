From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Update in the babeltrace live CLI
Date: Mon, 10 Feb 2014 18:41:03 -0500
Message-ID: <52F9638F.7070605__7857.20784119821$1392075742$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1WD0TP-0003dY-4q
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 18:41:16 -0500
Received: from [172.30.42.98] (unknown [192.222.130.16])
	by fukushima.klipix.org (Postfix) with ESMTPSA id 60281460073
	for <lttng-dev@lists.lttng.org>; Tue, 11 Feb 2014 00:41:04 +0100 (CET)
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

TL;DR:
the new URL format for Babeltrace live is :
$ babeltrace -i lttng-live net://host/<hostname>/<session-name>

Also the protocol has been slightly updated (main change : we require
the viewer to create a viewer_session before attaching to one or
multiple sessions), if you started to work on a live viewer, please make
sure you read doc/live-reading-protocol.txt in lttng-tools and update
your lttng-viewer-abi.h file.


More details :
For the adventurous ones who had already tried LTTng live with
Babeltrace, you were doing :
$ babeltrace -i lttng-live net://localhost/42

To connect to the session 42 on the relay running on localhost.
You might have noticed that if you had kernel and UST tracing running
inside the same session, you would see 2 sessions with the same name on
the relay and no way to attach to both of these.

As of now, this limitation is gone, the protocol allows to attach to
multiple "sessions" as seen by the relay. In Babeltrace, we now
automatically merge the sessions with the same hostname and
session-name, so if the user creates a session with kernel and UST
events, he will receive all the events when he attaches to the session
(as would be expected).
There might be clashes if two servers on the network have the same
hostname and create the same session name, but for now the relay cannot
distinguish these cases, so it is currently a known limitation. If you
implement your own client, you can choose which session you want to
attach to.
Finally, notifications are sent when new streams are created (especially
useful when using per-pid tracing), if you implement the protocol,
please make sure you check the return flags when necessary.

So the new URL format for Babeltrace live is :
$ babeltrace -i lttng-live net://host/<hostname>/<session-name>

If you have any questions, don't hesitate to ask here.

Have fun !

Julien
