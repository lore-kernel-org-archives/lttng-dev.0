From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: instrumenting shared library
Date: Fri, 4 Apr 2014 11:14:55 +0530
Message-ID: <CAM5kDqy62zjzLddVkRvg94jAxSCSN0uFqxmJL7RwN6XN31x0Jw__37431.2811451547$1396590356$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1823726637=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1WVww2-0006W2-1f
 for lttng-dev@lists.lttng.org; Fri, 04 Apr 2014 01:45:04 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so2955369pbc.2
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 22:44:56 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

--===============1823726637==
Content-Type: multipart/alternative; boundary=e89a8ff2555a7e7d7704f6310451

--e89a8ff2555a7e7d7704f6310451
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Daniel,
Thanks for your reply.
sorry for my ignorance but how are you generating libtp.so in your example?

1) Also will this solution scale if my binary depends on lots of libraries
which are instrumented?

2) i'm fine with linking statically, can we avoid LD_PRELOAD?

3) Is there any page which explains on why and how to use
TRACEPOINT_PROVIDER, TRACEPOINT_CREATE_PROBES, TRACEPOINT_INCLUDE,
TRACEPOINT_DEFINE, TRACEPOINT_PROBE_DYNAMIC_LINKAGE


my tp.h is, are there any errors in this?
#############
#define TRACEPOINT_PROVIDER sample_component

#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./tp.h"

#if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define _TP_H

#include <lttng/tracepoint.h>

TRACEPOINT_EVENT(
        sample_component,
        event,
        TP_ARGS(char *, text),
        TP_FIELDS(
                ctf_string(message, text)
        )
)
TRACEPOINT_LOGLEVEL(
        sample_component,
        event,
        TRACE_WARNING)

#endif /* _TP_H */
#include <lttng/tracepoint-event.h>
#############



Thanks,
Anand Neeli


On Thu, Apr 3, 2014 at 9:35 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> ----------------------------------------------------------------------
> Date: Thu, 3 Apr 2014 16:55:38 +0530
> From: Anand Neeli <anand.neeli@gmail.com>
> To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
>
> > I have a library which is instrumented and tracepoints are added. And I
> > have 2 binary's (or daemons) which try to include this library. (one
> binary
> > has instrumented code with tracepoints and other binary doesn't use
> > tracing)
> >
> > I found that i need to instrument the daemon which includes the
> > instrumented library for the code to compile.
> >
> > Can't I have a daemon (without tracing functionality) which can include
> an
> > instrumented library (i don't want to use tracing functionality in this
> > case)
> >
> > I'm only able to build if both library and daemon which includes it are
> > instrumented.
> >
> > Can anyone please give me more details on how to do this?
> > This is useful for huge code bases where you can selectively add tracin=
g
> > support to few libraries or daemons.
> >
> > Anand Neeli
>
>    It can be done.  An uninstrumented app can rely on an instrumented
> shared object; whether the latter produces lttng events then depends on
> whether or not the tracepoint provider shared object is loaded when the a=
pp
> is invoked (using LD_PRELOAD).
>
>    Here is sample_neeli.c:
> #####
> #include <stdio.h> //For printf
> #include <unistd.h>
>
> #include "cobject.h"
> int main(int argc, char **argv)
> {
>         int i =3D 0;
>         char themessage[20]; //Can hold up to "Hello World 9999999\0"
>
>         fprintf(stderr, "sample_neeli starting\n");
>         for (i =3D 0; i < 10000; i++) {
>                 //We either prepare themessage in this module, or rely on
> an
>                 //external shared object
>                 cobject_message(themessage, i);
>                 usleep(1);
>         }
>         fprintf(stderr, "sample_neeli done\n");
>         return 0;
> }
> #####
> cobject.c:
> #####
> #include <stdio.h> //For printf
> #include <unistd.h>
>
> #include "tp.h"
>
> void cobject_message(char *themessage, int i)
> {
>         tracepoint(sample_component, event, "cobject_message");
>         sprintf(themessage, "CObject %u", i);
> }
> #####
> cobject.h:
> #####
> extern void cobject_message(char *themessage, int i);
> #####
> The tracepoint provider code should be easy to guess.
>
> The relevant Makefile fragments:
> #####
> CC =3D gcc
> LIBDL =3D -ldl # On Linux
> #LIBDL =3D -lc # On BSD
> LOCAL_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)
> LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)
> SOFLAGS =3D -fPIC
> TP_DEFINE =3D -D TRACEPOINT_DEFINE
> TP_DEFINE_DYNAMIC =3D $(TP_DEFINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE
> SOVERSION_MAJOR =3D 1
> SOVERSION_MINOR =3D 0
>
> libcobject.so: libcobject.o
>         @echo "~~~~~~Packaging $@:"
>         $(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-needed=
 \
>            -o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $^
>         ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR)
> $@.$(SOVERSION_MAJOR)
>         ln -sf $@.$(SOVERSION_MAJOR) $@
>
> libcobject.o: cobject.c cobject.h tp.h
>         @echo "~~~~~~Compiling $@:"
>         $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(SOFLAGS)
> $(TP_DEFINE_DYNAMIC) \
>            -c -o $@ $<
>
> neeli_dynamic_lib:: neeli_dynamic_lib.o
>         @echo "~~~~~~Linking sample_$@:"
>         $(CC) -Wl,-no-as-needed -o $@ -L. -lcobject $^ $(LDFLAGS) \
>            $(LIBDL) -Wl,-rpath,'$$ORIGIN',--enable-new-dtags
>         @echo "   Use '[LD_PRELOAD=3D./libtp.so] ./$@' to run $@"
>
> neeli_dynamic_lib.o: sample_neeli.c cobject.h
>         @echo "~~~~~~Compiling $@:"
>         $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) -c -o $@ $<
> #####
>
>    Running './neeli_dynamic_lib' yields no events.  Running
> 'LD_PRELOAD=3D./libtp.so ./neeli_dynamic_lib' yields the libcobject.so ev=
ents.
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
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--e89a8ff2555a7e7d7704f6310451
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<div>Thanks for your reply.</div><div>sorry for =
my ignorance but how are you generating=A0<span style=3D"font-family:arial,=
sans-serif;font-size:13px">libtp.so in your example?</span></div><div><span=
 style=3D"font-family:arial,sans-serif"><br>
