From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: The disable-libtool-linkdep-fixup configure option
Date: Tue, 29 Jan 2013 12:32:40 -0500
Message-ID: <20130129173240.GA9703__47411.3761600622$1359480814$gmane$org@Krystal>
References: <3CA1A65C03C1A34C81BBC6272782E6969BDD0C@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U0F36-0004UR-0c
	for lttng-dev@lists.lttng.org; Tue, 29 Jan 2013 12:32:44 -0500
Content-Disposition: inline
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E6969BDD0C@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, =?iso-8859-1?Q?Painchaud=2C_Fr=E9d=E9ric?= <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
> > > The default value of the option is 'yes' (re: configure.ac), which means the fixup is applied.  Setting the option to another value, such as 'no', means the fixup is not applied.
> > > Why then is the option named *disable*-libtool-linkdep-fixup?  Shouldn't it be named *enable*-libtool-linkdep-fixup instead?
> >
> >Because the option is enabled by default on all systems. This is to facilitate cross-compilation on Debian/Ubuntu systems.
> >
> > Christian
> 
> If you had to compare the following two command lines, which one would you say disabled the fixup?
> 
> ./configure --disable-libtool-linkdep-fixup=yes
> ./configure --disable-libtool-linkdep-fixup=no
> 
> The first line is the current default, and it leaves the fixup enabled
> (right?).  That's why I suspect enable-libtool-linkdep-fixup would be
> a more meaningful name.

Please read the autoconf documentation, and become familiar with the
usual practices of other open source projects on this matter.

The autoconf documentation would, amongst other things, tell you about
"./configure --help". Its output lists:

  --disable-libtool-linkdep-fixup
                          disable the libtool fixup for linking all dependent
                          libraries (link_all_deplibs)

as a matter of fact, this option does not take "=yes/=no" parameters as
you suggest, nor does any of the --enable/disable-* configure options in
general. This option is enabled by default, unless you specify
--disable-libtool-linkdep-fixup. As a general guide-line, you should
never need to use this override, except in very exceptional situations
(e.g. in the event of future distribution changes).

Thank you,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
