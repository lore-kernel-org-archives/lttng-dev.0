From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: instrumenting shared library
Date: Sat, 5 Apr 2014 01:46:46 +0530
Message-ID: <CAM5kDqyCTjKLWhR5XXT9DvXHaniOnJy0SPSDOMPw3eCSD7Z6Uw__12363.9565230862$1396642698$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com>
 <48CF5AC71E61DB46B70D0F388054EFFD3599315B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0738177814=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1WWAXk-0003EW-OL
 for lttng-dev@lists.lttng.org; Fri, 04 Apr 2014 16:17:01 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so3953156pbc.20
 for <lttng-dev@lists.lttng.org>; Fri, 04 Apr 2014 13:16:46 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD3599315B@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0738177814==
Content-Type: multipart/alternative; boundary=047d7bacb2e673cbf904f63d32a8

--047d7bacb2e673cbf904f63d32a8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Daniel,
Thanks for your detailed mail.
I will spend time with my code and get back if i have more queries.

What i'm looking at it is: adding lttng infra in our code base. I'm looking
for a solution where most of the lttng build and launch parts are
abstracted to the end app/library developer.
That is the reason why i'm not in favor of having LD_PRELOAD while
launching an app. This would need the app developer to check if included
libraries has tracing support and add .so appropriately to LD_PRELOAD
(which needs more education to developer on lttng and included libraries)
If we can launch app(with or without instrumented library) normally and
limit the complexity of linking to makefile it will be great.

Please keep me posted if you have any more thoughts on this.
Also, can you please send me the users guide.

Thanks,
Anand Neeli


On Fri, Apr 4, 2014 at 8:13 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

