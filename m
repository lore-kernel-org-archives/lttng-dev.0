From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.3.4
Date: Tue, 3 Dec 2013 06:03:11 +0000 (UTC)
Message-ID: <603265753.78823.1386050591504.JavaMail.zimbra__12587.1898061179$1386050632$gmane$org@efficios.com>
References: <1399022047.78820.1386050542008.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vnj4k-0005Mo-SZ
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 01:03:15 -0500
In-Reply-To: <1399022047.78820.1386050542008.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: lttng-dev@lists.lttng.org

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

Changelog:
2013-12-03 LTTng modules 2.3.4
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
