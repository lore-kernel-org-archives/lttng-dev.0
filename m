From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RELEASE] LTTng-UST 2.3.1
Date: Tue, 12 Nov 2013 17:29:34 +0000 (UTC)
Message-ID: <188953759.65246.1384277374704.JavaMail.zimbra__12118.3364339688$1384277527$gmane$org@efficios.com>
References: <26867984.65245.1384277317013.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VgHmT-00089o-7o
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 12:29:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 68D0334022F
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:29:37 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id xhJZO5T08ge6 for <lttng-dev@lists.lttng.org>;
	Tue, 12 Nov 2013 17:29:35 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 18F1E340230
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:29:35 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id jQeD4N9P7jkk for <lttng-dev@lists.lttng.org>;
	Tue, 12 Nov 2013 17:29:35 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id EC69C34022F
	for <lttng-dev@lists.lttng.org>; Tue, 12 Nov 2013 17:29:34 +0000 (UTC)
In-Reply-To: <26867984.65245.1384277317013.JavaMail.zimbra@efficios.com>
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

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, November 12, 2013 12:28:37 PM
> Subject: [RELEASE] LTTng-UST 2.3.1
> 
> LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
> port of the low-overhead tracing capabilities of the LTTng kernel tracer
> to user-space. The library "liblttng-ust" enables tracing of
> applications and libraries.
> 
> Changelog:
> 2012-11-12 lttng-ust 2.3.1

I meant 2013-11-12. This is correct in the Changelog file.

Thanks,

Mathieu

>         * Fix: application SIGBUS when starting in parallel with sessiond
>         * Fix: Minor corrections to the lttng-ust man page
>         * Documentation cleanup: Overhaul of the lttng-gen-tp man page
>         * Warning cleanup: add missing padding initializer
>         * Fix: socket connect hang on heavy loads
>         * Cleanup: fix typo
>         * Fix: ust-comm recvmsg should handle partial receive
>         * gcc warning fix: -Wextra
>         * Add usage reference count for tracepoints
>         * tracepoint.c: Move add_callsite/remove_callsite further down in
>         file
>         * Store the callsites into the library callsite list
>         * Fix linking warning
> 
> Project website: http://lttng.org
> Download link: http://lttng.org/download
> (please refer to the README file for installation instructions)
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
