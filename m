From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building	patches.
Date: Mon, 26 Aug 2013 12:00:38 -0400
Message-ID: <20130826160038.GB17119__21726.924487348$1377532891$gmane$org@Krystal>
References: <CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
	<CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
	<CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ@mail.gmail.com>
	<20130826162407.1996f085@skate> <20130826151147.GA16659@Krystal>
	<CAD7SSK6FBSEyAzdAmq0Wfr8xyDt6vF9Na6TVdQh_GEUtqqPa6A@mail.gmail.com>
	<20130826151917.GA16924@Krystal> <20130826152759.GA17057@Krystal>
	<CAD7SSK47NJqbMUrcUPndfkgQPo2jik2FLmULm-vfj7SJFv9tjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VDzDb-0000HT-AE
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 12:00:44 -0400
Content-Disposition: inline
In-Reply-To: <CAD7SSK47NJqbMUrcUPndfkgQPo2jik2FLmULm-vfj7SJFv9tjQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> 2013/8/26 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> > I got it to work. See those commits in master:
> >
> Great, thank you.
> I just got a little problem about libraries, and took only a chunk of my
> patch
> to correct it.
> I also kept the --with-rcu-path (renamed from --with-rcu-prefix) configure
> option, but if you do not like it, of course, feel free to remove it.
> I will send this in a moment.

Please make sure you detail your use-case (how to reproduce the issue)
along with your patch.

Thanks,

Mathieu

> 
> 
> Thank you,
> -- 
> Jimmy Durand Wesolowski
> OpenWide R&D engineer
> OneAccess

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