>  *De :* Anand Neeli [mailto:anand.neeli@gmail.com]
> *Envoy=E9 :* 4 avril 2014 01:45
>
>   > Thanks for your reply.
>
> > Sorry for my ignorance but how are you generating libtp.so in your
> example?
>
>
>
> Non-boilerplate parts are in red.
>
>
>
> tp.c:
>
> #####
>
> /*
>
> * Defining macro creates the code objects of the traceprobes.
>
> * Must be done only once per file (this #define controls tracepoint.h and
>
> * tracepoint-event.h).
>
> */
>
> #define TRACEPOINT_CREATE_PROBES
>
> /*
>
> * The header containing our TRACEPOINT_EVENTs.
>
> */
>
> #include "tp.h"
>
> #####
>
> tp.h:
> #####
> #undef TRACEPOINT_PROVIDER
>
> #define TRACEPOINT_PROVIDER sample_component
>
> /*
>
> * include file (this files's name)
>
> */
>
> #undef TRACEPOINT_INCLUDE
>
> #define TRACEPOINT_INCLUDE "./tp.h"
>
> /*
>
> * Add this precompiler conditional to ensure the tracepoint event
> generation
>
> * can include this file more than once.
>
> */
>
> #if !defined(_SAMPLE_COMPONENT_PROVIDER_H) ||
> defined(TRACEPOINT_HEADER_MULTI_READ)
>
> #define _SAMPLE_COMPONENT_PROVIDER_H
>
> /*
>
> * Add this to allow programs to call "tracepoint(...)".
>
> * This #include must not be within an extern "C" block; if it is,
>
> * C++ instrumentation will fail when SystemTap is also installed.
>
> * (This may have been fixed since I wrote this)
>
> */
>
> #include <lttng/tracepoint.h>
>
> /*
>
> * Add this macro and its matching element to make sure the program
>
> * works in C++.
>
> */
>
> #ifdef __cplusplus
>
> extern "C" {
>
> #endif /* __cplusplus */
>
>
>
> /*
>
> * The following tracepoint event writes a message (C string) into the
>
> * field "message" of the trace event "event" in the provider
>
> * "sample_component" in other words:
>
> *
>
> *    sample_component:event:message =3D text.
>
> */
>
> TRACEPOINT_EVENT(
>
>             /*
>
>             * provider name, not a variable but a string starting with a
> letter
>
>             * and containing either letters, numbers or underscores.
>
>             * Needs to be the same as TRACEPOINT_PROVIDER
>
>             */
>
>             sample_component,
>
>             /*
>
>             * tracepoint name, same format as sample provider. Does not
> need to be
>
>             * declared before. in this case the name is "event"
>
>             */
>
>             event,
>
>             /*
>
>             * TP_ARGS macro contains the arguments passed for the
> tracepoint.
>
>             * It is in the following format:
>
>             *                     TP_ARGS( type1, name1, type2, name2, ..=
.
> type10, name10)
>
>             * where there can be from zero to ten elements.
>
>             * "typeN" is the datatype, such as int, struct or double **.
>
>             * "name" is the variable name (in "int myInt" the name would
> be "myInt")
>
>             *                     TP_ARGS() is valid (no arguments)
>
>             *                     TP_ARGS( void ) is valid too
>
>             */
>
>             TP_ARGS(const char *, text),
>
>             /*
>
>             * TP_FIELDS describes how to write the fields of the trace
> event.
>
>             * You can use the args here
>
>             */
>
>             TP_FIELDS(
>
>             /*
>
>             * The ctf_string macro takes a C string and writes it into a
> field
>
>             * named "message"
>
>             */
>
>                         ctf_string(message, text)
>
>             )
>
> )
>
> /*
>
> * Trace loglevel, shows the level of the trace event. It can be
> TRACE_EMERG,
>
> * TRACE_ALERT, TRACE_CRIT, TRACE_ERR, TRACE_WARNING, TRACE_INFO, etc.
>
> * If this is not set, TRACE_DEFAULT is assumed.
>
> * The first two arguments identify the tracepoint.
>
> * See details in <lttng/tracepoint.h> line 347
>
> */
>
> TRACEPOINT_LOGLEVEL(
>
>        /*
>
>         * The provider name, must be the same as the provider name in the
>
>         * TRACEPOINT_EVENT and as TRACEPOINT_PROVIDER above.
>
>         */
>
>             sample_component,
>
>        /*
>
>         * The tracepoint name, must be the same as the tracepoint name in
> the
>
>         * TRACEPOINT_EVENT
>
>         */
>
>             event,
>
>        /*
>
>         * The tracepoint loglevel. WARNING: Some levels are abbreviated a=
nd
>
>         * others are not, please see <lttng/tracepoint.h>
>
>         */
>
>             TRACE_WARNING
>
> )
>
>  (more tracepoints...)
>
>
>
> /*
>
> * Add this macro and its matching element to make sure the program
>
> * works in C++.
>
> */
>
> #ifdef __cplusplus
>
> }
>
> #endif /* __cplusplus */
>
> /*
>
> * Add this after defining the tracepoint events to expand the macros.
>
> */
>
> #include <lttng/tracepoint-event.h>
>
> #endif /* _SAMPLE_COMPONENT_PROVIDER_H */
>
> #####
>
> The relevant Makefile fragments:
> #####
> CC =3D gcc
> LIBUST =3D -llttng-ust
>
> LOCAL_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)
> LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)
> SOFLAGS =3D -fPIC
> SOVERSION_MAJOR =3D 1
> SOVERSION_MINOR =3D 0
>
> libtp.so: libtp.o
>
>             @echo "~~~~~~Packaging $@:"
>
>             $(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR)
> -Wl,-no-as-needed \
>
>                -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS)
> $(LIBUST) $<
>
>             ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR)
> $@.$(SOVERSION_MAJOR)
>
>             ln -sf $@.$(SOVERSION_MAJOR) $@
>
>
>
> libtp.o: tp.c tp.h
>
>             @echo "~~~~~~Compiling $@:"
>
>             $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(SOFLAGS) -c -o $@ $<
>
>
> > 1) Also will this solution scale if my binary depends on lots
> of libraries which are instrumented?
>
>
>
> Sure.  I'd expect linear scaling.  Each library, upon being loaded, looks
> for its tracepoint provider and turns its tracepoints off if they're not
> found.
>
>
>
> > 2) i'm fine with linking statically, can we avoid LD_PRELOAD?
>
>
>
> Besides the LD_PRELOAD technique, you could also use LD_LIBRARY_PATH, but
> that works only if the application statically includes the tracepoint
> provider (I suppose it would likewise work for an instrumented shared
> object only if it statically includes the tracepoint provider).
>
>
>
> You could also add "-Wl,-rpath,'$$ORIGIN'" to the linker call to add an
> RPATH tag to the application (or shared object).  This makes it look for
> its dependencies in its starting directory ($ORIGIN).  RPATH is, unlike
> RUNPATH, applicable to libraries as well: a library with an RPATH tag wil=
l
> look there for its dependencies; failing its own RPATH, it will use its
> executable's RPATH.
>
>
>
> Finally, you can dynamically include the tracepoint provider (libtp) as a
> dependency.  The application (sample_static_aware) is then statically awa=
re
> of libtp and won't run without it.  The application (sample_dynamic) can
> alternately dynamically include the tracepoint provider *without* static
> awareness.  Here's how it's done:
>
>
>
> LIBDL =3D -ldl # On Linux
>
> #LIBDL =3D -lc # On BSD
>
> TP_DEFINE =3D -D TRACEPOINT_DEFINE
>
> TP_DEFINE_DYNAMIC =3D $(TP_DEFINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE
>
>
>
> #(the inclusion of a libtp NEEDED tag requires "-no-as-needed -ltp").
>
> #Note that "-L. -ltp", when used, should appear before $(LDFLAGS) $(LIBDL=
).
>
> static_aware: static.o libtp.so
>
>             @echo "~~~~~~Linking sample_$@:"
>
> #          $(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $< $(LDFLAGS)
> $(LIBDL) \
>
> #             -Wl,-rpath,'$$ORIGIN',--enable-new-dtags
>
>             $(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $< $(LDFLAGS)
> $(LIBDL)
>
>             @echo "   Use 'LD_PRELOAD=3D./libtp.so ./sample_$@' to run
> sample_$@"
>
>
>
> static.o: sample.c tp.h
>
>             @echo "~~~~~~Compiling $@:"
>
>             $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE) -c -o $@ $<
>
>
>
> #If not preloaded, the sample application runs but won't be traceable.
>
> #Putting libtp in the path won't work: the sample does not look for it.
>
> dynamic: dynamic.o libtp.so
>
>             @echo "~~~~~~Linking sample_$@:"
>
>             $(CC) -o sample_$@ $< $(LDFLAGS) $(LIBDL)
>
>             @echo "   Use '[LD_PRELOAD=3D./libtp.so] ./sample_$@' to run
> sample_$@"
>
>
>
> #Compare with the 'static.o' target.
>
> dynamic.o: sample.c tp.h
>
>             @echo "~~~~~~Compiling $@:"
>
>             $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE_DYNAMIC) \
>
>                -c -o $@ $<
>
>
>
>    The case where the app isn't traced but the library it uses is traced
> should be a variation on this.  I'll try it out sometime in the near
> future, but you should be able to figure it out from the above.  Here's a
> first guess (it may need $(LIBDL) alongside $(LIBUST)):
>
>
>
> libtp.so: libtp.o
>
>             @echo "~~~~~~Packaging $@:"
>
>             $(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR)
> -Wl,-no-as-needed -L. -ltp \
>
>                -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS)
> $(LIBUST) $<
>
>             ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR)
> $@.$(SOVERSION_MAJOR)
>
>             ln -sf $@.$(SOVERSION_MAJOR) $@
>
>
>
>
>
> > 3) Is there any page which explains on why and how to use
>
> > TRACEPOINT_PROVIDER, TRACEPOINT_CREATE_PROBES, TRACEPOINT_INCLUDE,
> TRACEPOINT_DEFINE, TRACEPOINT_PROBE_DYNAMIC_LINKAGE
>
>
>
> They're reasonably explained in the demonstration apps.  I discuss them a
> little more in depth in the forthcoming LTTng Comprehensive User's Guide =
(I
> could send you a copy of the draft, as we've just begun its first review
> round).
>
>
>
> > my tp.h is, are there any errors in this?
>
> > #############
>
>
>
> #undef TRACEPOINT_PROVIDER
>
>
>
> > #define TRACEPOINT_PROVIDER sample_component
>
> >
>
> > #undef TRACEPOINT_INCLUDE
>
> > #define TRACEPOINT_INCLUDE "./tp.h"
>
> >
>
> > #if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
>
> > #define _TP_H
>
>
>
> (Ideally, use _SAMPLE_COMPONENT_PROVIDER_H instead of _TP_H)
>
>
>
> > #include <lttng/tracepoint.h>
>
>
>
> #ifdef __cplusplus
>
> extern "C" {
>
> #endif /* __cplusplus */
>
>
>
> > TRACEPOINT_EVENT(
>
> >        sample_component,
>
> >        event,
>
> >        TP_ARGS(char *, text),
>
>
>
> (the compiler may be happier with const char * instead)
>
>
>
> >        TP_FIELDS(
>
> >                ctf_string(message, text)
>
> >        )
>
> >)
>
> > TRACEPOINT_LOGLEVEL(
>
> >        sample_component,
>
> >        event,
>
> >        TRACE_WARNING)
>
>
>
> #ifdef __cplusplus
>
> }
>
> #endif /* __cplusplus */
>
>
>
> > #endif /* _TP_H */
>
> > #include <lttng/tracepoint-event.h>
>
>
>
> (move #include <lttng/tracepoint-event.h> inside of the #if
> !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ))
>
>
>
> > #############
>
> >
>
> > Thanks,
>
> > Anand Neeli
>
>
>
>    One key change I made to my sample applications is to remove the
> "#define TRACEPOINT_DEFINE" that precedes the "#include "tp.h"" line.  I
> prefer to control that #define using a compiler -D option.  It makes the
> makefile clearer and resolves the problem of making sure there is just on=
e
> module that turns that #define on.
>
>
>
>    Hope this helps.
>
>
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l
> Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ<http=
://--ESFSECEV-TY3011-------------------------------->
> >
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/<http://--ESFSECEV-TY3011---------=
------------>
> >
>

