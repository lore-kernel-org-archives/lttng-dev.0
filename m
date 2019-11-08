From: Benjamin Poirier <benjamin.poirier@gmail.com>
Subject: Workflow to view old and current trace data
Date: Fri, 8 Nov 2019 17:49:38 +0900
Message-ID: <20191108084938.GA7492__29158.7050583743$1573202999$gmane$org@f3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by lists.lttng.org (Postfix) with ESMTPS id 478YqY0Sq6z1S93
 for <lttng-dev@lists.lttng.org>; Fri,  8 Nov 2019 03:49:44 -0500 (EST)
Received: by mail-pf1-x436.google.com with SMTP id x28so4138867pfo.6
 for <lttng-dev@lists.lttng.org>; Fri, 08 Nov 2019 00:49:44 -0800 (PST)
Received: from f3 (ag061063.dynamic.ppp.asahi-net.or.jp. [157.107.61.63])
 by smtp.gmail.com with ESMTPSA id a29sm7760625pfr.49.2019.11.08.00.49.41
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 00:49:42 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi, long time no see!

Consider a system that's recording trace data continuously from a
userspace application. A problem is noticed and I'd like to investigate
it. What workflow would allow me to view past trace data to analyze the
cause of the problem and view current (live) trace data while working on
fixing the problem, all the while keeping a continuous record of events
(ie. not stopping the trace)?

I thought of the following approaches but both seem to have
disadvantages:
1)
Have one continuous tracing session in normal mode. When a problem is
noticed, use lttng-rotate to be able to read old trace data. Start a
second tracing session in live mode with the same event rules to view
live trace data. IIUC, there's no option to prevent lttng-relayd from
writing the traces to disk, so we end up writing two sets of identical
traces to disk during the time we want to look at live trace data.
2)
Have one tracing session running in live mode all the time. When a
problem is noticed, use the viewer on whatever lttng-relayd has flushed
to disk to access old trace data (session rotation is not available).
Furthermore, this workflow has the disadvantage that the trace data is
going through lttng-relayd all the time (which I guess is less efficient
than writing it from lttng-consumerd) merely to support the rare case
where data needs to be seen live while analyzing a problem.

Is there some better approach that I didn't think about? What's your
recommendation to support this workflow?

I'm comparing lttng to the situation where the userspace application is
writing its logs directly to a file. In that case, it's simple to read
the file to access old and "live" data. Of course I realize that lttng
shines in other areas where simple file writing does not ;)

Thank you,
-Benjamin
