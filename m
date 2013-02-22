From: Samuel Thibault <sthibault@debian.org>
Subject: Re: Package liburcu: build for hurd-i386
Date: Fri, 22 Feb 2013 15:30:32 +0100
Message-ID: <20130222143032.GB8091__14067.4766306349$1361543677$gmane$org@type.bordeaux.inria.fr>
References: <20130222140920.GA22156@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1U8te2-0006Yg-Hj
	for lttng-dev@lists.lttng.org; Fri, 22 Feb 2013 09:30:38 -0500
Content-Disposition: inline
In-Reply-To: <20130222140920.GA22156@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, hurd-i386@buildd.debian.org
List-Id: lttng-dev@lists.lttng.org

Hello,

Mathieu Desnoyers, le Fri 22 Feb 2013 09:09:20 -0500, a =E9crit :
> I noticed a build failure on hurd-i386, and committed a fix in Userspace
> RCU master branch to address this issue. Testing would be welcome.

Unfortunately it doesn't work, because sched_setaffinity is for now just
a fail-stub on hurd-i386, and thus configure considers it as missing,
and thus the CPU_SET test is disabled completely.

I however guess you could just disable defining your own cpu_set_t when
!HAVE_SCHED_SETAFFINITY, since it is probably used only for using
sched_setaffinity.

Samuel
