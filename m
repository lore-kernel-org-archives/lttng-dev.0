From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: instrumenting shared library
Date: Fri, 4 Apr 2014 14:43:02 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599315B__26656.5019418069$1396622691$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0172979133=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WW5Kz-0001Nb-0z
 for lttng-dev@lists.lttng.org; Fri, 04 Apr 2014 10:43:28 -0400
In-Reply-To: <CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw@mail.gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0172979133==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_48CF5AC71E61DB46B70D0F388054EFFD3599315BVALE02valcartie_"

--_000_48CF5AC71E61DB46B70D0F388054EFFD3599315BVALE02valcartie_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

De : Anand Neeli [mailto:anand.neeli@gmail.com]
Envoy=E9 : 4 avril 2014 01:45

> Thanks for your reply.
> Sorry for my ignorance but how are you generating libtp.so in your exampl=
e?

Non-boilerplate parts are in red.

tp.c:
#####
/*
* Defining macro creates the code objects of the traceprobes.
* Must be done only once per file (this #define controls tracepoint.h and
* tracepoint-event.h).
*/
#define TRACEPOINT_CREATE_PROBES
/*
* The header containing our TRACEPOINT_EVENTs.
*/
#include "tp.h"
#####
tp.h:
#####
#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER sample_component
/*
* include file (this files's name)
*/
#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./tp.h"
/*
* Add this precompiler conditional to ensure the tracepoint event generatio=
n
* can include this file more than once.
*/
#if !defined(_SAMPLE_COMPONENT_PROVIDER_H) || defined(TRACEPOINT_HEADER_MUL=
TI_READ)
#define _SAMPLE_COMPONENT_PROVIDER_H
/*
* Add this to allow programs to call "tracepoint(...)".
* This #include must not be within an extern "C" block; if it is,
* C++ instrumentation will fail when SystemTap is also installed.
* (This may have been fixed since I wrote this)
*/
#include <lttng/tracepoint.h>
/*
* Add this macro and its matching element to make sure the program
* works in C++.
*/
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*
* The following tracepoint event writes a message (C string) into the
* field "message" of the trace event "event" in the provider
* "sample_component" in other words:
*
*    sample_component:event:message =3D text.
*/
TRACEPOINT_EVENT(
            /*
            * provider name, not a variable but a string starting with a le=
tter
            * and containing either letters, numbers or underscores.
            * Needs to be the same as TRACEPOINT_PROVIDER
            */
            sample_component,
            /*
            * tracepoint name, same format as sample provider. Does not nee=
d to be
            * declared before. in this case the name is "event"
            */
            event,
            /*
            * TP_ARGS macro contains the arguments passed for the tracepoin=
t.
            * It is in the following format:
            *                     TP_ARGS( type1, name1, type2, name2, ... =
type10, name10)
            * where there can be from zero to ten elements.
            * "typeN" is the datatype, such as int, struct or double **.
            * "name" is the variable name (in "int myInt" the name would be=
 "myInt")
            *                     TP_ARGS() is valid (no arguments)
            *                     TP_ARGS( void ) is valid too
            */
            TP_ARGS(const char *, text),
            /*
            * TP_FIELDS describes how to write the fields of the trace even=
t.
            * You can use the args here
            */
            TP_FIELDS(
            /*
            * The ctf_string macro takes a C string and writes it into a fi=
eld
            * named "message"
            */
                        ctf_string(message, text)
            )
)
/*
* Trace loglevel, shows the level of the trace event. It can be TRACE_EMERG=
,
* TRACE_ALERT, TRACE_CRIT, TRACE_ERR, TRACE_WARNING, TRACE_INFO, etc.
* If this is not set, TRACE_DEFAULT is assumed.
* The first two arguments identify the tracepoint.
* See details in <lttng/tracepoint.h> line 347
*/
TRACEPOINT_LOGLEVEL(
       /*
        * The provider name, must be the same as the provider name in the
        * TRACEPOINT_EVENT and as TRACEPOINT_PROVIDER above.
        */
            sample_component,
       /*
        * The tracepoint name, must be the same as the tracepoint name in t=
he
        * TRACEPOINT_EVENT
        */
            event,
       /*
        * The tracepoint loglevel. WARNING: Some levels are abbreviated and
        * others are not, please see <lttng/tracepoint.h>
        */
            TRACE_WARNING
)
(more tracepoints...)

