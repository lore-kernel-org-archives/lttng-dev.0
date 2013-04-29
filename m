From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: UST tracepoints, same provider, different files
Date: Mon, 29 Apr 2013 09:58:01 -0400
Message-ID: <CAFXXi0=52W6vKHO6GA2dFPUPocVXPJD23HSG6K=riQTgWaDoTQ__11570.1833194636$1367243944$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UWobF-00038F-7a
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 09:58:37 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so5707795iag.0
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 06:58:31 -0700 (PDT)
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

Hello !

I am trying to add two tracepoints to a simple test application. If I
put both tracepoints in different compilation units (two .c files),
UST crashes when the application starts with the following message:

test: /usr/local/include/lttng/ust-tracepoint-event.h:685:
__lttng_events_init__my_project: Assertion `!ret' failed.

I made an example [1] so you can simply run "make && ./test". I am
using the latest git versions, on Ubuntu 13.04 x86_64.

Thanks !

Simon

[1] http://git.dorsal.polymtl.ca/~smarchi?p=ust-test.git;a=summary
