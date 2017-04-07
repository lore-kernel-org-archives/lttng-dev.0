From: Rocky Dunlap <rsdunlapiv@gmail.com>
Subject: Re: Explicit setting of UUID with ctf writer
Date: Fri, 7 Apr 2017 16:02:37 -0600
Message-ID: <CAK-w0Ddo6hJsPoZLh8VdgqOcBb6sUsj6FkHrtv9UBkrf5gKDEg__34884.3305990615$1491602592$gmane$org@mail.gmail.com>
References: <CAK-w0DdKCrHuGakFkWM1z4sXW10oyxmxdGXezyXb+DutEieeMA@mail.gmail.com>
 <CAB4xu_2fHsZa-LqHA-VVdDN1X8ej2_W6-JvjHk2E0C83ftKLYQ@mail.gmail.com>
 <CAK-w0DfawxkijMiUCZzLSApkTHCLH06N6QayjaSh_OSJQwEQjQ@mail.gmail.com>
 <CAB4xu_3_OfLz_CNiPMU7E8iZtS_R1M9HfDb-2nxe0jrb1QU9Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8590474865454009961=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x234.google.com (mail-ua0-x234.google.com
 [IPv6:2607:f8b0:400c:c08::234])
 by lists.lttng.org (Postfix) with ESMTPS id 3w0D9S5yt2zkx4
 for <lttng-dev@lists.lttng.org>; Fri,  7 Apr 2017 22:03:24 +0000 (UTC)
Received: by mail-ua0-x234.google.com with SMTP id 49so2549400uau.2
 for <lttng-dev@lists.lttng.org>; Fri, 07 Apr 2017 15:02:59 -0700 (PDT)
In-Reply-To: <CAB4xu_3_OfLz_CNiPMU7E8iZtS_R1M9HfDb-2nxe0jrb1QU9Zw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8590474865454009961==
Content-Type: multipart/alternative; boundary=f403045f286ad38441054c9ac962

--f403045f286ad38441054c9ac962
Content-Type: text/plain; charset=UTF-8

Phil,

Thanks very much for your suggestion.  I tried it and it does work exactly
as you say, but I agree it is a bit ugly and non-portable. It is nice to
have a temporary option while awaiting babeltrace 2.0.

Using the command line to combine traces is perhaps the cleaner option.
However, it does not appear that I can output in CTF format with this
version:

$ babeltrace -w combined -o ctf PET1 PET2
[error] Only CTF traces with a single clock description are supported by
this babeltrace version.
[error] Opening CTF traces for output is not supported yet.
Error opening trace "combined" for writing.

Thanks,
Rocky

