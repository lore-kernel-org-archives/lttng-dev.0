From: Karim Yaghmour <karim.yaghmour@opersys.com>
Subject: Re: [RFC PATCH lttng-modules] LTTng logger ABI
Date: Mon, 17 Feb 2014 11:13:42 -0500
Message-ID: <53023536.9050007__2121.02386071837$1392653692$gmane$org@opersys.com>
References: <1392502096-1900-1-git-send-email-mathieu.desnoyers@efficios.com>
	<53022631.90209@opersys.com>
	<1718413437.26031.1392653324422.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <karim.yaghmour@opersys.com>) id 1WFQpI-0003Kp-N8
	for lttng-dev@lists.lttng.org; Mon, 17 Feb 2014 11:13:54 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so23771229qcx.38
	for <lttng-dev@lists.lttng.org>; Mon, 17 Feb 2014 08:13:43 -0800 (PST)
In-Reply-To: <1718413437.26031.1392653324422.JavaMail.zimbra@efficios.com>
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


On 14-02-17 11:08 AM, Mathieu Desnoyers wrote:
> I'd be tempted to ask: is that the behavior of ftrace when receiving an
> event larger than a page through trace_marker ?

I've never bothered looking it up to be quite honest.

> We could indeed truncate the event, but it would increase complexity
> compared to the current patch. So I'm tempted to wait a bit before doing so.

What's the maximum length of events lttng-logger will take? We just
truncate in the Android user-space library that writes the atrace events.

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour
