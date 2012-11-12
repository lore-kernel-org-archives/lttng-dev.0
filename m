From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/3] Add default subbuf sizes
	getter	functions.
Date: Sun, 11 Nov 2012 23:54:32 -0500
Message-ID: <20121112045432.GA20210__11425.4568740309$1352696108$gmane$org@Krystal>
References: <1352443148-7135-1-git-send-email-simon.marchi@polymtl.ca>
	<509D26D3.4070609@efficios.com>
	<CAFXXi0n6BWh=RF+vY_GXK2+Y=s8ZmJyqEH=Y_3D9DdyQztAyUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TXm2d-0008GV-MM
	for lttng-dev@lists.lttng.org; Sun, 11 Nov 2012 23:54:35 -0500
Content-Disposition: inline
In-Reply-To: <CAFXXi0n6BWh=RF+vY_GXK2+Y=s8ZmJyqEH=Y_3D9DdyQztAyUQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Hi David,
> 
> I just sent my v2 for this patch. I changed the logic so that it still
> uses the DEFAULT_*_SUBBUF_SIZE defines, but check that it is >= page
> size. It should answer your first two comments/questions.
> 
> I don't think it would help to put these inline, since they are only
> called in slow paths.

Even though those are slow paths, adding a symbol and function call just
to fetch a variable seems overkill. I agree with David: those should be
made static inline.

Thanks,

Mathieu

