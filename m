From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Mon, 26 Aug 2013 16:22:49 +0200
Message-ID: <20130826162249.4b450edb__4477.5441209369$1377527035$gmane$org@skate>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from top.free-electrons.com ([176.31.233.9]
	helo=mail.free-electrons.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thomas.petazzoni@free-electrons.com>)
	id 1VDxh3-0004Qk-Bs
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 10:23:02 -0400
In-Reply-To: <CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jimmy Durand <jimmy.durand.wesolowski@gmail.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Dear Jimmy Durand,

On Sat, 24 Aug 2013 17:34:16 +0200, Jimmy Durand wrote:

> > What feature is this patchset adding that is not covered by the usual
> > approach ? Or what is it fixing ?
> >
> Actually, this is enough for a regular system build, but if you wish to
> build
> it in another directory with --prefix=<PATH>, which is the case for cross-
> compiling, this not enough.

When I hear someone say that --prefix=... is needed for
cross-compilation, it's usually an indication that the
cross-compilation is done incorrectly.

--prefix indicates the location where the software will be *executed*
on the target. So even when you're cross-compiling, the default of
--prefix=/usr or --prefix=/usr/local is fine.

All what you need to do is pass
DESTDIR=/your/temporary/location/on/your/build/machine when doing make
install.

Buildroot (http://buildroot.org), which some of your colleagues at
OpenWide are using, does cross-compile LTTng without such changes to
LTTng build system.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