--047d7bacb2e673cbf904f63d32a8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<div>Thanks for your detailed mail.</div><div>I =
will spend time with my code and get back if i have more queries.</div><div=
><br></div><div>What i&#39;m looking at it is: adding lttng infra in our co=
de base. I&#39;m looking for a solution where most of the lttng build and l=
aunch parts are abstracted to the end app/library developer.&nbsp;</div>
<div>That is the reason why i&#39;m not in favor of having LD_PRELOAD while=
 launching an app. This would need the app developer to check if included l=
ibraries has tracing support and add .so appropriately to LD_PRELOAD (which=
 needs more education to developer on lttng and included libraries)&nbsp;</=
div>
<div>If we can launch app(with or without instrumented library) normally an=
d limit the complexity of linking to makefile it will be great.</div><div><=
br></div><div>Please keep me posted if you have any more thoughts on this.<=
/div>
<div>Also, can you please send me the users guide.<br></div><div><br></div>=
<div>Thanks,</div><div>Anand Neeli</div></div><div class=3D"gmail_extra"><b=
r><br><div class=3D"gmail_quote">On Fri, Apr 4, 2014 at 8:13 PM, Thibault, =
Daniel <span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc=
.ca" target=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">





<div lang=3D"FR-CA" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D"MsoNormal"><b><span lang=3D"EN-CA" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">De&nbsp;:</span></b><s=
pan lang=3D"EN-CA" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;=
,&quot;sans-serif&quot;"> Anand Neeli [mailto:<a href=3D"mailto:anand.neeli=
@gmail.com" target=3D"_blank">anand.neeli@gmail.com</a>]
<br>
<b>Envoy=E9&nbsp;:</b> 4 avril 2014 01:45<br>
<br>
</span><span lang=3D"EN-CA"><u></u><u></u></span></p>
<div><div class=3D"">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">Thanks for your reply.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&gt; </=
span><span lang=3D"EN-CA">Sorry for my ignorance but how are you generating=
&nbsp;</span><span lang=3D"EN-CA" style=3D"font-size:10.0pt;font-family:&qu=
ot;Arial&quot;,&quot;sans-serif&quot;">libtp.so in your example?</span><spa=
n lang=3D"EN-CA"><u></u><u></u></span></p>

