From: Jon Bernard <jbernard@debian.org>
Subject: Re: Debian specific userspace RCU configure override
Date: Thu, 5 Jun 2014 14:29:33 -0400
Message-ID: <20140605182933.GA6748__39578.351219143$1401993076$gmane$org@helmut>
References: <48CF5AC71E61DB46B70D0F388054EFFD359B89C8@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1WscQ0-0003BR-8K
 for lttng-dev@lists.lttng.org; Thu, 05 Jun 2014 14:29:49 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E51CC2198C
 for <lttng-dev@lists.lttng.org>; Thu,  5 Jun 2014 14:29:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359B89C8@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel <Daniel.Thibault@drdc-rddc.gc.ca> wrote:
> ----------------------------------------------------------------------
> Date: Wed, 28 May 2014 14:10:50 -0400
> 
> > As I currently understand, the debian build problem is that although the
> > package is compiled on armv7 hardware, it is expected to target armv4t.
> > And this is not correctly detected at configure-time.  The folks on
> > #debian-arm suggested that this could be solved in configure.ac.  I can
> > explicitly pass '--build <target>' to ./configure to get around this,
> > but arm users that build from source will need to remember this.
> >
> > Jon
> ----------------------------------------------------------------------
>    I need to revive this thread.  Although the original build failure
>    may have been on ARMv7 wanting ARMv4, I've run into the same
>    failure with a pure ARMv7 architecture.  Specifically, Beagle Bone
>    Black.
> 
>    I built userspace-rcu without trouble (except for that clock
>    business reported earlier), but when I then tried to build
>    lttng-ust, I ran into the same 'Error: selected processor does not
>    support ARM mode `dmb'.  Taking a look at the userspace-rcu and
>    lttng-ust config.logs, they *both* report 'uname -m = armv7l'.  The
>    core tests *both* report a build system type of
>    'armv7l-unknown-linux-gnueabi'.  However, userspace-rcu tests for
>    dmb and finds it, while lttng-ust omits this test.
> 
>    The make error occurs during the CCLD of libringbuffer.la.
> 
>    Besides the make, config and configure logs, what should I post
>    here?

It sounds like you might be hitting the same issue that I had.  When
building urcu on this particular host, ./configure will detect an armv7
target even though userland is armv4.  I was able to get around this by
explicitly passing '--build' and '--host' flags to configure.  There is
also a pre-built armel deb for the latest version of urcu at:

    https://packages.debian.org/sid/armel/liburcu2/download

In my particular case, the build machine is v7 hardware running a v7
kernel but with a v4 userland.  You can confirm this with

    gcc -dumpmachine

Maybe this will help, I'm curious to know how it goes.

Cheers,

-- 
Jon
