From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-dev] Request change name of function lookup_enum in	libbabeltrace to make GDB use this lib
Date: Mon, 10 Dec 2012 09:05:24 -0500
Message-ID: <20121210140524.GA31945@Krystal>
References: <CANFwon2s-eJoCrhzJmxhoGx9G2NeOAFf-FDFk1SoxD1OhPxWsg@mail.gmail.com> <20121205120845.GA31696@Krystal> <50C0C06A.40207@redhat.com> <CANFwon2U61xKrSFVq0wJ0axVKqjz7RzWcOn5vJ3MUEL4JC+VOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gdb-return-41639-gdb-gdb=m.gmane.org@sourceware.org>
Content-Disposition: inline
In-Reply-To: <CANFwon2U61xKrSFVq0wJ0axVKqjz7RzWcOn5vJ3MUEL4JC+VOA@mail.gmail.com>
List-Unsubscribe: <mailto:gdb-unsubscribe-gdb-gdb=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:gdb-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb/>
List-Post: <mailto:gdb@sourceware.org>
List-Help: <mailto:gdb-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-owner@sourceware.org
To: Hui Zhu <teawater@gmail.com>
Cc: Pedro Alves <palves@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, Tom Tromey <tromey@redhat.com>, gdb@sourceware.org
List-Id: lttng-dev@lists.lttng.org

* Hui Zhu (teawater@gmail.com) wrote:
> On Thu, Dec 6, 2012 at 11:57 PM, Pedro Alves <palves@redhat.com> wrote:
> > On 12/05/2012 12:08 PM, Mathieu Desnoyers wrote:
> >> * Hui Zhu (teawater@gmail.com) wrote:
> >>> Hi,
> >>>
> >>> I am working on add CTF support to GDB.  You can see my patch review threads in:
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00552.html
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00554.html
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00553.html
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00556.html
> >>>
> >>> To make GDB support CTF read, I use libbabeltrace with GDB.  You can
> >>> see the patch in
> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html.
> >>> I have a issue is  libbabeltrace have a function called lookup_enum
> >>> that is same with a GDB function.
> >>> I change the function name of GDB to handle this issue in my patch.
> >>>
> >>> But Tom said let libbabeltrace to change function name is better.
> >>> So I send this mail to ask do you mind change the function name of
> >>> lookup_enum?   If you can change the function name that will be really
> >>> helpful for us.  Thanks a lot.
> >>> And I post a patch about change the function name in libbabeltrace.
> >>
> >> I'm CCing Julien Desfossez on this one. From what I see,
> >> include/babeltrace/types.h is not included into the system, so it should
> >> not be considered to be a public header of libbabeltrace.
> >
> > I've just built and installed babeltrace 1.0.0 (where's the mainline repository,
> > BTW?), and indeed, I'm not seeing the types.h file anywhere in the
> > installed tree:
> >
> > $ ~/src/babeltrace/install/include> find
> > .
> > ./babeltrace
> > ./babeltrace/trace-handle.h
> > ./babeltrace/list.h
> > ./babeltrace/babeltrace.h
> > ./babeltrace/context.h
> > ./babeltrace/iterator.h
> > ./babeltrace/ctf
> > ./babeltrace/ctf/callbacks.h
> > ./babeltrace/ctf/events.h
> > ./babeltrace/ctf/iterator.h
> > ./babeltrace/format.h
> > ./babeltrace/clock-types.h
> >
> > The GDB patch is including types.h explicitly:
> >
> > +#ifdef HAVE_LIBBABELTRACE
> > +#include <babeltrace/babeltrace.h>
> > +#include <babeltrace/types.h>
> > +#include <babeltrace/ctf/events.h>
> > +#include <babeltrace/ctf/iterator.h>
> >
> > So indeed, Hui, you'll need to make sure your patch works against an
> > installed babeltrace, making sure it does not pick up headers
> > from babeltrace's source directory.  If there's really no reason to
> > include that types.h header (since it seems you don't really need any
> > function declared in that file), maybe there's actually nothing for
> > babeltrace to do.
> 
> Oops, sorry for I miss something.
> I use include babeltrace/types.h because I use function
> get_int_signedness that defined inside it.

Can you use:

include/babeltrace/ctf/events.h: bt_ctf_get_int_signedness() instead ?

This one is within an exported header,

Thanks,

Mathieu

> 
> Thanks,
> Hui
> 
> 
> >
> >> Julien, is there an publically exposed babeltrace API that performs
> >> something similar to the internal lookup_enum() ?
> >>
> >> Hui, are you using other functions from include/babeltrace/types.h ?
> >
> > --
> > Pedro Alves
> >

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