</div>
</div><div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d"><u></u>=
&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Non-boiler=
plate parts are in
</span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,&quot;sans-serif&quot;;color:red">red</span><span lang=3D"EN-CA"=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:#1f497d">.<u></u><u></u></span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:red">tp</span><s=
pan lang=3D"EN-CA">.c:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#####<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Defining macro creates the co=
de objects of the traceprobes.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Must be done only once per fi=
le (this #define controls tracepoint.h and<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* tracepoint-event.h).<u></u><u=
></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#define TRACEPOINT_CREATE_PROBE=
S<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* The header containing our TRA=
CEPOINT_EVENTs.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#include &quot;<span style=3D"c=
olor:red">tp</span>.h&quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#####<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:red">tp</span><s=
pan lang=3D"EN-CA">.h:<br>
#####<br>
#undef TRACEPOINT_PROVIDER<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#define TRACEPOINT_PROVIDER <sp=
an style=3D"color:red">
sample_component</span><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* include file (this files&#39;=
s name)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p><div=
 class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#undef TRACEPOINT_INCLUDE<u></u=
><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#define TRACEPOINT_INCLUDE &quo=
t;./<span style=3D"color:red">tp</span>.h&quot;<u></u><u></u></span></p>
</div><p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this precompiler conditio=
nal to ensure the tracepoint event generation<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* can include this file more th=
an once.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#if !defined(_<span style=3D"co=
lor:red">SAMPLE_COMPONENT</span>_PROVIDER_H) || defined(TRACEPOINT_HEADER_M=
ULTI_READ)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#define _<span style=3D"color:r=
ed">SAMPLE_COMPONENT</span>_PROVIDER_H<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this to allow programs to=
 call &quot;tracepoint(...)&quot;.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* This #include must not be wit=