</span></div><div><font face=3D"arial, sans-serif">1) Also will this soluti=
on scale if my binary depends on lots of=A0libraries which are=A0instrument=
ed?</font><br></div><div><span style=3D"font-family:arial,sans-serif"><br><=
/span></div>
<div><font face=3D"arial, sans-serif">2) i&#39;m fine with linking statical=
ly, can we avoid LD_PRELOAD?=A0</font></div><div><font face=3D"arial, sans-=
serif"><br></font></div><div><font face=3D"arial, sans-serif">3) Is there a=
ny page which explains on why and how to use TRACEPOINT_PROVIDER,=A0TRACEPO=
INT_CREATE_PROBES,=A0TRACEPOINT_INCLUDE,=A0</font><span style=3D"font-famil=
y:arial,sans-serif;font-size:13px">TRACEPOINT_DEFINE,=A0</span><span style=
=3D"font-size:13px;font-family:arial,sans-serif">TRACEPOINT_PROBE_DYNAMIC_<=
/span><span style=3D"font-size:13px;font-family:arial,sans-serif">LINKAGE</=
span><span style=3D"font-family:arial,sans-serif;font-size:13px">=A0</span>=
</div>
<div><font face=3D"arial, sans-serif"><br></font></div><div><font face=3D"a=
rial, sans-serif"><br></font></div><div><font face=3D"arial, sans-serif">my=
 tp.h is, are there any errors in this?</font></div><div><font face=3D"aria=
