From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [RFC PATCH lttng-tools] Fix printk instrumentation
Date: Thu, 04 Jul 2013 15:19:14 -0400
Message-ID: <51D5CAB2.7050101__48859.829750336$1372965604$gmane$org@gmail.com>
References: <20130704165855.GB31483@Krystal> <51D5B319.6060700@gmail.com>
	<20130704182228.GA332@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Uup3t-0004eF-61
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 15:19:25 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so3733355iec.21
	for <lttng-dev@lists.lttng.org>; Thu, 04 Jul 2013 12:19:19 -0700 (PDT)
In-Reply-To: <20130704182228.GA332@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-07-04 14:22, Mathieu Desnoyers wrote:
> * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
>> 3.9: Works
>> 3.2: Fail to enable with this error msg (will try to get more detailled
>> info or fix)
>> root@debian-wheezy:/home/scientist# lttng enable-event -k console
>> PERROR [6648/6745]: create event ioctl: Invalid argument (in
>> kernel_create_event() at kernel.c:205)
>> Error: Event console: Enable kernel event failed (channel channel0,
>> session auto-20130630-135404)
>> Warning: Some command(s) went wrong
> Hrm, make sure the "condition" trace event actually exist in 3.2 ?
>
Ok, my bad, the printk_console traceport was added only in 3.4, which
works well.

Yannick