hin an extern &quot;C&quot; block; if it is,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* C++ instrumentation will fail=
 when SystemTap is also installed.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* (This may have been fixed sin=
ce I wrote this)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#include &lt;lttng/tracepoint.h=
&gt;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this macro and its matchi=
ng element to make sure the program<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* works in C++.<u></u><u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#ifdef __cplusplus<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">extern &quot;C&quot; {<u></u><u=
></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#endif /* __cplusplus */<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* The following tracepoint even=
t writes a message (C string) into the<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* field &quot;message&quot; of =
the trace event &quot;event&quot; in the provider<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* &quot;sample_component&quot; =
in other words:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*&nbsp;&nbsp;&nbsp; sample_comp=
onent:event:message =3D text.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">TRACEPOINT_EVENT(<u></u><u></u>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * provider name, not a variable but a s=
tring starting with a letter<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and containing either letters, number=
s or underscores.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Needs to be the same as TRACEPOINT_PR=
OVIDER<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">sample_compon=
ent</span>,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * tracepoint name, same format as sampl=
e provider. Does not need to be<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * declared before. in this case the nam=
e is &quot;event&quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">event</span>,=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TP_ARGS macro contains the arguments =
passed for the tracepoint.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * It is in the following format:<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; TP_ARGS( type1, name1, type2, name2, ... type10, name10)<u></u><u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * where there can be from zero to ten e=
lements.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &quot;typeN&quot; is the datatype, su=
ch as int, struct or double **.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &quot;name&quot; is the variable name=
 (in &quot;int myInt&quot; the name would be &quot;myInt&quot;)<u></u><u></=
u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; TP_ARGS() is valid (no arguments)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; TP_ARGS( void ) is valid too<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(<span style=3D"color:red">const=
 char *, text</span>),<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TP_FIELDS describes how to write the =
