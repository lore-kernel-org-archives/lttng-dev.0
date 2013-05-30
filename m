From: Aryeh Weinreb <weinrea@gmail.com>
Subject: linking c++ with shared object tracepoints
Date: Thu, 30 May 2013 11:51:15 +0300
Message-ID: <CAE5ibEn5d479UzR4_zFt3nj2T6pbS94ZS50F=dkxZN3RzarvfQ__36191.5658963428$1369903940$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f194.google.com ([209.85.192.194])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <weinrea@gmail.com>) id 1UhyZt-0000wh-6R
	for lttng-dev@lists.lttng.org; Thu, 30 May 2013 04:51:21 -0400
Received: by mail-pd0-f194.google.com with SMTP id 3so2879449pdj.5
	for <lttng-dev@lists.lttng.org>; Thu, 30 May 2013 01:51:15 -0700 (PDT)
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

Hi there,

I am trying to link c++ code with c compiled tracepoints.
It works when I link directly but when I put the tracepoints in a
dynamic lib first I get an undefined reference to "tracepoint_dlopen".
Is supported to link c++ code with c compiled tracepoints put it a dynamic lib?

When I remove the hidden attribute from tracepoint_dlopen in
lttng/tracepoint.h it links okay.
What is the reason for declaring it hidden in the first place? Is it
safe to remove it?

Thanks,
aryeh
