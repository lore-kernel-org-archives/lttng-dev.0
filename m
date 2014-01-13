From: Corey Minyard <minyard@acm.org>
Subject: Extract lttng trace from kernel coredump
Date: Mon, 13 Jan 2014 16:39:47 -0600
Message-ID: <52D46B33.4010401__33875.157548073$1389724788$gmane$org@acm.org>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tcminyard@gmail.com>) id 1W2qAl-0006GS-Sh
	for lttng-dev@lists.lttng.org; Mon, 13 Jan 2014 17:40:01 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so8519604obb.32
	for <lttng-dev@lists.lttng.org>; Mon, 13 Jan 2014 14:39:50 -0800 (PST)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net.
	[173.57.152.84]) by mx.google.com with ESMTPSA id
	oo13sm26235176oeb.0.2014.01.13.14.39.48
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 13 Jan 2014 14:39:49 -0800 (PST)
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

I'm working on a feature to allow an lttng trace to be extracted from a
kernel coredump, and I'm wondering the best way to proceed.  I've looked
at extracting from the existing data structures, but that would require
something to always have a trace file open and it looks more than a
little complicated.  I was thinking instead of having a different trace
channel for configuring this coredump and some globals to point to the
various data structures.  Would that be the best way to pursue this?  Is
there a better way, perhaps?

Thanks,

-corey