/*
* Add this macro and its matching element to make sure the program
* works in C++.
*/
#ifdef __cplusplus
}
#endif /* __cplusplus */
/*
* Add this after defining the tracepoint events to expand the macros.
*/
#include <lttng/tracepoint-event.h>
#endif /* _SAMPLE_COMPONENT_PROVIDER_H */
#####
The relevant Makefile fragments:
#####
CC =3D gcc
LIBUST =3D -llttng-ust
LOCAL_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)
LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)
SOFLAGS =3D -fPIC
SOVERSION_MAJOR =3D 1
SOVERSION_MINOR =3D 0

libtp.so: libtp.o
            @echo "~~~~~~Packaging $@:"
            $(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-need=
ed \
               -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIB=
UST) $<
            ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_=
MAJOR)
            ln -sf $@.$(SOVERSION_MAJOR) $@

libtp.o: tp.c tp.h
            @echo "~~~~~~Compiling $@:"
            $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(SOFLAGS) -c -o $@ $<

> 1) Also will this solution scale if my binary depends on lots of librarie=
s which are instrumented?

Sure.  I'd expect linear scaling.  Each library, upon being loaded, looks f=
or its tracepoint provider and turns its tracepoints off if they're not fou=
nd.

> 2) i'm fine with linking statically, can we avoid LD_PRELOAD?

Besides the LD_PRELOAD technique, you could also use LD_LIBRARY_PATH, but t=
hat works only if the application statically includes the tracepoint provid=
er (I suppose it would likewise work for an instrumented shared object only=
 if it statically includes the tracepoint provider).

You could also add "-Wl,-rpath,'$$ORIGIN'" to the linker call to add an RPA=
TH tag to the application (or shared object).  This makes it look for its d=
ependencies in its starting directory ($ORIGIN).  RPATH is, unlike RUNPATH,=
 applicable to libraries as well: a library with an RPATH tag will look the=
re for its dependencies; failing its own RPATH, it will use its executable'=
s RPATH.

Finally, you can dynamically include the tracepoint provider (libtp) as a d=
ependency.  The application (sample_static_aware) is then statically aware =
of libtp and won't run without it.  The application (sample_dynamic) can al=
ternately dynamically include the tracepoint provider without static awaren=
ess.  Here's how it's done:

LIBDL =3D -ldl # On Linux
#LIBDL =3D -lc # On BSD
TP_DEFINE =3D -D TRACEPOINT_DEFINE
TP_DEFINE_DYNAMIC =3D $(TP_DEFINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE

#(the inclusion of a libtp NEEDED tag requires "-no-as-needed -ltp").
#Note that "-L. -ltp", when used, should appear before $(LDFLAGS) $(LIBDL).
static_aware: static.o libtp.so
            @echo "~~~~~~Linking sample_$@:"
#          $(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $< $(LDFLAGS) $(LI=
BDL) \
#             -Wl,-rpath,'$$ORIGIN',--enable-new-dtags
            $(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $< $(LDFLAGS) $(L=
IBDL)
            @echo "   Use 'LD_PRELOAD=3D./libtp.so ./sample_$@' to run samp=
le_$@"

static.o: sample.c tp.h
            @echo "~~~~~~Compiling $@:"
            $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE) -c -o $@ $<

#If not preloaded, the sample application runs but won't be traceable.
#Putting libtp in the path won't work: the sample does not look for it.
dynamic: dynamic.o libtp.so
            @echo "~~~~~~Linking sample_$@:"
            $(CC) -o sample_$@ $< $(LDFLAGS) $(LIBDL)
            @echo "   Use '[LD_PRELOAD=3D./libtp.so] ./sample_$@' to run sa=
mple_$@"

#Compare with the 'static.o' target.
dynamic.o: sample.c tp.h
            @echo "~~~~~~Compiling $@:"
            $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(TP_DEFINE_DYNAMIC) \
               -c -o $@ $<

   The case where the app isn't traced but the library it uses is traced sh=
ould be a variation on this.  I'll try it out sometime in the near future, =
but you should be able to figure it out from the above.  Here's a first gue=
ss (it may need $(LIBDL) alongside $(LIBUST)):

libtp.so: libtp.o
            @echo "~~~~~~Packaging $@:"
            $(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-need=
ed -L. -ltp \
               -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIB=
UST) $<
            ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_=
MAJOR)
            ln -sf $@.$(SOVERSION_MAJOR) $@