fields of the trace event.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * You can use the args here<u></u><u></=
u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_FIELDS(<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The ctf_string macro takes a C string=
 and writes it into a field<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * named &quot;message&quot;<u></u><u></=
u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">
ctf_string(message, text)<u></u><u></u></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Trace loglevel, shows the lev=
el of the trace event. It can be TRACE_EMERG,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* TRACE_ALERT, TRACE_CRIT, TRAC=
E_ERR, TRACE_WARNING, TRACE_INFO, etc.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* If this is not set, TRACE_DEF=
AULT is assumed.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* The first two arguments ident=
ify the tracepoint.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* See details in &lt;lttng/trac=
epoint.h&gt; line 347<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">TRACEPOINT_LOGLEVEL(<u></u><u><=
/u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * The provider name, must be the same as the provider name in t=
he<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * TRACEPOINT_EVENT and as TRACEPOINT_PROVIDER above.<u></u><u><=
/u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">sample_compon=
ent</span>,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * The tracepoint name, must be the same as the tracepoint name =
in the<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * TRACEPOINT_EVENT<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">event</span>,=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * The tracepoint loglevel. WARNING: Some levels are abbreviated=
 and<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * others are not, please see &lt;lttng/tracepoint.h&gt;<u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">TRACE_WARNING=
<u></u><u></u></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">(more tracepoints&hellip;)<u></=
u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><u></u>&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this macro and its matchi=
ng element to make sure the program<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* works in C++.<u></u><u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#ifdef __cplusplus<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">}<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#endif /* __cplusplus */<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this after defining the t=
racepoint events to expand the macros.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#include &lt;lttng/tracepoint-e=
vent.h&gt;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#endif /* _<span style=3D"color=
:red">SAMPLE_COMPONENT</span>_PROVIDER_H */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#####</span></p><div class=3D""=
><br>
The relevant Makefile fragments:<br>
#####<br>
CC =3D gcc<br>
</div><span style=3D"color:#1f497d">LIBUST =3D -llttng-ust<u></u><u></u></s=
pan><p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"></span></p><div class=3D"">LOCA=
L_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)<br>
LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)<br>
SOFLAGS =3D -fPIC<br></div><div class=3D"">
SOVERSION_MAJOR =3D 1<br>
SOVERSION_MINOR =3D 0<br>
<br>
</div><span style=3D"color:#1f497d">libtp.so: libtp.o<u></u><u></u></span><=
p></p><div class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Packaging $@:&quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -shared -=
Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed \<u></u><u></u></span></=
p>
</div><p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp; -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIBUST) $&lt;<=
u></u><u></u></span></p><div class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $@.$(SOV=
ERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MAJOR)<u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $@.$(SOV=
ERSION_MAJOR) $@<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d"><u></u>=
&nbsp;<u></u></span></p>
</div><p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">l=
ibtp.o: tp.c tp.h<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Compiling $@:&quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CPPFLAG=
S) $(LOCAL_CPPFLAGS) $(SOFLAGS) -c -o $@ $&lt;<u></u><u></u></span></p><div=
 class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><br>
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">1) Also will this solution scale if my binary depends on lo=
ts of&nbsp;libraries which are&nbsp;instrumented?</span><span lang=3D"EN-CA=
"><u></u><u></u></span></p>

</div></div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d"><u></u>=
&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Sure.&nbsp=
; I&rsquo;d expect linear scaling.&nbsp; Each library, upon being loaded, l=
ooks for its tracepoint provider and turns its tracepoints off if they&rsqu=
o;re
 not found.<u></u><u></u></span></p><div class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">2) i&#39;m fine with linking statically, can we avoid LD_PR=
ELOAD?<span style=3D"color:#1f497d"><u></u><u></u></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
</div><p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quo=
t;Arial&quot;,&quot;sans-serif&quot;;color:#1f497d">Besides the LD_PRELOAD =
technique, you could also use LD_LIBRARY_PATH, but that works only if the a=
pplication statically includes the tracepoint provider (I suppose
 it would likewise work for an instrumented shared object only if it static=
ally includes the tracepoint provider).<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">You could also add &quot;-Wl,=
-rpath,&#39;$$ORIGIN&#39;&quot; to the linker call to add an RPATH tag to t=
he application (or shared object). &nbsp;This makes it look for its depende=
ncies
 in its starting directory ($ORIGIN). &nbsp;RPATH is, unlike RUNPATH, appli=
cable to libraries as well: a library with an RPATH tag will look there for=
 its dependencies; failing its own RPATH, it will use its executable&#39;s =
RPATH.<u></u><u></u></span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">Finally, you can dynamically =
include the tracepoint provider (libtp) as a dependency.&nbsp; The applicat=
ion (sample_static_aware) is then statically aware of libtp and
 won&#39;t run without it.&nbsp; The application (sample_dynamic) can alter=
