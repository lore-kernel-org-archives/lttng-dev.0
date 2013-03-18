From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: dlopen, gcc -l and LD_PRELOAD
Date: Mon, 18 Mar 2013 16:58:08 -0400
Message-ID: <CA+jJMxvD+g9kPeeqP5hbELOk40qMwD-+UBfMUVNRQfypXk_ycw__34328.1115092852$1363640349$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD027A2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxvm5=mms0BwFtDEy8CKuYOM08K7EYCddKWoRY2VSbxV1Q@mail.gmail.com>
	<48CF5AC71E61DB46B70D0F388054EFFD028674@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UHh8I-0004a1-Vy
	for lttng-dev@lists.lttng.org; Mon, 18 Mar 2013 16:58:15 -0400
Received: by mail-wg0-f41.google.com with SMTP id ds1so2866763wgb.4
	for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2013 13:58:09 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD028674@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Mon, Mar 18, 2013 at 3:07 PM, Thibault, Daniel
<Daniel.Thibault@drdc-rddc.gc.ca> wrote:
> -----Message d'origine-----
> Envoy=E9 : 15 mars 2013 15:33
>
> On Fri, Mar 15, 2013 at 12:41 PM, Thibault, Daniel <Daniel.Thibault@drdc-=
rddc.gc.ca> wrote:
>>    In the lttng-ust man pages, there is a paragraph that reads:
>>
>> Note about dlopen() usage: Due to locking side-effects caused by the way=
 libc lazily resolves Thread-Local Storage (TLS) symbols when a library is =
dlopened, linking the tracepoint probe or liblttng-ust with dlopen() is dis=
couraged.  They should be linked with the application using "-llibname" or =
loaded with LD_PRELOAD.
>>
>>    I'm confused by the LD_PRELOAD bit: as far as I know, LD_PRELOAD serv=
es only to substitute a dynamic library (the LD_PRELOAD argument) for anoth=
er (the one the executable was linked against).  I don't see how one could =
compile an instrumented application and leave its tracepoint provider unlin=
ked, which is what the stated -llibname <-> LD_PRELOAD opposition implies.
>>
>
> You may want to have a look at the comment at
> lttng-ust/include/lttng/tracepoint.h:229 which explains how this is accom=
plished. Basically, the tracepoint provider symbols are initialised and the=
 probe is registered when the provider's shared object constructor is invok=
ed. See ust-tracepoint-event.h:671 if you are interested in the actual impl=
ementation.
>
>>    (Also, shouldn't that paragraph drop 'lazily', assuming the locking
>> problems also arise if dlopen is used with RTLD_NOW?  Because if
>> RTLD_NOW fixed the locking problem, that's what would be recommended
>> here, no?)
>
> Good question. I think this problem has been fixed as part of the 2.1 rel=
ease. However, I do know there are other issues related to "dlopen()"-ing p=
robe providers; details on the bug tracker[1].
>
> J=E9r=E9mie
> [1] https://bugs.lttng.org/issues/447
> -----Fin du message d'origine-----
>
>    Bug 447 concerns dlclose(), not dlopen().  It's a legitimate concern (=
that has yet to be addressed, it seems), but it has nothing to do with pote=
ntial delays or deadlocks upon calling dlopen() on a tracepoint provider.
>

Indeed, hence why I have mentioned there were _other_ potential issues
with the dynamic linking loader interface of which you should be aware
before using it to load the providers.

>    I'm not concerned with how the tracepoint provider initialises its sym=
bols and registers its probe(s) with the session daemons when its construct=
or is invoked, I'm just trying to figure out what "They [the tracepoint pro=
vider and liblttng-ust] should be linked with the application using '-llibn=
ame' or loaded with LD_PRELOAD" means.  The first part of the (apparently e=
xclusive) or clearly refers to implementing the tracepoint provider as an .=
so but making the instrumented application statically aware of it (I'm dubi=
ous anyone would try to use liblttng-ust through dlopen(), though).  Is the=
 second part saying that if the app explicitly loads the tracepoint provide=
r .so through dlopen(), setting LD_PRELOAD when calling the app will fix (c=
ircumvent) the locking problems?
>

Typically, you would want to do one or the other [dlopen or
LD_PRELOAD]. But to answer your question, yes, this would workaround
the locking problem described in the man page that affected prior
versions of lttng-ust (before 2.1).

>    For that matter, I have yet to successfully divine what a tracepoint p=
rovider .so makefile should look like (the lttng-ust man pages don't give a=
n understandable example, and my experience with dynamic libraries has most=
ly been under Windows).  If you could provide one, I'd be grateful.  Here's=
 as far as I've got, using lttng-ust/doc/example/easy-ust:
>

Have a look at the Makefiles and sources in lttng-ust/tests/demo and
lttng-ust/tests/daemon which respectively demonstrate the use of
tracepoint providers that are dynamically linked and built as part of
the traced application.