> 3) Is there any page which explains on why and how to use
> TRACEPOINT_PROVIDER, TRACEPOINT_CREATE_PROBES, TRACEPOINT_INCLUDE, TRACEP=
OINT_DEFINE, TRACEPOINT_PROBE_DYNAMIC_LINKAGE

They're reasonably explained in the demonstration apps.  I discuss them a l=
ittle more in depth in the forthcoming LTTng Comprehensive User's Guide (I =
could send you a copy of the draft, as we've just begun its first review ro=
und).

> my tp.h is, are there any errors in this?
> #############

#undef TRACEPOINT_PROVIDER

> #define TRACEPOINT_PROVIDER sample_component
>
> #undef TRACEPOINT_INCLUDE
> #define TRACEPOINT_INCLUDE "./tp.h"
>
> #if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
> #define _TP_H

(Ideally, use _SAMPLE_COMPONENT_PROVIDER_H instead of _TP_H)

> #include <lttng/tracepoint.h>

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

> TRACEPOINT_EVENT(
>        sample_component,
>        event,
>        TP_ARGS(char *, text),

(the compiler may be happier with const char * instead)

>        TP_FIELDS(
>                ctf_string(message, text)
>        )
>)
> TRACEPOINT_LOGLEVEL(
>        sample_component,
>        event,
>        TRACE_WARNING)

#ifdef __cplusplus
}
#endif /* __cplusplus */

> #endif /* _TP_H */
> #include <lttng/tracepoint-event.h>

(move #include <lttng/tracepoint-event.h> inside of the #if !defined(_TP_H)=
 || defined(TRACEPOINT_HEADER_MULTI_READ))

> #############
>
> Thanks,
> Anand Neeli

   One key change I made to my sample applications is to remove the "#defin=
e TRACEPOINT_DEFINE" that precedes the "#include "tp.h"" line.  I prefer to=
 control that #define using a compiler -D option.  It makes the makefile cl=
earer and resolves the problem of making sure there is just one module that=
 turns that #define on.

   Hope this helps.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ<--ESFS=
ECEV-TY3011-------------------------------->>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/<--ESFSECEV-TY3011------------------=
--->>

