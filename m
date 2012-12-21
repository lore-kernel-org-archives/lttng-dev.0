From: Hui Zhu <teawater@gmail.com>
Subject: Re: [lttng-dev] Request change name of function lookup_enum in libbabeltrace to make GDB use this lib
Date: Fri, 21 Dec 2012 10:57:29 +0800
Message-ID: <CANFwon2wq4ynMEh_L+TuN9ZiTfQ_i+QksdK4y3=KLFaYB_fjBQ@mail.gmail.com>
References: <CANFwon2s-eJoCrhzJmxhoGx9G2NeOAFf-FDFk1SoxD1OhPxWsg@mail.gmail.com> <20121205120845.GA31696@Krystal> <50C0C06A.40207@redhat.com> <CANFwon2U61xKrSFVq0wJ0axVKqjz7RzWcOn5vJ3MUEL4JC+VOA@mail.gmail.com> <20121210140524.GA31945@Krystal> <CANFwon2T5CYcjssSyTh_yjV2fgw0N3SZXqytNJQOCR1h2vM8MQ@mail.gmail.com> <CANFwon18bwvqnXe6xVoWS0C3Ls2LQmxy7BDjWf8wj=-iEzd3Qg@mail.gmail.com> <20121220141643.GA22763@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <gdb-return-41663-gdb-gdb=m.gmane.org@sourceware.org>
In-Reply-To: <20121220141643.GA22763@Krystal>
List-Unsubscribe: <mailto:gdb-unsubscribe-gdb-gdb=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:gdb-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb/>
List-Post: <mailto:gdb@sourceware.org>
List-Help: <mailto:gdb-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-owner@sourceware.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Pedro Alves <palves@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, Tom Tromey <tromey@redhat.com>, gdb@sourceware.org
List-Id: lttng-dev@lists.lttng.org

