From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu commit a767fd requires autoconf >= 2.64.
Date: Thu, 14 Jun 2012 00:55:33 -0400
Message-ID: <20120614045533.GA26983__8483.73850244588$1339649763$gmane$org@Krystal>
References: <jr9e2h$phq$1@dough.gmane.org> <20120613081001.GA30123@Krystal>
	<4FD8919D.9060607@toojays.net> <20120613193142.GA20907@Krystal>
	<4FD91F91.6080204@toojays.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sf25m-0002MO-OH
	for lttng-dev@lists.lttng.org; Thu, 14 Jun 2012 00:55:34 -0400
Content-Disposition: inline
In-Reply-To: <4FD91F91.6080204@toojays.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: John Steele Scott <toojays@toojays.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* John Steele Scott (toojays@toojays.net) wrote:
> On 14/06/12 05:01, Mathieu Desnoyers wrote:
> > * John Steele Scott (toojays@toojays.net) wrote:
> >> On 13/06/12 17:40, Mathieu Desnoyers wrote:
> >>> * John Steele Scott (toojays@toojays.net) wrote:
> >>>> http://lists.lttng.org/pipermail/lttng-dev/2012-May/017927.html
> >>>>
> >>>> I tried to build the latest urcu (git master e51500) on a Centos 6.2 box, and got:
> >>>>
> >>>> jscott@dxi0-62:~/src/userspace-rcu$ make -j4
> >>>> CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run aclocal-1.11 -I config
> >>>> CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run autoconf
> >>>>  cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run automake-1.11 --foreign
> >>>> configure:4010: error: possibly undefined macro: m4_ifnblank
> >>>>       If this token and others are legitimate, please use m4_pattern_allow.
> >>>>       See the Autoconf documentation.
> >>>> make: *** [configure] Error 1
> >>>> make: *** Waiting for unfinished jobs....
> >>>>
> >>>> Some digging showed that the macro m4_ifnblank requires autoconf 2.64. Centos 6.2 has autoconf 2.63. :(
> >>>>
> >>>> I just worked around it by reverting commit a767fd locally, then I can build fine.
> >>> Thanks for pointing this out! Can you try the following patch and let me
> >>> know if it fixes your issue ?
> >>>
> >>>
> >> Mathieu,
> >>
> >> Thanks for your quick response. Unfortunately, with that patch, ./configure fails like:
> >>
> > [...]
> >> It seems it doesn't like the empty else..fi clause. If I put a command in there ("true", "echo", whatever), configure completes and I can build successfully.
> > Can you try with the following ? I just tested it with autoconf 2.63
> > here and it seems to work fine now.
> >
> >
> > diff --git a/config/ax_tls.m4 b/config/ax_tls.m4
> > index 033e3b1..5ab1a41 100644
> > --- a/config/ax_tls.m4
> > +++ b/config/ax_tls.m4
> > @@ -44,7 +44,23 @@
> >  #   modified version of the Autoconf Macro, you may extend this special
> >  #   exception to the GPL to apply to your modified version as well.
> >  
> > -#serial 10
> > +#serial 11
> > +
> > +#   Define m4_ifblank and m4_ifnblank macros from introduced in
> > +#   autotools 2.64 m4sugar.m4 if using an earlier autotools.
> > +
> > +ifdef([m4_ifblank], [], [
> > +m4_define([m4_ifblank],
> > +[m4_if(m4_translit([[$1]],  [ ][	][
> > +]), [], [$2], [$3])])
> > +])
> > +
> > +
> > +ifdef([m4_ifnblank], [], [
> > +m4_define([m4_ifnblank],
> > +[m4_if(m4_translit([[$1]],  [ ][	][
> > +]), [], [$3], [$2])])
> > +])
> >  
> >  AC_DEFUN([AX_TLS], [
> >    AC_MSG_CHECKING(for thread local storage (TLS) class)
> > diff --git a/configure.ac b/configure.ac
> > index db34935..5f6bc40 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -28,7 +28,7 @@ AH_TEMPLATE([CONFIG_RCU_COMPAT_ARCH], [Compatibility mode for i386 which lacks c
> >  AH_TEMPLATE([CONFIG_RCU_ARM_HAVE_DMB], [Use the dmb instruction if available for use on ARM.])
> >  AH_TEMPLATE([CONFIG_RCU_TLS], [TLS provided by the compiler.])
> >  
> > -AX_TLS([AC_DEFINE_UNQUOTED([CONFIG_RCU_TLS], $ac_cv_tls)], [])
> > +AX_TLS(AC_DEFINE_UNQUOTED([CONFIG_RCU_TLS], $ac_cv_tls), [:])
> >  
> >  # Checks for programs.
> >  AC_PROG_CC
> >
> 
> Mathieu,
> 
> This fixed it for me too.

Thanks for confirming. Pushed as commit:

commit 450b97095e27646fcd1e4b83c99477d7253b987b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Jun 14 00:56:40 2012 -0400

  Fix: re-enable compatibility with autoconf < 2.64

> 
> Thanks,
> 
> John
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