--_000_48CF5AC71E61DB46B70D0F388054EFFD3599315BVALE02valcartie_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Texte de bulles Car";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.TextedebullesCar
	{mso-style-name:"Texte de bulles Car";
	mso-style-priority:99;
	mso-style-link:"Texte de bulles";
	font-family:"Tahoma","sans-serif";
	mso-fareast-language:FR-CA;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"FR-CA" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><b><span lang=3D"EN-CA" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">De&nbsp;:</span></b><s=
pan lang=3D"EN-CA" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;=
,&quot;sans-serif&quot;"> Anand Neeli [mailto:anand.neeli@gmail.com]
<br>
<b>Envoy=E9&nbsp;:</b> 4 avril 2014 01:45<br>
<br>
</span><span lang=3D"EN-CA"><o:p></o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">Thanks for your reply.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&gt; </=
span><span lang=3D"EN-CA">Sorry for my ignorance but how are you generating=
&nbsp;</span><span lang=3D"EN-CA" style=3D"font-size:10.0pt;font-family:&qu=
ot;Arial&quot;,&quot;sans-serif&quot;">libtp.so in your example?</span><spa=
n lang=3D"EN-CA"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Non-boiler=
plate parts are in
</span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,&quot;sans-serif&quot;;color:red">red</span><span lang=3D"EN-CA"=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:#1F497D">.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:red">tp</span><s=
pan lang=3D"EN-CA">.c:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#####<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Defining macro creates the co=
de objects of the traceprobes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Must be done only once per fi=
le (this #define controls tracepoint.h and<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* tracepoint-event.h).<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#define TRACEPOINT_CREATE_PROBE=
S<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* The header containing our TRA=
CEPOINT_EVENTs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#include &quot;<span style=3D"c=
olor:red">tp</span>.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#####<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:red">tp</span><s=
pan lang=3D"EN-CA">.h:<br>
#####<br>
#undef TRACEPOINT_PROVIDER<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#define TRACEPOINT_PROVIDER <sp=
an style=3D"color:red">
sample_component</span><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* include file (this files's na=
me)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#undef TRACEPOINT_INCLUDE<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#define TRACEPOINT_INCLUDE &quo=
t;./<span style=3D"color:red">tp</span>.h&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this precompiler conditio=
nal to ensure the tracepoint event generation<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* can include this file more th=
an once.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#if !defined(_<span style=3D"co=
lor:red">SAMPLE_COMPONENT</span>_PROVIDER_H) || defined(TRACEPOINT_HEADER_M=
ULTI_READ)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#define _<span style=3D"color:r=
ed">SAMPLE_COMPONENT</span>_PROVIDER_H<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this to allow programs to=
 call &quot;tracepoint(...)&quot;.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* This #include must not be wit=
hin an extern &quot;C&quot; block; if it is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* C&#43;&#43; instrumentation w=
ill fail when SystemTap is also installed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* (This may have been fixed sin=
ce I wrote this)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#include &lt;lttng/tracepoint.h=
&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this macro and its matchi=
ng element to make sure the program<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* works in C&#43;&#43;.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#ifdef __cplusplus<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">extern &quot;C&quot; {<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#endif /* __cplusplus */<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* The following tracepoint even=
t writes a message (C string) into the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* field &quot;message&quot; of =
the trace event &quot;event&quot; in the provider<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* &quot;sample_component&quot; =
in other words:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*&nbsp;&nbsp;&nbsp; sample_comp=
onent:event:message =3D text.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">TRACEPOINT_EVENT(<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * provider name, not a variable but a s=
tring starting with a letter<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and containing either letters, number=
s or underscores.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Needs to be the same as TRACEPOINT_PR=
OVIDER<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">sample_compon=
ent</span>,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * tracepoint name, same format as sampl=
e provider. Does not need to be<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * declared before. in this case the nam=
e is &quot;event&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">event</span>,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TP_ARGS macro contains the arguments =
passed for the tracepoint.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * It is in the following format:<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; TP_ARGS( type1, name1, type2, name2, ... type10, name10)<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * where there can be from zero to ten e=
lements.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &quot;typeN&quot; is the datatype, su=
ch as int, struct or double **.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &quot;name&quot; is the variable name=
 (in &quot;int myInt&quot; the name would be &quot;myInt&quot;)<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; TP_ARGS() is valid (no arguments)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; TP_ARGS( void ) is valid too<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_ARGS(<span style=3D"color:red">const=
 char *, text</span>),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TP_FIELDS describes how to write the =
fields of the trace event.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * You can use the args here<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TP_FIELDS(<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The ctf_string macro takes a C string=
 and writes it into a field<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * named &quot;message&quot;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">
ctf_string(message, text)<o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Trace loglevel, shows the lev=
el of the trace event. It can be TRACE_EMERG,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* TRACE_ALERT, TRACE_CRIT, TRAC=
E_ERR, TRACE_WARNING, TRACE_INFO, etc.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* If this is not set, TRACE_DEF=
AULT is assumed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* The first two arguments ident=
ify the tracepoint.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* See details in &lt;lttng/trac=
epoint.h&gt; line 347<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">TRACEPOINT_LOGLEVEL(<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * The provider name, must be the same as the provider name in t=
he<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * TRACEPOINT_EVENT and as TRACEPOINT_PROVIDER above.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">sample_compon=
ent</span>,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * The tracepoint name, must be the same as the tracepoint name =
in the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * TRACEPOINT_EVENT<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">event</span>,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * The tracepoint loglevel. WARNING: Some levels are abbreviated=
 and<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; * others are not, please see &lt;lttng/tracepoint.h&gt;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=3D"color:red">TRACE_WARNING=
<o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">(more tracepoints&#8230;)<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this macro and its matchi=
ng element to make sure the program<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* works in C&#43;&#43;.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#ifdef __cplusplus<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#endif /* __cplusplus */<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">* Add this after defining the t=
racepoint events to expand the macros.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#include &lt;lttng/tracepoint-e=
vent.h&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#endif /* _<span style=3D"color=
:red">SAMPLE_COMPONENT</span>_PROVIDER_H */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#####<br>
The relevant Makefile fragments:<br>
#####<br>
CC =3D gcc<br>
<span style=3D"color:#1F497D">LIBUST =3D -llttng-ust<o:p></o:p></span></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">LOCAL_CPPFLAGS &#43;=3D -I. $(A=
M_CPPFLAGS)<br>
LDFLAGS &#43;=3D -L/usr/local/lib $(AM_LDFLAGS)<br>
SOFLAGS =3D -fPIC<br>
SOVERSION_MAJOR =3D 1<br>
SOVERSION_MINOR =3D 0<br>
<br>
<span style=3D"color:#1F497D">libtp.so: libtp.o<o:p></o:p></span></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Packaging $@:&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -shared -=
Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -o=
 $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIBUST) $&lt;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $@.$(SOV=
ERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MAJOR)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $@.$(SOV=
ERSION_MAJOR) $@<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">libtp.o=
: tp.c tp.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Compiling $@:&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CPPFLAG=
S) $(LOCAL_CPPFLAGS) $(SOFLAGS) -c -o $@ $&lt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><br>
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">1) Also will this solution scale if my binary depends on lo=
ts of&nbsp;libraries which are&nbsp;instrumented?</span><span lang=3D"EN-CA=
"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Sure.&nbsp=
; I&#8217;d expect linear scaling.&nbsp; Each library, upon being loaded, l=
ooks for its tracepoint provider and turns its tracepoints off if they&#821=
7;re
 not found.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">2) i'm fine with linking statically, can we avoid LD_PRELOA=
