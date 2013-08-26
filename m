From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Mon, 26 Aug 2013 16:24:07 +0200
Message-ID: <20130826162407.1996f085__24413.2989006632$1377527135$gmane$org@skate>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
	<CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
	<CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from top.free-electrons.com ([176.31.233.9]
	helo=mail.free-electrons.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thomas.petazzoni@free-electrons.com>)
	id 1VDxiI-0004Uz-4x
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 10:24:19 -0400
In-Reply-To: <CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Dear Jimmy Durand Wesolowski,

On Mon, 26 Aug 2013 09:43:49 +0200, Jimmy Durand Wesolowski wrote:

> Here is a quick test, without any of my modifications. I had to pass both
> CFLAGS and LDFLAGS to "./configure", as said earlier, which can be
> considered
> a normal process:
> CFLAGS="-I<URCU_BUILD_PATH>/include" \
>   CPPFLAGS="-I<URCU_BUILD_PATH>/include" \
>   LDFLAGS="-L<URCU_BUILD_PATH>/lib" \
>   ./configure --prefix=${PWD}/build

As said previously, if you're cross-compiling, doing
--prefix=${PWD}/build is completely wrong. --prefix is the directory
where the software will be located when executed on the target, not the
location where the software will be installed when doing 'make install'.

Please document yourself on the difference between --prefix at
configure time and DESTDIR at install time.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