On Fri, Apr 7, 2017 at 3:03 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Fri, Apr 7, 2017 at 4:15 PM, Rocky Dunlap <rsdunlapiv@gmail.com> wrote:
> > Phil,
> >
> > This relates to my previous question about multi-process tracing. The
> > workaround I am attempting is to have each process write its own trace
> with
> > a single stream, but then to pull all the stream files together into a
> > single trace with one metadata file. For this reason the uuids would
> need to
> > match.
> >
> > Do you think this will work?
>
> First question: why not having multiple traces (multiple directories
> with multiple `metadata` files)? babeltrace(1) and Trace Compass can
> merge them easily.
>
> In the meantime, if you really want a single trace, here's a hack.
> Please don't tell anyone that I suggested this. Choose any generated
> `metadata` file which contains all the `event` blocks that you need.
> Note that, across all your traces, the order in which you add the event
> class objects to your single stream class object needs to remain the
> same so that they have the same IDs whatever the trace. Then, this
> works, as long as you use the Babeltrace 1.5.2 release:
>
>     #include <babeltrace/ctf-writer/writer.h>
>     #include <string.h>
>     #include <assert.h>
>
>     typedef unsigned char uuid_t[16];
>
>     struct bt_ref {
>         long count;
>         void *release;
>     };
>
>     struct bt_object {
>         struct bt_ref ref_count;
>         void *release;
>         void *parent;
>     };
>
>     struct bt_ctf_trace {
>         struct bt_object base;
>         int frozen;
>         unsigned char uuid[16];
>     };
>
>     struct bt_ctf_writer {
>         struct bt_object base;
>         int frozen;
>         struct bt_ctf_trace *trace;
>     };
>
>     int main(void)
>     {
>         struct bt_ctf_writer *writer;
>         const unsigned char my_custom_uuid[16] = {
>             0xb3, 0x38, 0x4d, 0x7b, 0x77, 0x8a, 0x4f, 0xf0,
>             0x99, 0xbd, 0x43, 0x54, 0x9e, 0xc0, 0x54, 0x1b,
>         };
>
>         writer = bt_ctf_writer_create("/tmp/my-trace");
>         assert(writer);
>         memcpy(writer->trace->uuid, my_custom_uuid, 16);
>
>         /* do stuff with writer here */
>
>         bt_ctf_writer_put(writer);
>         return 0;
>     }
>
> Again, I don't condone this: it's not portable, it's ugly, but it does
> what you ask.
>
> Another hack: search the byte sequences c1 fc 1f c1 (big endian) or
> c1 1f fc c1 (little endian) in all your stream files and replace the
> _next_ 16 bytes with your favorite UUID. Also replace the `uuid`
> attribute in the chosen `metadata` file with the canonical
> representation of your favorite UUID.
>
> Phil
>
> >
> > Rocky
> >
> > On Apr 7, 2017 1:57 PM, "Philippe Proulx" <eeppeliteloop@gmail.com>
> wrote:
> >>
> >> On Fri, Apr 7, 2017 at 3:18 PM, Rocky Dunlap <rsdunlapiv@gmail.com>
> wrote:
> >> > Is it possible to explicitly set a uuid for a trace using the
> Babeltrace
> >> > CTF
> >> > writer?  I did not see a straightforward way to do it with the API.
> >>
> >> It's not possible as of Babeltrace 1. We'll add trace UUID accessors to
> >> the upcoming Babeltrace 2 API.
> >>
> >> That said, may I ask you why you need this? Two different CTF traces
> >> should not share the same UUID.
> >>
> >> Phil
> >>
> >> >
> >> > Rocky
> >> >
> >> > _______________________________________________
> >> > lttng-dev mailing list
> >> > lttng-dev@lists.lttng.org
> >> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >> >
>

--f403045f286ad38441054c9ac962
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Phil,</div><div><br></div><div>Thanks very much for y=
our suggestion.=C2=A0 I tried it and it does work exactly as you say, but I=
 agree it is a bit ugly and non-portable. It is nice to have a temporary op=
tion while awaiting babeltrace 2.0.</div><div><br></div><div>Using the comm=
and line to combine traces is perhaps the cleaner option.=C2=A0 However, it=
 does not appear that I can output in CTF format with this version:</div><d=
iv><br></div><div>$ babeltrace -w combined -o ctf PET1 PET2</div><div>[erro=
r] Only CTF traces with a single clock description are supported by this ba=
beltrace version.</div><div>[error] Opening CTF traces for output is not su=
pported yet.</div><div>Error opening trace &quot;combined&quot; for writing=
.</div><div><br></div><div>Thanks,</div><div>Rocky</div></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Apr 7, 2017 at 3:03 PM=
, Philippe Proulx <span dir=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gma=
il.com" target=3D"_blank">eeppeliteloop@gmail.com</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">On Fri, Apr 7, 2017 at 4:15=
 PM, Rocky Dunlap &lt;<a href=3D"mailto:rsdunlapiv@gmail.com">rsdunlapiv@gm=
ail.com</a>&gt; wrote:<br>
&gt; Phil,<br>
&gt;<br>
&gt; This relates to my previous question about multi-process tracing. The<=
br>
&gt; workaround I am attempting is to have each process write its own trace=
 with<br>
