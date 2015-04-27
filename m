From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Debian 3.16.7-ckt9-2 issue with lttng-modules kmem
 probe
Date: Mon, 27 Apr 2015 15:06:57 +0000 (UTC)
Message-ID: <198139162.36696.1430147217813.JavaMail.zimbra__46293.925031978$1430147287$gmane$org@efficios.com>
References: <1082981755.35270.1429823095435.JavaMail.zimbra@efficios.com>
 <844104542.35292.1429823245769.JavaMail.zimbra@efficios.com>
 <20150424165935.GA5843@helmut>
 <1563471161.35791.1429897556370.JavaMail.zimbra@efficios.com>
 <20150424194045.GA18076@helmut> <20150427143532.GA21372@helmut>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ymkcd-0003Iu-RC
 for lttng-dev@lists.lttng.org; Mon, 27 Apr 2015 11:07:02 -0400
In-Reply-To: <20150427143532.GA21372@helmut>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Alexandre Montplaisir <alexmonthy@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> * Jon Bernard <jbernard@debian.org> wrote:
> > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > ----- Original Message -----
> > > > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > > > Hi Jon,
> > > > > 
> > > > > It appears that lttng-modules cannot build on the
> > > > > Debian kernel 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt9-2 (2015-04-13)
> > > > > x86_64 GNU/Linux.
> > > > > 
> > > > > It appears that their exported kmem.h header differs from
> > > > > the upstream stable branch, but AFAIK there is no Debian-specific
> > > > > version number available to distinguish between upstream stable
> > > > > and the Debian kernel.
> > > > 
> > > > Indeed.  The only distinguishing characteristic I see is EXTRAVERSION
> > > > defined to '-ckt9'.  I haven't had a chance to try yet, but could that
> > > > be acceptable?
> > > 
> > > No, because we need to do conditionals comparing numeric values
> > > both in Makefiles and within C.
> > > 
> > > > 
> > > > > We have been hit by this in the past for Ubuntu kernels, and the
> > > > > solution has been to introduce a UTS_UBUNTU_RELEASE_ABI define
> > > > > into their kernels, which can be used to follow their own kernel
> > > > > versions.
> > > > > 
> > > > > Do you think we could ask Debian to do the same ?
> > > > 
> > > > I'm happy to ask, the argument is certainly sound.
> > > 
> > > Thanks!
> > 
> > No problem, bug filed:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=783259
> > 
> > There may be a workaround I can put into the debian package as
> > a short term fix, maybe a conditional patch depending on those differing
> > 3.16 versions.  We'll see how the bug progresses and I'll keep you
> > posted.
> 
> Right, so I'll take a look at making a package update to resolve the
> issue and get that into the stable archive so that lttng is again
> working in the new release.
> 
> Sorry about this, it didn't occur to me that an API change would happen
> and so I didn't continue testing 3.16 updates.  I'll get this sorted.

Surprise surprise! The fixes are pushed upstream in master and stable-2.6.

commit ffc696db884c44a49780bcd9e3b0f97ef82d2382
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Apr 27 11:03:17 2015 -0400

    Fix: update get_pfnblock_flags_mask wrapper for debian kernels
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 72e6c528aad2cdd1152af21258a5f84870155b41
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Apr 27 10:57:34 2015 -0400

    Fix: discover Debian API
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Enjoy :)

Thanks,

Mathieu

> 
> --
> Jon
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
