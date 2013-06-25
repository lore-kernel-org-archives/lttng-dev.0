From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RELEASE] LTTng-UST 2.2.0 - Cuda (STABLE)
Date: Tue, 25 Jun 2013 19:01:17 -0400
Message-ID: <20130625230117.GA18136__14329.7814102427$1372201311$gmane$org@Krystal>
References: <20130625220111.GA16785@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UrcEg-0005jp-JX
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 19:01:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 5A5691418CE
	for <lttng-dev@lists.lttng.org>; Tue, 25 Jun 2013 19:01:18 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id KwcrxkIsBFPf for <lttng-dev@lists.lttng.org>;
	Tue, 25 Jun 2013 19:01:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130625220111.GA16785@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
> port of the low-overhead tracing capabilities of the LTTng kernel tracer
> to user-space. The library "liblttng-ust" enables tracing of
> applications and libraries.
> 
> Noteworthy new feature in LTTng-UST 2.2.0:
> 
> - per UID buffers for UST,
> - periodical flush for metadata,
> - trace file rotation.

Just for completeness, I'm pasting the "Major new features" description
found in the 2.2.0-rc3 release announcement:

Major new features:
- Per context filtering (vtid, vpid, procname) with e.g.
  --filter 'procname=="apache2"'
- Buffers shared across applications with same user id e.g.
  lttng enable-channel -u mychan --buffers-uid
- Implement --switch-timer and --read-timer options (periodical flush
  and RT-awareness).
- Function entry/exit tracing (see lttng-ust-cyg-profile(3) manpage).

Thanks,

Mathieu

> 
> See the lttng-tools announcement for details.
> 
> Changelog since 2.2.0-rc3:
> 2013-06-25 lttng-ust 2.2.0
>         * Disable doc/examples build
>         * Fix: lttng-events VPATH build
>         * doc/examples: build gen-tp example by default
>         * doc/examples: support BSD make
> 
> Project website: http://lttng.org
> Download link: http://lttng.org/download
> (please refer to the README file for installation instructions)
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
