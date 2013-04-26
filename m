From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: GSoC 2013, "C++ probe support" project and more
Date: Fri, 26 Apr 2013 19:16:24 -0400
Message-ID: <1367018184.517b0ac898ae3__5712.83641406826$1367018210$gmane$org@www.imp.polymtl.ca>
References: <CAJ7wx-Epdf=DV+acPKkXjbXbgPGXHOUnnfOEH_hbpnreL2z4dA@mail.gmail.com>
	<CAJ7wx-Eq4eZ7g52W6c4ETLVHm88xrhOg2u1BjYwhDJ87vT+Kaw@mail.gmail.com>
	<CAGDH53k0DuDWg2sQa2fRfXPMDHLYeyGJr0MXsth0PcxiY6bXUQ@mail.gmail.com>
	<CAJ7wx-EyT-8TzBELBrFUgbhCwwDVorjDRpTaAhf0iTkXnH43cQ@mail.gmail.com>
	<1366860094.5178a13e78f12@www.imp.polymtl.ca>
	<CAJ7wx-E3osJ9-JNh2agDRJTNtUu=TFYruSw-wcHa=9pJr2hMsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1UVrsQ-0007iW-Ov
	for lttng-dev@lists.lttng.org; Fri, 26 Apr 2013 19:16:26 -0400
In-Reply-To: <CAJ7wx-E3osJ9-JNh2agDRJTNtUu=TFYruSw-wcHa=9pJr2hMsA@mail.gmail.com>
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

Hi,

Quoting Zifei Tong <soariez@gmail.com>:

> 'BPatch::setTrampRecursive(true)' on will reduce the 'mutatee'
> instrumentation overhead a lot.

Hmm..interesting. I should look into it too. I think I missed it.

> > Quote form gdb document [1]: "At present, the UST (LTTng Userspace Tracer,
> http://lttng.org/ust) tracing engine is supported."
>
> So does it mean the dynamic instrumentation project is already done by
> the gdb guys?

This is for static tracepoint support with IPA and not dynamic one. Support for
dynamic tracing in GDB is independent of UST still.

--
Suchakra
