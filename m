From: Karim Yaghmour <karim.yaghmour@opersys.com>
Subject: Re: [RFC PATCH lttng-modules] LTTng logger ABI
Date: Mon, 17 Feb 2014 11:41:59 -0500
Message-ID: <53023BD7.6060401__28510.0146233619$1392655466$gmane$org@opersys.com>
References: <1392502096-1900-1-git-send-email-mathieu.desnoyers@efficios.com>
	<53022631.90209@opersys.com>
	<1718413437.26031.1392653324422.JavaMail.zimbra@efficios.com>
	<53023536.9050007@opersys.com>
	<1098265448.26099.1392654107038.JavaMail.zimbra@efficios.com>
	<53023832.6010005@opersys.com>
	<1299774859.26113.1392655235092.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <karim.yaghmour@opersys.com>) id 1WFRGg-0003cB-Lt
	for lttng-dev@lists.lttng.org; Mon, 17 Feb 2014 11:42:11 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so23790017qcx.21
	for <lttng-dev@lists.lttng.org>; Mon, 17 Feb 2014 08:42:01 -0800 (PST)
In-Reply-To: <1299774859.26113.1392655235092.JavaMail.zimbra@efficios.com>
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


On 14-02-17 11:40 AM, Mathieu Desnoyers wrote:
> trace.h:#define TRACE_BUF_SIZE		1024
> 
> so actually, ftrace truncates at 1024 bytes. We could very well do the same
> within the lttng-logger write() op.
> 
> Thoughts ?

Sold.

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour
