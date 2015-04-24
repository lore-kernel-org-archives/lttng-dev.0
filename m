From: Jon Bernard <jbernard@debian.org>
Subject: Re: Debian 3.16.7-ckt9-2 issue with lttng-modules kmem
	probe
Date: Fri, 24 Apr 2015 15:40:45 -0400
Message-ID: <20150424194045.GA18076__13927.8605966412$1429904519$gmane$org@helmut>
References: <1082981755.35270.1429823095435.JavaMail.zimbra@efficios.com>
 <844104542.35292.1429823245769.JavaMail.zimbra@efficios.com>
 <20150424165935.GA5843@helmut>
 <1563471161.35791.1429897556370.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1YljSw-0008JE-O0
 for lttng-dev@lists.lttng.org; Fri, 24 Apr 2015 15:40:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 9844720B4D
 for <lttng-dev@lists.lttng.org>; Fri, 24 Apr 2015 15:40:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1563471161.35791.1429897556370.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Alexandre Montplaisir <alexmonthy@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- Original Message -----
> > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > Hi Jon,
> > > 
> > > It appears that lttng-modules cannot build on the
> > > Debian kernel 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt9-2 (2015-04-13)
> > > x86_64 GNU/Linux.
> > > 
> > > It appears that their exported kmem.h header differs from
> > > the upstream stable branch, but AFAIK there is no Debian-specific
> > > version number available to distinguish between upstream stable
> > > and the Debian kernel.
> > 
> > Indeed.  The only distinguishing characteristic I see is EXTRAVERSION
> > defined to '-ckt9'.  I haven't had a chance to try yet, but could that
> > be acceptable?
> 
> No, because we need to do conditionals comparing numeric values
> both in Makefiles and within C.
> 
> > 
> > > We have been hit by this in the past for Ubuntu kernels, and the
> > > solution has been to introduce a UTS_UBUNTU_RELEASE_ABI define
> > > into their kernels, which can be used to follow their own kernel
> > > versions.
> > > 
> > > Do you think we could ask Debian to do the same ?
> > 
> > I'm happy to ask, the argument is certainly sound.
> 
> Thanks!

No problem, bug filed: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=783259

There may be a workaround I can put into the debian package as
a short term fix, maybe a conditional patch depending on those differing
3.16 versions.  We'll see how the bug progresses and I'll keep you
posted.

-- 
Jon
