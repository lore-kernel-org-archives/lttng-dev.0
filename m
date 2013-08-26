From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building	patches.
Date: Mon, 26 Aug 2013 11:27:59 -0400
Message-ID: <20130826152759.GA17057__41210.1154136055$1377530934$gmane$org@Krystal>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
	<CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
	<CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ@mail.gmail.com>
	<20130826162407.1996f085@skate> <20130826151147.GA16659@Krystal>
	<CAD7SSK6FBSEyAzdAmq0Wfr8xyDt6vF9Na6TVdQh_GEUtqqPa6A@mail.gmail.com>
	<20130826151917.GA16924@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VDyi0-0007Hj-OS
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 11:28:06 -0400
Content-Disposition: inline
In-Reply-To: <20130826151917.GA16924@Krystal>
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

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > 2013/8/26 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > > Now I just have to figure out how to teach lttng-gen-tp about CPPFLAGS
> > > :-/
> > >
> > 
> > My patch is correcting this, and the new version does take your
> > comment into account.
> 
> Actually, I just pushed a fix for this into master (I had to test all
> this myself to understand what happens):
> 
> commit 9ec23f2e52b3b0bd8b80afbe2e8e8ae1ab222c6b
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Mon Aug 26 11:14:56 2013 -0400
> 
>     Fix: doc/examples cross-build
>     
>     We need to pass automake's CPPFLAGS and LDFLAGS to examples. Add CFLAGS
>     too for completeness.
>     
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> We still have issues with lttng-gen-tp though: I'm looking for a way to
> change its Makefile so it adds "AM_CPPFLAGS" to the CFLAGS passed to the
> compiler. Ideas ?

I got it to work. See those commits in master:

commit 256175cffb00b15543bd49a4268e6c528bd51fce
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Aug 26 11:26:09 2013 -0400

    doc/examples/gen-tp: pass automake CPPFLAGS/CFLAGS/LDFLAGS
    
    Fix cross-build.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 170423b056ecdef441820a54be350605e4dc8951
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Aug 26 11:24:26 2013 -0400

    tools/lttng-gen-tp: honor CPPFLAGS and LDFLAGS
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
