From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: GSoC 2013, "C++ probe support" project and more
Date: Wed, 24 Apr 2013 23:21:34 -0400
Message-ID: <1366860094.5178a13e78f12__13146.248079329$1366860125$gmane$org@www.imp.polymtl.ca>
References: <CAJ7wx-Epdf=DV+acPKkXjbXbgPGXHOUnnfOEH_hbpnreL2z4dA@mail.gmail.com>
	<CAJ7wx-Eq4eZ7g52W6c4ETLVHm88xrhOg2u1BjYwhDJ87vT+Kaw@mail.gmail.com>
	<CAGDH53k0DuDWg2sQa2fRfXPMDHLYeyGJr0MXsth0PcxiY6bXUQ@mail.gmail.com>
	<CAJ7wx-EyT-8TzBELBrFUgbhCwwDVorjDRpTaAhf0iTkXnH43cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1UVCka-0003NH-LY
	for lttng-dev@lists.lttng.org; Wed, 24 Apr 2013 23:21:36 -0400
In-Reply-To: <CAJ7wx-EyT-8TzBELBrFUgbhCwwDVorjDRpTaAhf0iTkXnH43cQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Zifei,

Quoting Zifei Tong <soariez@gmail.com>:

> I played with dyninst today. Here is a minimal working example:
> https://gist.github.com/5kg/5451894

Nice! I have done something similar here and I was able to build and insert code
snippets. But then I am more inclined towards analysing performance of dyninst.
You may also want to look at DynC API to build complex code snippets in a C
like syntax for dyninst.

> Dyninst is a really cool project (after struggling to get it work)...

Yeah it took sometime to understand their nomenclature and analysing the
assembly to see how it really mutates the binary. You might also be interested
in 'fast tracepoint' infrastructure and normal tracepoints provided by gdb. I
ran some tests with fast tracepoints using gdb on a same 'mutatee' code (as
dyninst) and it performed quite better than just dyninst. (a million runs of
traced function(with no 'action' performed by gdb on tracepoint hit) showed a
1.46% overhead - better tests are under way) But getting gdb's infra for
dynamic tracing with UST may be somewhat a serious hack.

Also, as you suggest stapdyn is also a good start to explore. I have not done
that yet.

I am going to start with getting elementary Dyninst+UST hack working from next
week for continuing my tests/analysis and its gonna be good to hear from you
about trials at your end.

--
Suchakra