On Thu, Dec 20, 2012 at 10:16 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Hui Zhu (teawater@gmail.com) wrote:
>> On Tue, Dec 11, 2012 at 11:18 PM, Hui Zhu <teawater@gmail.com> wrote:
>> > On Mon, Dec 10, 2012 at 10:05 PM, Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> >> * Hui Zhu (teawater@gmail.com) wrote:
>> >>> On Thu, Dec 6, 2012 at 11:57 PM, Pedro Alves <palves@redhat.com> wrote:
>> >>> > On 12/05/2012 12:08 PM, Mathieu Desnoyers wrote:
>> >>> >> * Hui Zhu (teawater@gmail.com) wrote:
>> >>> >>> Hi,
>> >>> >>>
>> >>> >>> I am working on add CTF support to GDB.  You can see my patch review threads in:
>> >>> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00552.html
>> >>> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00554.html
>> >>> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00553.html
>> >>> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html
>> >>> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00556.html
>> >>> >>>
>> >>> >>> To make GDB support CTF read, I use libbabeltrace with GDB.  You can
>> >>> >>> see the patch in
>> >>> >>> http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html.
>> >>> >>> I have a issue is  libbabeltrace have a function called lookup_enum
>> >>> >>> that is same with a GDB function.
>> >>> >>> I change the function name of GDB to handle this issue in my patch.
>> >>> >>>
>> >>> >>> But Tom said let libbabeltrace to change function name is better.
>> >>> >>> So I send this mail to ask do you mind change the function name of
>> >>> >>> lookup_enum?   If you can change the function name that will be really
>> >>> >>> helpful for us.  Thanks a lot.
>> >>> >>> And I post a patch about change the function name in libbabeltrace.
>> >>> >>
>> >>> >> I'm CCing Julien Desfossez on this one. From what I see,
>> >>> >> include/babeltrace/types.h is not included into the system, so it should
>> >>> >> not be considered to be a public header of libbabeltrace.
>> >>> >
>> >>> > I've just built and installed babeltrace 1.0.0 (where's the mainline repository,
>> >>> > BTW?), and indeed, I'm not seeing the types.h file anywhere in the
>> >>> > installed tree:
>> >>> >
>> >>> > $ ~/src/babeltrace/install/include> find
>> >>> > .
>> >>> > ./babeltrace
>> >>> > ./babeltrace/trace-handle.h
>> >>> > ./babeltrace/list.h
>> >>> > ./babeltrace/babeltrace.h
>> >>> > ./babeltrace/context.h
>> >>> > ./babeltrace/iterator.h
>> >>> > ./babeltrace/ctf
>> >>> > ./babeltrace/ctf/callbacks.h
>> >>> > ./babeltrace/ctf/events.h
>> >>> > ./babeltrace/ctf/iterator.h
>> >>> > ./babeltrace/format.h
>> >>> > ./babeltrace/clock-types.h
>> >>> >
>> >>> > The GDB patch is including types.h explicitly:
>> >>> >
>> >>> > +#ifdef HAVE_LIBBABELTRACE
>> >>> > +#include <babeltrace/babeltrace.h>
>> >>> > +#include <babeltrace/types.h>
>> >>> > +#include <babeltrace/ctf/events.h>
>> >>> > +#include <babeltrace/ctf/iterator.h>
>> >>> >
>> >>> > So indeed, Hui, you'll need to make sure your patch works against an
>> >>> > installed babeltrace, making sure it does not pick up headers
>> >>> > from babeltrace's source directory.  If there's really no reason to
>> >>> > include that types.h header (since it seems you don't really need any
>> >>> > function declared in that file), maybe there's actually nothing for
>> >>> > babeltrace to do.
>> >>>
>> >>> Oops, sorry for I miss something.
>> >>> I use include babeltrace/types.h because I use function
>> >>> get_int_signedness that defined inside it.
>> >>
>> >> Can you use:
>> >>
>> >> include/babeltrace/ctf/events.h: bt_ctf_get_int_signedness() instead ?
>> >>
>> >> This one is within an exported header,
>> >>
>> >> Thanks,
>> >>
>> >> Mathieu
>> >
>> > Great! My part is OK now.  Thanks for your help.
>> >
>> > Best,
>> > Hui
>> >
>>
>> Hi Mathieu.,
>>
>> I am so sorry that I still have issue with the function name of lookup_enum.
>> What I met is a crash when try to use libbabeltrace in GDB:
>> #0  0x00000000005d0cfc in block_static_block (block=0x7ffff6e5ee3e) at
>> ../../gdb/gdb/block.c:343
>> #1  0x00000000005d42ae in lookup_symbol_aux_local (name=0xf70c70
>> "\240!\224\001", block=0x7ffff6e5ee3e,
>>     domain=STRUCT_DOMAIN, language=language_c) at ../../gdb/gdb/symtab.c:1429
>> #2  0x00000000005d40b5 in lookup_symbol_aux (name=0xf70c70
>> "\240!\224\001", block=0x7ffff6e5ee3e, domain=STRUCT_DOMAIN,
>>     language=language_c, is_a_field_of_this=0x0) at ../../gdb/gdb/symtab.c:1345
>> #3  0x00000000005d3cae in lookup_symbol_in_language (name=0xf70c70
>> "\240!\224\001", block=0x7ffff6e5ee3e,
>>     domain=STRUCT_DOMAIN, lang=language_c, is_a_field_of_this=0x0) at
>> ../../gdb/gdb/symtab.c:1231
>> #4  0x00000000005d3cff in lookup_symbol (name=0xf70c70
>> "\240!\224\001", block=0x7ffff6e5ee3e, domain=STRUCT_DOMAIN,
>>     is_a_field_of_this=0x0) at ../../gdb/gdb/symtab.c:1246
>> #5  0x000000000062f372 in lookup_enum (name=0xf70c70 "\240!\224\001",
>> block=0x7ffff6e5ee3e)
>>     at ../../gdb/gdb/gdbtypes.c:1287
>> #6  0x00007ffff6e479b5 in ctf_read_event (ppos=0xf6cca8,
>> stream=0xf6cc10) at ../../../babeltrace/formats/ctf/ctf.c:434
>> #7  0x00007ffff7071204 in stream_read_event (sin=<optimized out>) at
>> ../../babeltrace/lib/iterator.c:65
>> #8  0x00007ffff7071eb3 in bt_iter_init (iter=0x13ec820, ctx=0xf4b8b0,
>> begin_pos=0x7fffffffdad0, end_pos=<optimized out>)
>>     at ../../babeltrace/lib/iterator.c:703
>> #9  0x00007ffff6e4a6ac in bt_ctf_iter_create (ctx=0xf4b8b0,
>> begin_pos=0x7fffffffdad0, end_pos=0x0)
>>     at ../../../babeltrace/formats/ctf/iterator.c:53
>> #10 0x000000000050d4b1 in bt_ctf_open (dirname=0xd98c1b
>> "/home/teawater/gdb/ctf/kernel/") at ../../gdb/gdb/ctf.c:1289
>>
>> You can see that when function ctf_read_event of libbabeltrace try to
>> call function lookup_enum.  It call the function of GDB.  Then it got
>> crash.
>>
>> So could you help me with it?
>
> Hrm, since lookup_enum() and other similar functions are internal to
> babeltrace, we should probably define them as:
>
> __attribute__((visibility("hidden")))
>
> so they don't override other libraries' symbols.
>
> Can you try doing this modification to babeltrace and see if it helps ?
> If it does, then we'll consider doing that across our code-base.
>
> Thanks,
>
> Mathieu
>
>

This is what I got when I add it to lookup_enum:
make[2]: Entering directory `/home/teawater/gdb/ctf/bb/converter'
  CCLD   babeltrace
../formats/ctf/.libs/libbabeltrace-ctf.so: undefined reference to `lookup_enum'
collect2: ld returned 1 exit status
make[2]: *** [babeltrace] Error 1
make[2]: Leaving directory `/home/teawater/gdb/ctf/bb/converter'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/teawater/gdb/ctf/bb'
make: *** [all] Error 2

Thanks,
Hui

>>
>> Thanks,
>> Hui
>>
>> >>
>> >>>
>> >>> Thanks,
>> >>> Hui
>> >>>
>> >>>
>> >>> >
>> >>> >> Julien, is there an publically exposed babeltrace API that performs
>> >>> >> something similar to the internal lookup_enum() ?
>> >>> >>
>> >>> >> Hui, are you using other functions from include/babeltrace/types.h ?
>> >>> >
>> >>> > --
>> >>> > Pedro Alves
>> >>> >
>> >>
>> >> --
>> >> Mathieu Desnoyers
>> >> Operating System Efficiency R&D Consultant
>> >> EfficiOS Inc.
>> >> http://www.efficios.com
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