nately dynamically include the tracepoint provider
<i>without</i> static awareness.&nbsp; Here&rsquo;s how it&rsquo;s done:<u>=
</u><u></u></span></p><div class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">LIBDL =3D -ldl # On Linux<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">#LIBDL =3D -lc # On BSD<u></u=
><u></u></span></p>
</div><p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quo=
t;Arial&quot;,&quot;sans-serif&quot;;color:#1f497d">TP_DEFINE =3D -D TRACEP=
OINT_DEFINE<u></u><u></u></span></p><div class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">TP_DEFINE_DYNAMIC =3D $(TP_DE=
FINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
</div><p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quo=
t;Arial&quot;,&quot;sans-serif&quot;;color:#1f497d">#(the inclusion of a li=
btp NEEDED tag requires &quot;-no-as-needed -ltp&quot;).<u></u><u></u></spa=
n></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">#Note that &quot;-L. -ltp&quo=
t;, when used, should appear before $(LDFLAGS) $(LIBDL).<u></u><u></u></spa=
n></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">static_aware: static.o libtp.=
so<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~~~~Linking sample_$@:&=
quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">#&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $&=
lt; $(LDFLAGS) $(LIBDL) \<u></u><u></u></span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">#&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -Wl,-rpath,&#39;$$ORIGIN&#39;,--ena=
ble-new-dtags<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -Wl,-no-as-needed -o sample_$@ =
-L. -ltp $&lt; $(LDFLAGS) $(LIBDL)<u></u><u></u></span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;&nbsp;&nbsp; Use &#39;LD_=
PRELOAD=3D./libtp.so ./sample_$@&#39; to run sample_$@&quot;<u></u><u></u><=
/span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">static.o: sample.c tp.h<u></u=
><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~~~~Compiling $@:&quot;=
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $=
(TP_DEFINE) -c -o $@ $&lt;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d"><u></u>=
&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">#If not=
 preloaded, the sample application runs but won&#39;t be traceable.<u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">#Puttin=
g libtp in the path won&#39;t work: the sample does not look for it.<u></u>=
<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">dynamic=
: dynamic.o libtp.so<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Linking sample_$@:&quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -o sample=
_$@ $&lt; $(LDFLAGS) $(LIBDL)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;&nb=
sp;&nbsp; Use &#39;[LD_PRELOAD=3D./libtp.so] ./sample_$@&#39; to run sample=
_$@&quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d"><u></u>=
&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">#Compar=
e with the &#39;static.o&#39; target.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">dynamic=
.o: sample.c tp.h<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Compiling $@:&quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CPPFLAG=
S) $(LOCAL_CPPFLAGS) $(TP_DEFINE_DYNAMIC) \<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -c=
 -o $@ $&lt;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d"><u></u>=
&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">&nbsp;&nbs=
p; The case where the app isn&rsquo;t traced but the library it uses is tra=
ced should be a variation on this.&nbsp; I&rsquo;ll try it out sometime in =
the near future,
 but you should be able to figure it out from the above.&nbsp; Here&rsquo;s=
 a first guess (it may need $(LIBDL) alongside $(LIBUST)):<u></u><u></u></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">libtp.s=
o: libtp.o<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Packaging $@:&quot;<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -shared -=
Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed -L. -ltp \<u></u><u></u>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -o=
 $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIBUST) $&lt;<u></u>=
<u></u></span></p><div class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $@.$(SOV=
ERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MAJOR)<u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $@.$(SOV=
ERSION_MAJOR) $@<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
</div></div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">3) Is there any page which explains on why and how to use<s=
pan style=3D"color:#1f497d"><u></u><u></u></span></span></p><div class=3D""=
>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">TRACEPOINT_PROVIDER,&nbsp;TRACEPOINT_CREATE_PROBES,&nbsp;TR=
ACEPOINT_INCLUDE,&nbsp;</span><span lang=3D"EN-CA" style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">TRACEPOINT_DEFINE,&=
nbsp;TRACEPOINT_PROBE_DYNAMIC_LINKAGE</span><span lang=3D"EN-CA"><u></u><u>=
</u></span></p>

