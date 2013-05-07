From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 3/5] Read CTF by the ctf target
Date: Tue, 7 May 2013 09:07:41 -0400
Message-ID: <20130507130741.GE4186@Krystal>
References: <1361931459-3953-1-git-send-email-yao@codesourcery.com> <1361931459-3953-4-git-send-email-yao@codesourcery.com> <512F9182.3080104@redhat.com> <CANFwon2TPo1X2cUXXdzDEnX3UPvG2w0ZNMpNGN=KoDdBvyXLFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gdb-patches-return-101205-gdb-gdb-patches=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:gdb-patches-unsubscribe-##L=##H@sourceware.org>
List-Subscribe: <mailto:gdb-patches-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb-patches/>
List-Post: <mailto:gdb-patches@sourceware.org>
List-Help: <mailto:gdb-patches-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-patches-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <CANFwon2TPo1X2cUXXdzDEnX3UPvG2w0ZNMpNGN=KoDdBvyXLFQ@mail.gmail.com>
To: Hui Zhu <teawater@gmail.com>
Cc: Yao Qi <yao@codesourcery.com>, gdb-patches@sourceware.org, Pedro Alves <palves@redhat.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Hui Zhu (teawater@gmail.com) wrote:
> On Fri, Mar 1, 2013 at 1:18 AM, Pedro Alves <palves@redhat.com> wrote:
> > (not a complete review)
> >
> > On 02/27/2013 02:17 AM, Yao Qi wrote:
> >
> >> +if test "x$with_babeltrace" != "xno"; then
> >> +  saved_CFLAGS="$CFLAGS"
> >> +  CFLAGS="$CFLAGS $btinc"
> >> +  AC_MSG_CHECKING([for babeltrace])
> >> +  AC_TRY_COMPILE([
> >> +#include <babeltrace/babeltrace.h>
> >> +#include <babeltrace/ctf/events.h>
> >> +#include <babeltrace/ctf/iterator.h>
> >
> > We know from previous patches that the latest released
> > babeltrace breaks gdb, due to the lookup_enum function.  Does
> > this catch that?  I see namespacing fixes going into
> > babeltrace as recently as last 15th.  Do we know if
> > babeltrace's API is more or less done and close to a release?
> 
> Hi Mathieu,
> 
> Could you help us with this question?

We did the 1.1.0 release specifically for namespace fixes on March 23rd.

commit c99b1910bea848e8f0ae5641bb63b8f4f84f3ec0
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sat Mar 23 13:34:22 2013 -0400

    Version 1.1.0
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu


> 
> Thanks,
> Hui
> 
> >
> >> +  ],[],
> >> +  [AC_MSG_RESULT([yes]); AC_DEFINE(HAVE_LIBBABELTRACE, 1, [Define if libbabeltrace is available])],
> >> +  [AC_MSG_RESULT([no]); btlibs= ; btinc= ])
> >> +  CFLAGS="$saved_CFLAGS"
> >> +fi
> >> +
> >> +# Flags needed for UST
> >
> > babeltrace
> >
> >> +AC_SUBST(btlibs)
> >> +AC_SUBST(btinc)
> >> +
> >
> > --
> > Pedro Alves
> >

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
