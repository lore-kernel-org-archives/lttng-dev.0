From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: issue with lttng-tools 2.5.3 tarball release version
Date: Wed, 24 Dec 2014 15:54:03 +0000 (UTC)
Message-ID: <1721058393.32163.1419436443460.JavaMail.zimbra__31796.895483467$1419436493$gmane$org@efficios.com>
References: <366858222.32159.1419436364322.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Y3oGD-0003CG-Uo
 for lttng-dev@lists.lttng.org; Wed, 24 Dec 2014 10:54:06 -0500
In-Reply-To: <366858222.32159.1419436364322.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jeremie,

Just to make sure you get this when you come
back from vacation: (from #lttng on irc)

13:56 < emalape> Hi guys! I just installed lttng-tools 2.5.3 from the source 
                 tarball. If I do "lttng -V" it reports a wrong version string: 
                 lttng (LTTng Trace Control) heads/stable-2.5-0-g5f82d26 - 
                 Fumisterie
13:56 < emalape> I think this happened before and someone recreated the tarball 
                 to fix this. Would it be possible to fix again :)
13:57 < emalape> For comparison, 2.5.1 prints this: lttng (LTTng Trace Control) 
                 2.5.1 - Fumisterie

I think we'll need to do a 2.5.4 lttng-tools release
to fix this mistake from the 2.5.3 release. Probably that
you need to tag your git repo before issuing make dist.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