D?<span style=3D"color:#1F497D"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">Besides the LD_PRELOAD techni=
que, you could also use LD_LIBRARY_PATH, but that works only if the applica=
tion statically includes the tracepoint provider (I suppose
 it would likewise work for an instrumented shared object only if it static=
ally includes the tracepoint provider).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">You could also add &quot;-Wl,=
-rpath,'$$ORIGIN'&quot; to the linker call to add an RPATH tag to the appli=
cation (or shared object). &nbsp;This makes it look for its dependencies
 in its starting directory ($ORIGIN). &nbsp;RPATH is, unlike RUNPATH, appli=
cable to libraries as well: a library with an RPATH tag will look there for=
 its dependencies; failing its own RPATH, it will use its executable's RPAT=
H.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">Finally, you can dynamically =
include the tracepoint provider (libtp) as a dependency.&nbsp; The applicat=
ion (sample_static_aware) is then statically aware of libtp and
 won't run without it.&nbsp; The application (sample_dynamic) can alternate=
ly dynamically include the tracepoint provider
<i>without</i> static awareness.&nbsp; Here&#8217;s how it&#8217;s done:<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">LIBDL =3D -ldl # On Linux<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">#LIBDL =3D -lc # On BSD<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">TP_DEFINE =3D -D TRACEPOINT_D=
EFINE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">TP_DEFINE_DYNAMIC =3D $(TP_DE=
FINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">#(the inclusion of a libtp NE=
EDED tag requires &quot;-no-as-needed -ltp&quot;).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">#Note that &quot;-L. -ltp&quo=
t;, when used, should appear before $(LDFLAGS) $(LIBDL).<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">static_aware: static.o libtp.=
so<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~~~~Linking sample_$@:&=
quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">#&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -Wl,-no-as-needed -o sample_$@ -L. -ltp $&=
lt; $(LDFLAGS) $(LIBDL) \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">#&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -Wl,-rpath,'$$ORIGIN',--enable-new-=
dtags<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -Wl,-no-as-needed -o sample_$@ =
-L. -ltp $&lt; $(LDFLAGS) $(LIBDL)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;&nbsp;&nbsp; Use 'LD_PREL=
OAD=3D./libtp.so ./sample_$@' to run sample_$@&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">static.o: sample.c tp.h<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~~~~Compiling $@:&quot;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $=
(TP_DEFINE) -c -o $@ $&lt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">#If not=
 preloaded, the sample application runs but won't be traceable.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">#Puttin=
g libtp in the path won't work: the sample does not look for it.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">dynamic=
: dynamic.o libtp.so<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Linking sample_$@:&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -o sample=
_$@ $&lt; $(LDFLAGS) $(LIBDL)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;&nb=
sp;&nbsp; Use '[LD_PRELOAD=3D./libtp.so] ./sample_$@' to run sample_$@&quot=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">#Compar=
e with the 'static.o' target.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">dynamic=
.o: sample.c tp.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Compiling $@:&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) $(CPPFLAG=
S) $(LOCAL_CPPFLAGS) $(TP_DEFINE_DYNAMIC) \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -c=
 -o $@ $&lt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbs=
p; The case where the app isn&#8217;t traced but the library it uses is tra=
ced should be a variation on this.&nbsp; I&#8217;ll try it out sometime in =
the near future,
 but you should be able to figure it out from the above.&nbsp; Here&#8217;s=
 a first guess (it may need $(LIBDL) alongside $(LIBUST)):<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">libtp.s=