> The normal Makefile:
>
> CC =3D gcc
> LIBS =3D -ldl -llttng-ust         # On Linux
> #LIBS =3D -lc -llttng-ust         # On BSD
> CFLAGS =3D -I.
> LDFLAGS =3D -L/usr/local/lib
>
> all: sample
>
> sample: sample.o tp.o
>         $(CC) -o $@ $^ $(LDFLAGS) $(LIBS)
>
> sample.o: sample.c sample_component_provider.h
>         $(CC) $(CFLAGS) -c -o $@ $(LDFLAGS) $<
>
> tp.o: tp.c sample_component_provider.h
>         $(CC) $(CFLAGS) -c -o $@ $(LDFLAGS) $<
> [...]
>
> Yields:
> gcc -I. -c -o sample.o -L/usr/local/lib sample.c
> gcc -I. -c -o tp.o -L/usr/local/lib tp.c
> gcc -o sample sample.o tp.o -L/usr/local/lib -ldl -llttng-ust
>
> I can make sample using a static library instead, by changing the Makefil=
e thus:
>
> AR =3D ar
> CC =3D gcc
> [...]
> sample: sample.o libtp.a
>         $(CC) -o $@ $^ $(LDFLAGS) -L. $(LIBS)
>
> sample.o: sample.c sample_component_provider.h
>         $(CC) $(CFLAGS) -c -o $@ $(LDFLAGS) $<
>
> libtp.a: tp.o
>         $(AR) -cq $@ $<
>
> tp.o: tp.c sample_component_provider.h
>         $(CC) $(CFLAGS) -c -o $@ $(LDFLAGS) $<
> [...]
>
> Which yields:
> gcc -I. -c -o sample.o -L/usr/local/lib sample.c
> gcc -I. -c -o tp.o -L/usr/local/lib tp.c
> ar -cq libtp.a tp.o
> gcc -o sample sample.o libtp.a -L/usr/local/lib -L. -ldl -llttng-ust
>
> In switching to a statically aware dynamic library, I first modify sample=
.c by adding '#define TRACEPOINT_PROBE_DYNAMIC_LINKAGE' right after '#defin=
e TRACEPOINT_DEFINE'.
>
> Then I've tried to use this Makefile:
>
> CC =3D gcc
> LIBS =3D -ldl -llttng-ust         # On Linux
> #LIBS =3D -lc -llttng-ust         # On BSD
> CFLAGS =3D -I.
> SOFLAGS =3D -fPIC
> SOVERSION_MAJOR =3D 1
> SOVERSION_MINOR =3D 0
> LDFLAGS =3D -L/usr/local/lib
>
> all: libtp.so sample
>
> sample: sample.o
>         $(CC) -o $@ $< $(LDFLAGS) $(LIBS) -L. -ltp
>
> sample.o: sample_so.c sample_component_provider.h
>         $(CC) $(CFLAGS) -c -o $@ $(LDFLAGS) $(LIBS) -L. -ltp $<
>
> libtp.so: tp.o
>         $(CC) -shared -W1,-soname,$@.$(SOVERSION_MAJOR) -o $@.$(SOVERSION=
_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIBS) $<
>         ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MA=
JOR)
>         ln -sf $@.$(SOVERSION_MAJOR) $@
>
> tp.o: tp.c sample_component_provider.h
>         $(CC) $(CFLAGS) $(SOFLAGS) $(LDFLAGS) $(LIBS) -c -o $@ $<
>
> Which yields:
> gcc -I. -fPIC -L/usr/local/lib -ldl -llttng-ust -c -o tp.o tp.c
> gcc -shared -W1,-soname,libtp.so.1 -o libtp.so.1.0 -L/usr/local/lib -ldl =
-llttng-ust tp.o
> ln -sf libtp.so.1.0 libtp.so.1
> ln -sf libtp.so.1 libtp.so
> gcc -I. -c -o sample.o -L/usr/local/lib -ldl -llttng-ust -L. -ltp sample.c
> gcc -o sample sample.o -L/usr/local/lib -ldl -llttng-ust -L. -ltp
> /usr/bin/ld: warning: hidden symbol 'tracepoint_dlopen' in sample.o is re=
ferenced by DSO ./libtp.so
>
>    I've tried a number of things to get rid of the warning.  For some rea=
son the 'tracepoint_dlopen' struct symbol in tp.o gets linked (when buildin=
g 'sample' in the last step) to the one in sample.o (which has the same sou=
rce: the sample_component_provider.h) instead of the one in liblttng-ust.  =
If I try a command like 'LD_PRELOAD=3D./libtp.so ./sample', I get "symbol l=
ookup error: ./libtp.so: undefined symbol: tracepoint_dlopen".
>
>    I'm sure this is a very simple, obvious, dumb mistake, so please point=
 it out to me!
>
> lttng-ust/tests/demo/demo-trace, although built by lttng-ust's make, also=
 has the tracepoint_dlopen problem.  This now looks like a bug introduced s=
omewhen since the demos were written (and last tested, it seems).

I don't see this warning and error here. Which release are you using?

> Daniel U. Thibault
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critica=
l Cyber Security (MCCS)
> Protection des syst=E8mes et contremesures (PSC) / Systems Protection & C=
ountermeasures (SPC)
> 2459 route de la Bravoure
> Qu=E9bec, QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada / Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
