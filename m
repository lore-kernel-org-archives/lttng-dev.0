From: Jon Bernard <jbernard@debian.org>
Subject: Re: [lttng-tools] build failure on armel (debian)
Date: Tue, 20 May 2014 15:15:57 -0400
Message-ID: <20140520191557.GA5951__33339.059414766$1400613448$gmane$org@helmut>
References: <20140506151403.GD11105@helmut>
 <1792077382.15631.1399988805202.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1WmpWA-0003M6-Q7
 for lttng-dev@lists.lttng.org; Tue, 20 May 2014 15:16:12 -0400
Content-Disposition: inline
In-Reply-To: <1792077382.15631.1399988805202.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- Original Message -----
> > From: "Jon Bernard" <jbernard@debian.org>
> > To: lttng-dev@lists.lttng.org
> > Sent: Tuesday, May 6, 2014 11:14:03 AM
> > Subject: [lttng-dev] [lttng-tools] build failure on armel (debian)
> > =

> > Hey guys,
> > =

> > This bug=B9 was filed recently:
> > =

> >     your package no longer builds on the armel buildds:
> >     https://buildd.debian.org/status/fetch.php?pkg=3Dltt-control&arch=
=3Darmel&ver=3D2.4.1-1&stamp=3D1397064419
> > =

> >     >   CC       rculfhash.lo
> >     > /tmp/ccBG89vh.s: Assembler messages:
> >     > /tmp/ccBG89vh.s:1105: Error: selected processor does not support =
ARM
> >     > mode `dmb'
> >     > /tmp/ccBG89vh.s:1286: Error: selected processor does not support =
ARM
> >     > mode `dmb'
> >     > /tmp/ccBG89vh.s:3175: Error: selected processor does not support =
ARM
> >     > mode `dmb'
> >     > /tmp/ccBG89vh.s:3725: Error: selected processor does not support =
ARM
> >     > mode `dmb'
> >     > /tmp/ccBG89vh.s:3833: Error: selected processor does not support =
ARM
> >     > mode `dmb'
> >     > /tmp/ccBG89vh.s:3994: Error: selected processor does not support =
ARM
> >     > mode `dmb'
> >     > /tmp/ccBG89vh.s:4331: Error: selected processor does not support =
ARM
> >     > mode `dmb'
> >     > /tmp/ccBG89vh.s:5292: Error: selected processor does not support =
ARM
> >     > mode `dmb'
> >     > make[4]: *** [rculfhash.lo] Error 1
> > =

> > The public buildd that I can use to test this is unreachable at the
> > moment, but maybe a solution can be reached without further debug info?
> > =

> > The build machine is ARMv7, which supports dmb IIUC, so I'm a bit
> > puzzled on this one.
> > =

> > Any thoughts?
> =

> Perhaps the build itself has been changed to target ARMv6 ?
> =

> Starting with ARMv7, dmb should be there.
> =

> For ARMv6 support (and less), the Linux kernel provides
> a vDSO page implementing __kuser_memory_barrier. If you
> really need to build for ARMv6, this might be something
> to look into.
> =

> I guess we'll need more information about your build
> target.

Here is a full build log: http://sprunge.us/FIJe

Build occurred on this machine:

    Linux abel 3.13-1-armmp-lpae #4 SMP Thu Mar 27 16:56:17 UTC 2014 armv7l=
 GNU/Linux

Is there anything else I should include?

-- =

Jon