l, sans-serif">#############</font></div>
<div><font face=3D"arial, sans-serif"><div>#define TRACEPOINT_PROVIDER samp=
le_component</div><div><br></div><div>#undef TRACEPOINT_INCLUDE</div><div>#=
define TRACEPOINT_INCLUDE &quot;./tp.h&quot;</div><div><br></div><div>#if !=
defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)</div>
<div>#define _TP_H</div><div><br></div><div>#include &lt;lttng/tracepoint.h=
&gt;</div><div><br></div><div>TRACEPOINT_EVENT(</div><div>=A0 =A0 =A0 =A0 s=
ample_component,</div><div>=A0 =A0 =A0 =A0 event,</div><div>=A0 =A0 =A0 =A0=
 TP_ARGS(char *, text),</div>
<div>=A0 =A0 =A0 =A0 TP_FIELDS(</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 c=
tf_string(message, text)</div><div>=A0 =A0 =A0 =A0 )</div><div>)</div><div>=
TRACEPOINT_LOGLEVEL(</div><div>=A0 =A0 =A0 =A0 sample_component,</div><div>=
=A0 =A0 =A0 =A0 event,</div><div>=A0 =A0 =A0 =A0 TRACE_WARNING)</div>
<div><br></div><div>#endif /* _TP_H */</div><div>#include &lt;lttng/tracepo=
int-event.h&gt;</div><div>#############</div></font></div><div><font face=
=3D"arial, sans-serif"><br></font></div><div><font face=3D"arial, sans-seri=
f"><br>
</font></div><div><font face=3D"arial, sans-serif"><br></font></div><div><f=
ont face=3D"arial, sans-serif">Thanks,</font></div><div><font face=3D"arial=
, sans-serif">Anand Neeli</font></div></div><div class=3D"gmail_extra"><br>=
<br>
<div class=3D"gmail_quote">On Thu, Apr 3, 2014 at 9:35 PM, Thibault, Daniel=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" t=
arget=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
----------------------------------------------------------------------<br>
Date: Thu, 3 Apr 2014 16:55:38 +0530<br>
From: Anand Neeli &lt;<a href=3D"mailto:anand.neeli@gmail.com">anand.neeli@=
gmail.com</a>&gt;<br>
To: &quot;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttn=
g.org</a>&quot; &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@=
lists.lttng.org</a>&gt;<br>
<br>
&gt; I have a library which is instrumented and tracepoints are added. And =
I<br>
&gt; have 2 binary&#39;s (or daemons) which try to include this library. (o=
ne binary<br>
<div class=3D"">&gt; has instrumented code with tracepoints and other binar=
y doesn&#39;t use<br>
&gt; tracing)<br>
&gt;<br>
&gt; I found that i need to instrument the daemon which includes the<br>
&gt; instrumented library for the code to compile.<br>
&gt;<br>
</div>&gt; Can&#39;t I have a daemon (without tracing functionality) which =
can include an<br>
<div class=3D"">&gt; instrumented library (i don&#39;t want to use tracing =
functionality in this<br>
&gt; case)<br>
&gt;<br>
&gt; I&#39;m only able to build if both library and daemon which includes i=
t are<br>
&gt; instrumented.<br>
&gt;<br>
&gt; Can anyone please give me more details on how to do this?<br>
&gt; This is useful for huge code bases where you can selectively add traci=
ng<br>
</div>&gt; support to few libraries or daemons.<br>
&gt;<br>
&gt; Anand Neeli<br>
<br>
=A0 =A0It can be done. =A0An uninstrumented app can rely on an instrumented=
 shared object; whether the latter produces lttng events then depends on wh=
ether or not the tracepoint provider shared object is loaded when the app i=
s invoked (using LD_PRELOAD).<br>

