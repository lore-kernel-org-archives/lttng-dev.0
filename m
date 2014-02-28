From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.2.4 (end of life)
Date: Fri, 28 Feb 2014 17:38:48 +0000 (UTC)
Message-ID: <366792064.32293.1393609128706.JavaMail.zimbra__43846.4267099791$1393609192$gmane$org@efficios.com>
References: <2005762972.32290.1393609087264.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJROc-00068i-I8
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 12:38:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id B2B443401DF
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:38:51 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id xHYts9g3G1GZ for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:38:49 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 2C49D34024C
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:38:49 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
	by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id L8ns8_zmD_Fh for <lttng-dev@lists.lttng.org>;
	Fri, 28 Feb 2014 17:38:49 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
	by mail.efficios.com (Postfix) with ESMTP id E14CD3401DF
	for <lttng-dev@lists.lttng.org>; Fri, 28 Feb 2014 17:38:48 +0000 (UTC)
In-Reply-To: <2005762972.32290.1393609087264.JavaMail.zimbra@efficios.com>
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

Please note that this is the last version of the stable-2.2 lttng-modules
branch. You are encouraged to move to either 2.4, or 2.3.

Changelog:
2014-02-28 LTTng modules 2.2.4
        * Fix: load state dump even if work-around lookup fails
        * Fix: Add statedump exit so module is not permanent
        * Fix: OOT lttng-statedump tracepoints not visible with signed kernels
        * Fix: tracepoint event name mapping at unregister
        * Fix: ring buffer check deliver compile fix
        * Fix: tracepoint name remapping
        * Fix: quote event name in metadata
        * Fix: handle unknown event type parameter
        * Fix: eliminate timestamp overlap between packets
        * gcc blacklist: only apply when building with gcc
        * Blacklist ARM gcc 4.8.0, 4.8.1, 4.8.2

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