> 
> Simon
> 
> > Hi Simon,
> >
> > Can you please rename the get_default_* function family to default_get_*
> > in order to respect the name spacing of files.
> >
> > Comment below:
> >
> > Simon Marchi:
> >> This patch adds src/common/defaults.c file. It contains functions to
> >> retrieve defaults subbuf sizes based on the architecture page size.
> >>
> >> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> >> ---
> >>  src/common/Makefile.am |    2 +-
> >>  src/common/defaults.c  |   86 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  src/common/defaults.h  |    7 ++++
> >>  3 files changed, 94 insertions(+), 1 deletions(-)
> >>  create mode 100644 src/common/defaults.c
> >>
> >> diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> >> index b43b376..f91259c 100644
> >> --- a/src/common/Makefile.am
> >> +++ b/src/common/Makefile.am
> >> @@ -12,7 +12,7 @@ noinst_HEADERS = lttng-kernel.h defaults.h macros.h error.h futex.h \
> >>  noinst_LTLIBRARIES = libcommon.la
> >>
> >>  libcommon_la_SOURCES = error.h error.c utils.c utils.h runas.c runas.h \
> >> -                       common.h futex.c futex.h uri.c uri.h
> >> +                       common.h futex.c futex.h uri.c uri.h defaults.c
> >>
> >>  # Consumer library
> >>  noinst_LTLIBRARIES += libconsumer.la
> >> diff --git a/src/common/defaults.c b/src/common/defaults.c
> >> new file mode 100644
> >> index 0000000..48d6605
> >> --- /dev/null
> >> +++ b/src/common/defaults.c
> >> @@ -0,0 +1,86 @@
> >> +/*
> >> + * Copyright (C) 2012 - Simon Marchi <simon.marchi@polymtl.ca>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License, version 2 only,
> >> + * as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful, but WITHOUT
> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> >> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> >> + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License along
> >> + * with this program; if not, write to the Free Software Foundation, Inc.,
> >> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >> + */
> >> +
> >> +#include <stddef.h>
> >> +#include <unistd.h>
> >> +
> >> +#include "defaults.h"
> >> +
> >> +static size_t default_channel_subbuf_size;
> >> +static size_t default_metadata_subbuf_size;
> >> +static size_t default_kernel_channel_subbuf_size;
> >> +static size_t default_ust_channel_subbuf_size;
> >> +
> >> +static void __attribute__((constructor)) init_defaults(void)
> >> +{
> >> +     default_kernel_channel_subbuf_size = DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE;
> >
> > Why is the kernel getting a default value and not a page size ?
> >
> >> +
> >> +     long page_size = sysconf(_SC_PAGESIZE);
> >> +     if (page_size > 0) {
> >> +             default_channel_subbuf_size = page_size;
> >> +             default_metadata_subbuf_size = page_size;
> >> +             default_ust_channel_subbuf_size = page_size;
> >> +     } else {
> >> +             default_channel_subbuf_size = 4096;
> >> +             default_metadata_subbuf_size = 4096;
> >> +             default_ust_channel_subbuf_size = 4096;
> >
> > Should we use a default value for this 4096 size here with a
> > DEFINE_*_SUBBUF_SIZE or... ?
> >
> > Seems a bit odd that the kernel got a default define value but not UST
> > and metadata.
> >
> >> +     }
> >> +}
> >> +
> >> +/*
> >> + * Returns the default subbuf size.
> >> + *
> >> + * This function depends on a value that is set at constructor time, so it is
> >> + * unsafe to call it from another constructor.
> >> + */
> >> +size_t get_default_channel_subbuf_size(void)
> >> +{
> >> +     return default_channel_subbuf_size;
> >> +}
> >> +
> >> +/*
> >> + * Returns the default metadata subbuf size.
> >> + *
> >> + * This function depends on a value that is set at constructor time, so it is
> >> + * unsafe to call it from another constructor.
> >> + */
> >> +size_t get_default_metadata_subbuf_size(void)
> >> +{
> >> +     return default_metadata_subbuf_size;
> >> +}
> >> +
> >> +/*
> >> + * Returns the default subbuf size for the kernel domain.
> >> + *
> >> + * This function depends on a value that is set at constructor time, so it is
> >> + * unsafe to call it from another constructor.
> >> + */
> >> +size_t get_default_kernel_channel_subbuf_size(void)
> >> +{
> >> +     return default_kernel_channel_subbuf_size;
> >> +}
> >> +
> >> +/*
> >> + * Returns the default subbuf size for the UST domain.
> >> + *
> >> + * This function depends on a value that is set at constructor time, so it is
> >> + * unsafe to call it from another constructor.
> >> + */
> >> +size_t get_default_ust_channel_subbuf_size(void)
> >> +{
> >> +     return default_ust_channel_subbuf_size;
> >> +}
> >
> > I'm wondering if all these functions should be static inline in the
> > default.h...
> >
> > Thoughts?
> >
> > Otherwise, the patch looks good!
> >
> > Thanks
> > David
> >
> >> diff --git a/src/common/defaults.h b/src/common/defaults.h
> >> index 0c0b6ac..efff43e 100644
> >> --- a/src/common/defaults.h
> >> +++ b/src/common/defaults.h
> >> @@ -109,6 +109,9 @@
> >>  #define DEFAULT_METADATA_SUBBUF_SIZE    4096
> >>  #define DEFAULT_METADATA_SUBBUF_NUM     2
> >>
> >> +size_t get_default_channel_subbuf_size(void);
> >> +size_t get_default_metadata_subbuf_size(void);
> >> +
> >>  /* Kernel has different defaults */
> >>
> >>  /* DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE must always be a power of 2 */
> >> @@ -121,6 +124,8 @@
> >>  /* See lttng-kernel.h enum lttng_kernel_output for channel output */
> >>  #define DEFAULT_KERNEL_CHANNEL_OUTPUT       LTTNG_EVENT_SPLICE
> >>
> >> +size_t get_default_kernel_channel_subbuf_size(void);
> >> +
> >>  /* User space defaults */
> >>
> >>  /* Must be a power of 2 */
> >> @@ -130,6 +135,8 @@
> >>  /* See lttng-ust.h enum lttng_ust_output */
> >>  #define DEFAULT_UST_CHANNEL_OUTPUT          LTTNG_EVENT_MMAP
> >>
> >> +size_t get_default_ust_channel_subbuf_size(void);
> >> +
> >>  /*
> >>   * Default timeout value for the sem_timedwait() call. Blocking forever is not
> >>   * wanted so a timeout is used to control the data flow and not freeze the
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
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