<br>
=A0 =A0Here is sample_neeli.c:<br>
#####<br>
#include &lt;stdio.h&gt; //For printf<br>
#include &lt;unistd.h&gt;<br>
<br>
#include &quot;cobject.h&quot;<br>
int main(int argc, char **argv)<br>
{<br>
=A0 =A0 =A0 =A0 int i =3D 0;<br>
=A0 =A0 =A0 =A0 char themessage[20]; //Can hold up to &quot;Hello World 999=
9999\0&quot;<br>
<br>
=A0 =A0 =A0 =A0 fprintf(stderr, &quot;sample_neeli starting\n&quot;);<br>
=A0 =A0 =A0 =A0 for (i =3D 0; i &lt; 10000; i++) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //We either prepare themessage in this modu=
le, or rely on an<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //external shared object<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cobject_message(themessage, i);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep(1);<br>
=A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 fprintf(stderr, &quot;sample_neeli done\n&quot;);<br>
=A0 =A0 =A0 =A0 return 0;<br>
}<br>
#####<br>
cobject.c:<br>
#####<br>
#include &lt;stdio.h&gt; //For printf<br>
#include &lt;unistd.h&gt;<br>
<br>
#include &quot;tp.h&quot;<br>
<br>
void cobject_message(char *themessage, int i)<br>
{<br>
=A0 =A0 =A0 =A0 tracepoint(sample_component, event, &quot;cobject_message&q=
uot;);<br>
=A0 =A0 =A0 =A0 sprintf(themessage, &quot;CObject %u&quot;, i);<br>
}<br>
#####<br>
cobject.h:<br>
#####<br>
extern void cobject_message(char *themessage, int i);<br>
#####<br>
The tracepoint provider code should be easy to guess.<br>
<br>
The relevant Makefile fragments:<br>
#####<br>
CC =3D gcc<br>
LIBDL =3D -ldl # On Linux<br>
#LIBDL =3D -lc # On BSD<br>
LOCAL_CPPFLAGS +=3D -I. $(AM_CPPFLAGS)<br>
LDFLAGS +=3D -L/usr/local/lib $(AM_LDFLAGS)<br>
SOFLAGS =3D -fPIC<br>
TP_DEFINE =3D -D TRACEPOINT_DEFINE<br>
TP_DEFINE_DYNAMIC =3D $(TP_DEFINE) -D TRACEPOINT_PROBE_DYNAMIC_LINKAGE<br>
SOVERSION_MAJOR =3D 1<br>
SOVERSION_MINOR =3D 0<br>
<br>
libcobject.so: libcobject.o<br>
=A0 =A0 =A0 =A0 @echo &quot;~~~~~~Packaging $@:&quot;<br>
=A0 =A0 =A0 =A0 $(CC) -shared -Wl,-soname,$@.$(SOVERSION_MAJOR) -Wl,-no-as-=
needed \<br>
=A0 =A0 =A0 =A0 =A0 =A0-o $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $^<br>
=A0 =A0 =A0 =A0 ln -sf $@.$(SOVERSION_MAJOR).$(SOVERSION_MINOR) $@.$(SOVERS=
ION_MAJOR)<br>
=A0 =A0 =A0 =A0 ln -sf $@.$(SOVERSION_MAJOR) $@<br>
<br>
libcobject.o: cobject.c cobject.h tp.h<br>
=A0 =A0 =A0 =A0 @echo &quot;~~~~~~Compiling $@:&quot;<br>
=A0 =A0 =A0 =A0 $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(SOFLAGS) $(TP_DEFINE_=
DYNAMIC) \<br>
=A0 =A0 =A0 =A0 =A0 =A0-c -o $@ $&lt;<br>
<br>
neeli_dynamic_lib:: neeli_dynamic_lib.o<br>
=A0 =A0 =A0 =A0 @echo &quot;~~~~~~Linking sample_$@:&quot;<br>
=A0 =A0 =A0 =A0 $(CC) -Wl,-no-as-needed -o $@ -L. -lcobject $^ $(LDFLAGS) \=
<br>
=A0 =A0 =A0 =A0 =A0 =A0$(LIBDL) -Wl,-rpath,&#39;$$ORIGIN&#39;,--enable-new-=
dtags<br>
=A0 =A0 =A0 =A0 @echo &quot; =A0 Use &#39;[LD_PRELOAD=3D./libtp.so] ./$@&#3=
9; to run $@&quot;<br>
<br>
neeli_dynamic_lib.o: sample_neeli.c cobject.h<br>
=A0 =A0 =A0 =A0 @echo &quot;~~~~~~Compiling $@:&quot;<br>
=A0 =A0 =A0 =A0 $(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) -c -o $@ $&lt;<br>
#####<br>
<br>
=A0 =A0Running &#39;./neeli_dynamic_lib&#39; yields no events. =A0Running &=
#39;LD_PRELOAD=3D./libtp.so ./neeli_dynamic_lib&#39; yields the libcobject.=
so events.<br>
<br>
Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC =A0G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</blockquote></div><br></div>

--e89a8ff2555a7e7d7704f6310451--


--===============1823726637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1823726637==--
