From: Karim Yaghmour <karim.yaghmour@opersys.com>
Subject: Re: [PATCH] LTTng logger ABI
Date: Mon, 17 Feb 2014 19:06:09 -0500
Message-ID: <5302A3F1.6090508__21667.8449222401$1392682041$gmane$org@opersys.com>
References: <1392671512-9136-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <karim.yaghmour@opersys.com>) id 1WFYCW-0006yv-6h
	for lttng-dev@lists.lttng.org; Mon, 17 Feb 2014 19:06:22 -0500
Received: by mail-qg0-f47.google.com with SMTP id 63so5897913qgz.6
	for <lttng-dev@lists.lttng.org>; Mon, 17 Feb 2014 16:06:10 -0800 (PST)
In-Reply-To: <1392671512-9136-1-git-send-email-mathieu.desnoyers@efficios.com>
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


On 14-02-17 04:11 PM, Mathieu Desnoyers wrote:
> Add a user-space ABI (new file /proc/lttng-logger) to lttng-modules
> which can be written into by any user on the system. The content is
> saved into the kernel trace stream into the "lttng_logger" kernel event.
> 
> The content of a single write is written into an lttng_logger event.
> The write count is truncated to 1024 bytes (if larger), which is much
> smaller than the smallest subbuffer size available (4096 bytes). This
> ensures all written data makes it into the active tracing buffers.

Very nice. Let me know when this is in so that I can schedule giving it
a try on Android.

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour
