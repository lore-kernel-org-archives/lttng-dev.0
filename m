From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: instrumenting shared library
Date: Fri, 4 Apr 2014 10:46:09 -0400
Message-ID: <CA+jJMxvgLzb6NDvD0ZtSHxLLxN8SdK3OPefmcAdReASCa+mMcg__35884.8547483378$1396622872$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WW5Nn-0001Q9-8p
 for lttng-dev@lists.lttng.org; Fri, 04 Apr 2014 10:46:21 -0400
Received: by mail-qa0-f44.google.com with SMTP id hw13so899108qab.31
 for <lttng-dev@lists.lttng.org>; Fri, 04 Apr 2014 07:46:09 -0700 (PDT)
In-Reply-To: <CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault,
 Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

On Fri, Apr 4, 2014 at 1:44 AM, Anand Neeli <anand.neeli@gmail.com> wrote:
> Hi Daniel,
> Thanks for your reply.
> sorry for my ignorance but how are you generating libtp.so in your exampl=
e?
>
> 1) Also will this solution scale if my binary depends on lots of libraries
> which are instrumented?
>

It should have no impact on scalability.

> 2) i'm fine with linking statically, can we avoid LD_PRELOAD?
>

Absolutely, you can link the providers in your application directly.
The advantage of using LD_PRELOAD is to make sure your application has
no dependency on lttng-ust.so.

Please refer to the "BUILDING/LINKING THE TRACEPOINT PROVIDER" section
in the LTTNG-UST(3) man page.

The lttng-ust/doc/examples/ folder also contains Makefiles to show you
how to link tracepoints providers to your application either
statically or dynamically.

> 3) Is there any page which explains on why and how to use
> TRACEPOINT_PROVIDER, TRACEPOINT_CREATE_PROBES, TRACEPOINT_INCLUDE,
> TRACEPOINT_DEFINE, TRACEPOINT_PROBE_DYNAMIC_LINKAGE
>

Not really. Hopefully I'll make this clear without delving in
implementation details...

TRACEPOINT_PROVIDER must be defined to the name of your tracepoint provider.

TRACEPOINT_INCLUDE must provide a path to the current include file.

TRACEPOINT_PROBE_DYNAMIC_LINKAGE is pretty self explanatory. It will
make sure that no unresolved symbols are emited by lttng/tracepoint.h.
This way the tracee can be built without having to resolve a symbol
defined in the provider.

TRACEPOINT_DEFINE, as noted in the lttng-ust manpage, should be
defined before you include the tracepoint headers in the .c file where
they'll be used.

TRACEPOINT_CREATE_PROBES will be expanded to everything that is needed
in your provider object.

Again, taking a look at the examples should help you make sense of how
to instrument an application.

Regards,
J=E9r=E9mie

>
> my tp.h is, are there any errors in this?
> #############
> #define TRACEPOINT_PROVIDER sample_component
>
> #undef TRACEPOINT_INCLUDE
> #define TRACEPOINT_INCLUDE "./tp.h"
>
> #if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
> #define _TP_H
>
> #include <lttng/tracepoint.h>
>
> TRACEPOINT_EVENT(
>         sample_component,
>         event,
>         TP_ARGS(char *, text),
>         TP_FIELDS(
>                 ctf_string(message, text)
>         )
> )
> TRACEPOINT_LOGLEVEL(
>         sample_component,
>         event,
>         TRACE_WARNING)
>
> #endif /* _TP_H */
> #include <lttng/tracepoint-event.h>
> #############
>
>
>
> Thanks,
> Anand Neeli
>
>
> On Thu, Apr 3, 2014 at 9:35 PM, Thibault, Daniel
> <Daniel.Thibault@drdc-rddc.gc.ca> wrote:
>>
>> ----------------------------------------------------------------------
>> Date: Thu, 3 Apr 2014 16:55:38 +0530
>> From: Anand Neeli <anand.neeli@gmail.com>
>> To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
>>
>> > I have a library which is instrumented and tracepoints are added. And I
>> > have 2 binary's (or daemons) which try to include this library. (one
>> > binary
>> > has instrumented code with tracepoints and other binary doesn't use
>> > tracing)
>> >
>> > I found that i need to instrument the daemon which includes the
>> > instrumented library for the code to compile.
>> >
>> > Can't I have a daemon (without tracing functionality) which can include
>> > an
>> > instrumented library (i don't want to use tracing functionality in this
>> > case)
>> >
>> > I'm only able to build if both library and daemon which includes it are
>> > instrumented.
>> >
>> > Can anyone please give me more details on how to do this?
>> > This is useful for huge code bases where you can selectively add traci=
ng
>> > support to few libraries or daemons.
>> >
>> > Anand Neeli
>>
>>    It can be done.  An uninstrumented app can rely on an instrumented
>> shared object; whether the latter produces lttng events then depends on
>> whether or not the tracepoint provider shared object is loaded when the =
app
>> is invoked (using LD_PRELOAD).
>>
>>    Here is sample_neeli.c:
>> #####
>> #include <stdio.h> //For printf
>> #include <unistd.h>
>>
>> #include "cobject.h"
>> int main(int argc, char **argv)
>> {
>>         int i =3D 0;
>>         char themessage[20]; //Can hold up to "Hello World 9999999\0"
>>
>>         fprintf(stderr, "sample_neeli starting\n");
>>         for (i =3D 0; i < 10000; i++) {
>>                 //We either prepare themessage in this module, or rely on
>> an
>>                 //external shared object
>>                 cobject_message(themessage, i);
>>                 usleep(1);
>>         }
>>         fprintf(stderr, "sample_neeli done\n");
>>         return 0;
>> }
>> #####
>> cobject.c:
>> #####
>> #include <stdio.h> //For printf
>> #include <unistd.h>
>>
>> #include "tp.h"
>>
>> void cobject_message(char *themessage, int i)
>> {
>>         tracepoint(sample_component, event, "cobject_message");
>>         sprintf(themessage, "CObject %u", i);
>> }
>> #####
>> cobject.h:
>> #####
>> extern void cobject_message(char *themessage, int i);
>> #####
>> The tracepoint provider code should be easy to guess.
>>
>> The relevant Makefile fragments:
>> #####
>> CC =3D gcc
>> LIBDL =3D -ldl # On Linux
>> #LIBDL =3D -lc # On BSD
>> LOCAL_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)
>> LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)
>> SOFLAGS =3D -fPIC
>> TP_DEFINE =3D -D TRACEPOINT_DEFINE
>> TP_DEFINE_DYNAMIC =3D $(TP_DEFINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE
>> SOVERSION_MAJOR =3D 1
>> SOVERSION_MINOR =3D 0
>>
>> libcobject.so: libcobject.o
>>         @echo "~~~~~~Packaging $@:"
>>         $(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed
>> \
>>            -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $^
>>         ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR)
>> $@.$(SOVERSION_MAJOR)
>>         ln -sf $@.$(SOVERSION_MAJOR) $@
>>
>> libcobject.o: cobject.c cobject.h tp.h
>>         @echo "~~~~~~Compiling $@:"
>>         $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(SOFLAGS)
>> $(TP_DEFINE_DYNAMIC) \
>>            -c -o $@ $<
>>
>> neeli_dynamic_lib:: neeli_dynamic_lib.o
>>         @echo "~~~~~~Linking sample_$@:"
>>         $(CC) -Wl,-no-as-needed -o $@ -L. -lcobject $^ $(LDFLAGS) \
>>            $(LIBDL) -Wl,-rpath,'$$ORIGIN',--enable-new-dtags
>>         @echo "   Use '[LD_PRELOAD=3D./libtp.so] ./$@' to run $@"
>>
>> neeli_dynamic_lib.o: sample_neeli.c cobject.h
>>         @echo "~~~~~~Compiling $@:"
>>         $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) -c -o $@ $<
>> #####
>>
>>    Running './neeli_dynamic_lib' yields no events.  Running
>> 'LD_PRELOAD=3D./libtp.so ./neeli_dynamic_lib' yields the libcobject.so e=
vents.
>>
>> Daniel U. Thibault
>> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
>> Countermeasures (SPC)
>> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critic=
al
>> Cyber Security (MCCS)
>> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence =
R&D
>> Canada - Valcartier (DRDC Valcartier)
>> 2459 route de la Bravoure
>> Qu=E9bec QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada | Government of Canada
>> <http://www.valcartier.drdc-rddc.gc.ca/>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
