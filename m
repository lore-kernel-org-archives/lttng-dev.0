From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTNG UST configure error (lttng-ust-2.1.2)
Date: Wed, 17 Apr 2013 13:55:37 -0400
Message-ID: <20130417175537.GA13557__8293.5378341519$1366221362$gmane$org@Krystal>
References: <05E83BDD0E1F054FA73F00F6970F05C60618B3@CH1PRD0810MB394.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1USWa2-0002NR-Kh
	for lttng-dev@lists.lttng.org; Wed, 17 Apr 2013 13:55:38 -0400
Content-Disposition: inline
In-Reply-To: <05E83BDD0E1F054FA73F00F6970F05C60618B3@CH1PRD0810MB394.namprd08.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Hari Prasad Kalavakunta (Hari.Prasad@radisys.com) wrote:
> Hi lttng-dev,
> 
> I am struck with the following road block. Could you please help me.
> 
> While cross-compiling  LTTNG UST for ppc32 I choose
> --disable-libtool-linkdep-fixup (https://bugs.lttng.org/issues/321)
> for configure to avoid dependency on libuuid as shown below.

The option --disable-libtool-linkdep-fixup has nothing to do with
libuuid.

See ./configure --help for details.

> 
> CFLAGS="-m32 -g -O2" ./configure --disable-libtool-linkdep-fixup  --prefix=/home/xxx/linux-3.4.3/ --host=powerpc-linux --with-sysroot=/home/xxx/linux-3.4.3/
> 
> Yet, the dependencies are not completely removed. I am cross compiling
> LTTNG UST for PPC32. It did not look like I need libuuid. Could you
> please let me know how to overcome it. Or do I need libuuid for PPC32?

For lttng-ust 2.1.x, you need libuuid.

Note that for the newer lttng-ust 2.2-rc, libuuid is not needed anymore
for lttng-ust. However, you seem to be building with lttng-ust 2.1.x.

Thanks,

Mathieu

> 
> I have successfully cross compiled and installed userspace-rcu for ppc32.
> 
> Please let me know if I need to provide any additional details.
> 
> Regards,
> Hari
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
