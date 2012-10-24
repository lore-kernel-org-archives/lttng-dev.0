From: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Subject: registering user-defined properties on tracepoints
Date: Wed, 24 Oct 2012 11:21:55 +0000
Message-ID: <7F632A9222059A42AF70FCB7965774AA2086527B__545.573180034076$1351077756$gmane$org@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com ([147.11.146.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew.McDermott@windriver.com>) id 1TQz2A-00080b-6f
	for lttng-dev@lists.lttng.org; Wed, 24 Oct 2012 07:22:02 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q9OBLvfq015370
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Wed, 24 Oct 2012 04:21:57 -0700 (PDT)
Content-Language: en-US
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


Is it possible to add /other/ user-defined attributes to an event
definition.  What I'm trying to do is associate other related
properties/attributes to the event itself and on each field in the
event.

In this example I'm choosing to encode my attributes using a JSON-like
syntax, but the point is that this is really user-defined.

  TRACEPOINT_EVENT(foo, some_event,
	TP_ARGS(int, value),
        TP_ATTRIBUTES("{ icon:some_event.png, helpIndex:docs/help/0001.html ... }")
	TP_FIELDS(ctf_integer(int, foo, foo, "{java_formatter:com.windriver.SomeEventFormatter, leftAdjust:1, mask:64, ... }"))
  )

I could create an associated event:

  TRACEPOINT_EVENT(foo, some_event_metadata,
	TP_ARGS(char *, str),
	TP_FIELDS(ctf_string(char *, str))
  )

and have some rules based on the event names to bind the two together
but it seems "nicer" to keep them together.  My motivation is keeping
this kind of auxiliary information available with the trace itself as
opposed to some side-files which have the tendency to get out of sync.

Or perhaps this is another way of achieving this.  Any hints gratefully
received...

Thanks,
Andy.
