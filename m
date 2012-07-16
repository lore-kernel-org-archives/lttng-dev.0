From: =?ISO-8859-1?Q?S=E9bastien_Barth=E9l=E9my?= <barthelemy@crans.org>
Subject: UST in flight recorder mode
Date: Mon, 16 Jul 2012 14:37:40 +0200
Message-ID: <CAPkDDd7U_jje2_sSgdZyN+GVC8Cvh9hiUefgXhUTKUpAHeRa5w__13370.0412851342$1342442595$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gh0-f176.google.com ([209.85.160.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sebastien.barthelemy@gmail.com>) id 1SqkYc-0004dL-Up
	for lttng-dev@lists.lttng.org; Mon, 16 Jul 2012 08:37:47 -0400
Received: by ghbz10 with SMTP id z10so5725838ghb.35
	for <lttng-dev@lists.lttng.org>; Mon, 16 Jul 2012 05:37:41 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

I'm currently tracking a bug which causes a  full system freeze. It
occurs during long running tests (after a few hours).

The system kernel is too old for being traced with LTTng, but we have a few
UST tracepoints which I used while tracking another bug last year.

I would welcome any advice regarding a methodology to catch it.

My best idea yet is to

1. add tracepoints  where we suspect the bug to reside
2. setup lttng to record in flight recorder mode
3. trig the trace dump when a problem occurs

Right now, we generate not much traces, so I can just skip steps 2 and 3.
However, I'm thinking about having having LTTng always on in the
future, and
thus I would need to use the flight recorder mode.

I have not found explanations or examples on how to trig the trace dump
from software. Is there any?
I had a look at lttng/ust-ctl.h, which seems to be the one header I need.

I also found an old article where Mathieu was talking about "triggerring
tracepoints", does it exist?

I also saw some commits about a "filter" feature. This sound interesting
can someone explain in a few words what this is about?

Cheers

-- Sebastian