o: libtp.o<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @echo &quot;~~~=
~~~Packaging $@:&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(CC) -shared -=
Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed -L. -ltp \<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; -o=
 $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $(LDFLAGS) $(LIBUST) $&lt;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $@.$(SOV=
ERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERSION_MAJOR)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ln -sf $@.$(SOV=
ERSION_MAJOR) $@<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">3) Is there any page which explains on why and how to use<s=
pan style=3D"color:#1F497D"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">TRACEPOINT_PROVIDER,&nbsp;TRACEPOINT_CREATE_PROBES,&nbsp;TR=
ACEPOINT_INCLUDE,&nbsp;</span><span lang=3D"EN-CA" style=3D"font-size:10.0p=
t;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">TRACEPOINT_DEFINE,&=
nbsp;TRACEPOINT_PROBE_DYNAMIC_LINKAGE</span><span lang=3D"EN-CA"><o:p></o:p=
></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">They&#8217=
;re reasonably explained in the demonstration apps.&nbsp; I discuss them a =
little more in depth in the forthcoming LTTng Comprehensive User&#8217;s Gu=
ide
 (I could send you a copy of the draft, as we&#8217;ve just begun its first=
 review round).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">my tp.h is, are there any errors in this?</span><span lang=
=3D"EN-CA"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#############</span><span lang=3D"EN-CA"><o:p></o:p></span>=
</p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">#undef TRACEPOINT_PROVIDER<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#define TRACEPOINT_PROVIDER sample_component<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"><o:p>&nbs=
p;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#undef TRACEPOINT_INCLUDE<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#define TRACEPOINT_INCLUDE &quot;./tp.h&quot;<o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"><o:p>&nbs=
p;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ=
)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#define _TP_H<span style=3D"color:#1F497D"><o:p></o:p></spa=
n></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">(Ideally, =
use _SAMPLE_COMPONENT_PROVIDER_H instead of _TP_H)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#include &lt;lttng/tracepoint.h&gt;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">#ifdef __c=
plusplus<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">extern &qu=
ot;C&quot; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">#endif /* =
__cplusplus */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">TRACEPOINT_EVENT(<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; sample_component,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; event,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; TP_ARGS(char *, text),<span style=3D"color:#1F497D"><o:p=
></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">(the compi=
ler may be happier with const char * instead)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; TP_FIELDS(<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ctf_string(message, text)<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; )<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">)<o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">TRACEPOINT_LOGLEVEL(<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; sample_component,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; event,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A" style=3D"font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&nbsp; &n=
bsp; &nbsp; &nbsp; TRACE_WARNING)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">#ifdef __cplusplus<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">#endif /* __cplusplus */<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#endif /* _TP_H */<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#include &lt;lttng/tracepoint-event.h&gt;<span style=3D"col=
or:#1F497D"><o:p></o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">(move #inc=
lude &lt;lttng/tracepoint-event.h&gt; inside of the
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ=
)</span><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">#############<o:p></o:p></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;</span><span lang=3D"EN-C=
A"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">Thanks,</span><span lang=3D"EN-CA"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-family:&quot;Aria=
l&quot;,&quot;sans-serif&quot;;color:#1F497D">&gt;
</span><span lang=3D"EN-CA" style=3D"font-family:&quot;Arial&quot;,&quot;sa=
ns-serif&quot;">Anand Neeli</span><span lang=3D"EN-CA"><o:p></o:p></span></=
p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbs=
p; One key change I made to my sample applications is to remove the &#8220;=
#define TRACEPOINT_DEFINE&#8221; that precedes the &#8220;#include &quot;tp=
.h&quot;&#8221; line.&nbsp; I prefer
 to control that #define using a compiler -D option.&nbsp; It makes the mak=
efile clearer and resolves the problem of making sure there is just one mod=
ule that turns that #define on.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">&nbsp;&nbs=
p;
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;;color:#1F497D">Hope this helps.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
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
NAC : 918V QSDJ &lt;<a href=3D"--ESFSECEV-TY3011---------------------------=
-----" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20QSD=
J</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"--ESFSECEV-TY3011---------------------" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<span style=3D"color:#1F497D"><=
o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_48CF5AC71E61DB46B70D0F388054EFFD3599315BVALE02valcartie_--


--===============0172979133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0172979133==--
