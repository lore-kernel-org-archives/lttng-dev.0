From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Debian 3.16.7-ckt9-2 issue with lttng-modules kmem probe
Date: Thu, 23 Apr 2015 21:07:25 +0000 (UTC)
Message-ID: <844104542.35292.1429823245769.JavaMail.zimbra__21962.850893806$1429823343$gmane$org@efficios.com>
References: <1082981755.35270.1429823095435.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YlOLH-0001BT-Jx
 for lttng-dev@lists.lttng.org; Thu, 23 Apr 2015 17:07:36 -0400
In-Reply-To: <1082981755.35270.1429823095435.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Alexandre Montplaisir <alexmonthy@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi Jon,

It appears that lttng-modules cannot build on the
Debian kernel 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt9-2 (2015-04-13)
x86_64 GNU/Linux.

It appears that their exported kmem.h header differs from
the upstream stable branch, but AFAIK there is no Debian-specific
version number available to distinguish between upstream stable
and the Debian kernel.

We have been hit by this in the past for Ubuntu kernels, and the
solution has been to introduce a UTS_UBUNTU_RELEASE_ABI define
into their kernels, which can be used to follow their own kernel
versions.

Do you think we could ask Debian to do the same ?

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
