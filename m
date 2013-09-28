From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.2.2
Date: Sat, 28 Sep 2013 22:35:23 +0000 (UTC)
Message-ID: <157768639.25521.1380407723011.JavaMail.zimbra__595.85658968917$1380407792$gmane$org@efficios.com>
References: <1178967435.25517.1380407640478.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VQ36o-0000Db-9F
	for lttng-dev@lists.lttng.org; Sat, 28 Sep 2013 18:35:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id ACF4C3400B5
	for <lttng-dev@lists.lttng.org>; Sat, 28 Sep 2013 22:35:24 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id Kqh66PUn2JTJ for <lttng-dev@lists.lttng.org>;
	Sat, 28 Sep 2013 22:35:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 939863400EA
	for <lttng-dev@lists.lttng.org>; Sat, 28 Sep 2013 22:35:23 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id ux3SYhnHc_Om for <lttng-dev@lists.lttng.org>;
	Sat, 28 Sep 2013 22:35:23 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id 4D6973400B5
	for <lttng-dev@lists.lttng.org>; Sat, 28 Sep 2013 22:35:23 +0000 (UTC)
In-Reply-To: <1178967435.25517.1380407640478.JavaMail.zimbra@efficios.com>
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

The LTTng modules provide Linux kernel tracing capability to the LTTng 2.x tracer toolset.

Blacklisting kernels 3.10.0 to 3.10.13 and 3.11.0 to 3.11.2. Greg KH has the Linux patches queued for the upcoming stable kernel releases.

Changelog:
2013-09-28 LTTng modules 2.2.2
        * Blacklist kernels 3.10.13 and 3.11.2
        * LTTng trace-clock: shrink kernel blacklist
        * Blacklist Linux kernels 3.10+

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