</div></div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1f497d"><u></u>=
&nbsp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">They&rsquo=
;re reasonably explained in the demonstration apps.&nbsp; I discuss them a =
little more in depth in the forthcoming LTTng Comprehensive User&rsquo;s Gu=
ide
 (I could send you a copy of the draft, as we&rsquo;ve just begun its first=
 review round).<u></u><u></u></span></p><div class=3D"">
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">my tp.h is, are there any errors in this?</span><span lang=
=3D"EN-CA"><u></u><u></u></span></p>
</div></div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#############</span><span lang=3D"EN-CA"><u></u><u></u></sp=
an></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">#undef TRACEPOINT_PROVIDER<u>=
</u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#define TRACEPOINT_PROVIDER sample_component<u></u><u></u><=
/span></p>
</div><div class=3D"">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"><u></u>&n=
bsp;<u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#undef TRACEPOINT_INCLUDE<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#define TRACEPOINT_INCLUDE &quot;./tp.h&quot;<u></u><u></u>=
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"><u></u>&n=
bsp;<u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ=
)<u></u><u></u></span></p>
</div>
</div><div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#define _TP_H<span style=3D"color:#1f497d"><u></u><u></u></=
span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">(Ideally, =
use _SAMPLE_COMPONENT_PROVIDER_H instead of _TP_H)<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#include &lt;lttng/tracepoint.h&gt;<u></u><u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">#ifdef __c=
plusplus<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">extern &qu=
ot;C&quot; {<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">#endif /* =
__cplusplus */<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">TRACEPOINT_EVENT(<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; sample_component,<u></u><u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; event,<u></u><u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; TP_ARGS(char *, text),<span style=3D"color:#1f497d"><u><=
/u><u></u></span></span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">(the compi=
ler may be happier with const char * instead)<u></u><u></u></span></p>
</div><div class=3D"">
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; TP_FIELDS(<u></u><u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ctf_string(message, text)<u>=
</u><u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; )<u></u><u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">)<u></u><=
u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">TRACEPOINT_LOGLEVEL(<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; sample_component,<u></u><u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; event,<u></u><u></u></span></p>

</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; TRACE_WARNING)<u></u><u></u></span></p>

</div>
</div><div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">#ifdef __cplusplus<u></u><u><=
/u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">}<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">#endif /* __cplusplus */<u></=
u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#endif /* _TP_H */<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#include &lt;lttng/tracepoint-event.h&gt;<span style=3D"col=
or:#1f497d"><u></u><u></u></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">(move #inc=
lude &lt;lttng/tracepoint-event.h&gt; inside of the
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ=
)</span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">)<u></u><u></u></span></p=
>

<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#############<u></u><u></u></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;</span><span lang=3D"EN-C=
A"><u></u>&nbsp;<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">Thanks,</span><span lang=3D"EN-CA"><u></u><u></u></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1f497d">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">Anand Neeli</span><span lang=3D"EN-CA"><u></u><u></u></span=
></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#1f497d"><u></u>&nbsp;<u></u></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">&nbsp;&nbs=
p; One key change I made to my sample applications is to remove the &ldquo;=
#define TRACEPOINT_DEFINE&rdquo; that precedes the &ldquo;#include &quot;tp=
.h&quot;&rdquo; line.&nbsp; I prefer
 to control that #define using a compiler -D option.&nbsp; It makes the mak=
efile clearer and resolves the problem of making sure there is just one mod=
ule that turns that #define on.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nb=
sp;<u></u></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">&nbsp;&nbs=
p;
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1f497d">Hope this helps.<u></u><u></u></span></p>=
<div class=3D"">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>&nbsp;<u></u></spa=
n></p>
<p class=3D"MsoNormal">Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC &nbsp;G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://--ESFSECEV-TY3011--------------------=
------------" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918=
V%20QSDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://--ESFSECEV-TY3011---------------------" target=3D"_bl=
ank">http://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<span style=3D"color:#1f=
497d"><u></u><u></u></span></p>
</div></div>
</div>
</div>
</div>

</blockquote></div><br></div>

--047d7bacb2e673cbf904f63d32a8--


--===============0738177814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0738177814==--