&gt; a single stream, but then to pull all the stream files together into a=
<br>
&gt; single trace with one metadata file. For this reason the uuids would n=
eed to<br>
&gt; match.<br>
&gt;<br>
&gt; Do you think this will work?<br>
<br>
</span>First question: why not having multiple traces (multiple directories=
<br>
with multiple `metadata` files)? babeltrace(1) and Trace Compass can<br>
merge them easily.<br>
<br>
In the meantime, if you really want a single trace, here&#39;s a hack.<br>
Please don&#39;t tell anyone that I suggested this. Choose any generated<br=
>
`metadata` file which contains all the `event` blocks that you need.<br>
Note that, across all your traces, the order in which you add the event<br>
class objects to your single stream class object needs to remain the<br>
same so that they have the same IDs whatever the trace. Then, this<br>
works, as long as you use the Babeltrace 1.5.2 release:<br>
<br>
=C2=A0 =C2=A0 #include &lt;babeltrace/ctf-writer/writer.<wbr>h&gt;<br>
=C2=A0 =C2=A0 #include &lt;string.h&gt;<br>
=C2=A0 =C2=A0 #include &lt;assert.h&gt;<br>
<br>
=C2=A0 =C2=A0 typedef unsigned char uuid_t[16];<br>
<br>
=C2=A0 =C2=A0 struct bt_ref {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 long count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *release;<br>
=C2=A0 =C2=A0 };<br>
<br>
=C2=A0 =C2=A0 struct bt_object {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bt_ref ref_count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *release;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *parent;<br>
=C2=A0 =C2=A0 };<br>
<br>
=C2=A0 =C2=A0 struct bt_ctf_trace {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bt_object base;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int frozen;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char uuid[16];<br>
=C2=A0 =C2=A0 };<br>
<br>
=C2=A0 =C2=A0 struct bt_ctf_writer {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bt_object base;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int frozen;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bt_ctf_trace *trace;<br>
=C2=A0 =C2=A0 };<br>
<br>
=C2=A0 =C2=A0 int main(void)<br>
=C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bt_ctf_writer *writer;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char my_custom_uuid[16] =3D {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xb3, 0x38, 0x4d, 0x7b, 0x77, 0x8=
a, 0x4f, 0xf0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x99, 0xbd, 0x43, 0x54, 0x9e, 0xc=
0, 0x54, 0x1b,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 writer =3D bt_ctf_writer_create(&quot;/tmp/my-<=
wbr>trace&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(writer);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(writer-&gt;trace-&gt;uuid, my_custom_uui=
d, 16);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do stuff with writer here */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bt_ctf_writer_put(writer);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 }<br>
<br>
Again, I don&#39;t condone this: it&#39;s not portable, it&#39;s ugly, but =
it does<br>
what you ask.<br>
<br>
Another hack: search the byte sequences c1 fc 1f c1 (big endian) or<br>
c1 1f fc c1 (little endian) in all your stream files and replace the<br>
_next_ 16 bytes with your favorite UUID. Also replace the `uuid`<br>
attribute in the chosen `metadata` file with the canonical<br>
representation of your favorite UUID.<br>
<br>
Phil<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; Rocky<br>
&gt;<br>
&gt; On Apr 7, 2017 1:57 PM, &quot;Philippe Proulx&quot; &lt;<a href=3D"mai=
lto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Apr 7, 2017 at 3:18 PM, Rocky Dunlap &lt;<a href=3D"mailto=
:rsdunlapiv@gmail.com">rsdunlapiv@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; Is it possible to explicitly set a uuid for a trace using the=
 Babeltrace<br>
&gt;&gt; &gt; CTF<br>
&gt;&gt; &gt; writer?=C2=A0 I did not see a straightforward way to do it wi=
th the API.<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s not possible as of Babeltrace 1. We&#39;ll add trace UUID=
 accessors to<br>
&gt;&gt; the upcoming Babeltrace 2 API.<br>
&gt;&gt;<br>
&gt;&gt; That said, may I ask you why you need this? Two different CTF trac=
es<br>
&gt;&gt; should not share the same UUID.<br>
&gt;&gt;<br>
&gt;&gt; Phil<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Rocky<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a><br>
&gt;&gt; &gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-=
<wbr>bin/mailman/listinfo/lttng-dev</a><br>
&gt;&gt; &gt;<br>
</div></div></blockquote></div><br></div>

--f403045f286ad38441054c9ac962--

--===============8590474865454009961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8590474865454009961==--
