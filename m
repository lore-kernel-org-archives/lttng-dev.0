From: Jan Glauber <jan.glauber@gmail.com>
Subject: LTTng system call tracing on ARM
Date: Wed, 10 Apr 2013 10:40:54 +0200
Message-ID: <20130410084053.GB25958__6450.42205364934$1365583291$gmane$org@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1UPqaW-0001ke-Fk
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 04:41:04 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg1so91143bkc.9
	for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2013 01:40:58 -0700 (PDT)
Content-Disposition: inline
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

Hi,

I want to use LTTng for system call tracing on ARM. Now lttng-modules seems
to support system call tracing on ARM already since
"8f4f80e LTTng Modules ARM syscall instrumentation".

But I wonder how that worked since lttng-syscalls.c is only build under
CONFIG_HAVE_SYSCALL_TRACEPOINTS and that was added to ARM only with kernel 3.6
(much after than the lttng-modules commit).

Am I missing something? Is system call tracing working on ARM with the upstream
LTTng version?

thanks,
Jan
