From: Chidhu R <chid1989@gmail.com>
Subject: Re: Printing bit fields with LTTng
Date: Thu, 11 Jun 2015 11:11:02 -0700
Message-ID: <CAL1ZhOOjJfTPCwcf-oFE1d+7WD0FVMWbCqFrrpkr+LXfcZjRUg__6636.43133962086$1434046372$gmane$org@mail.gmail.com>
References: <CAL1ZhON=nEPuoXks2AKq4k7nCpK_W_FQ96TM3299V69V6RgW_w@mail.gmail.com>
 <CAFXXi0k-HfWxPVmmF8=nap20pS-HRQwWwMc0P8jj0-RRhjXkYw@mail.gmail.com>
 <CAFXXi0=kTqTy-V843a3v+6qs0SmOPFsP6-2sVZoE6mi8LB0vhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0131831931=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f49.google.com ([209.85.215.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1Z36x8-0004vb-H6
 for lttng-dev@lists.lttng.org; Thu, 11 Jun 2015 14:11:51 -0400
Received: by lazv15 with SMTP id v15so8482192laz.3
 for <lttng-dev@lists.lttng.org>; Thu, 11 Jun 2015 11:11:42 -0700 (PDT)
In-Reply-To: <CAFXXi0=kTqTy-V843a3v+6qs0SmOPFsP6-2sVZoE6mi8LB0vhA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0131831931==
Content-Type: multipart/alternative; boundary=089e01419f6877e402051841ecb8

--089e01419f6877e402051841ecb8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Great. Thanks for sharing your inputs. I too learned something new.

On Wed, Jun 10, 2015 at 3:20 PM, Simon Marchi <simon.marchi@polymtl.ca>
wrote:

> On 10 June 2015 at 17:28, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> > On 10 June 2015 at 17:16, Chidhu R <chid1989@gmail.com> wrote:
> >> Hello,
> >>
> >> I am getting compilation issues while trying to print bit field values
> with
> >> LTTng.
> >>
> >> Error:
> >>
> >> hello.c: In function =E2=80=98main=E2=80=99:
> >> hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-field
> >> hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-field
> >> hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-field
> >> hello.c:36:1: error: =E2=80=98sizeof=E2=80=99 applied to a bit-field
> >>
> >> Snippet:
> >>
> >> struct abc{
> >>         int a:16;
> >>         int b:8;
> >> };
> >>
> >> Line 36: tracepoint(hello_world, my_third_tracepoint, aa.a, "welcome")=
;
> >> Line 37: printf("val =3D %x\n",aa.a);
> >>
> >> tracepoint line results in compilation error.
> >> printf succeeds.
> >>
> >> Tp definition looks like this.
> >>
> >> TRACEPOINT_EVENT(
> >>     hello_world,
> >>     my_third_tracepoint,
> >>     TP_ARGS(
> >>         uint32_t, arg,
> >>         const char * , my_string_arg
> >>     ),
> >>     TP_FIELDS(
> >>         ctf_integer_hex(uint32_t, my_arg, arg)
> >>         ctf_string(field, my_string_arg)
> >>     )
> >> )
> >>
> >> How to print bit field values?
> >>
> >> Thanks
> >> Chid
> >
> > I have no idea what the right fix would be, but an easy workaround
> > could be to add 0 to your value:
> >
> >     tracepoint(hello_world, my_third_tracepoint, aa.a + 0, "welcome");
> >
> > I just tried it and it works.
> >
> > Simon
>
> Alright, after a bit more investigation (thanks to Philippe Proulx),
> we found that this is caused by the SystemTap integration. If the
> SystemTap integration is enabled, each LTTng tracepoint also defines a
> SystemTap tracepoint.
>
> SystemTap uses sizeof() on the tracepoint's input arguments to find
> their sizes and typeof() to find their signedness. It encodes this
> info into a special section that then allows tools like gdb to re-use
> the tracepoints and get the argument values. For more information,
> look at the definitions of _SDT_ARGSIZE and _SDT_ARGSIGNED in
> /usr/include/sys/sdt.h.
>
> Pragmatically, I think that the "+ 0" trick is good enough, since it
> pleases SystemTap and is otherwise harmless. You could get the same
> result by casting your value to an integer type. However, you would
> need to carefully choose the size and signedness of the type you cast
> to, or it might alter your value. With + 0, it should work with any
> type.
>
> Thanks for raising this, I learned something new today.
>

--089e01419f6877e402051841ecb8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Great. Thanks for sharing your inputs. I too learned somet=
hing new.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Wed, Jun 10, 2015 at 3:20 PM, Simon Marchi <span dir=3D"ltr">&lt;<a href=
=3D"mailto:simon.marchi@polymtl.ca" target=3D"_blank">simon.marchi@polymtl.=
ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HO=
EnZb"><div class=3D"h5">On 10 June 2015 at 17:28, Simon Marchi &lt;<a href=
=3D"mailto:simon.marchi@polymtl.ca">simon.marchi@polymtl.ca</a>&gt; wrote:<=
br>
&gt; On 10 June 2015 at 17:16, Chidhu R &lt;<a href=3D"mailto:chid1989@gmai=
l.com">chid1989@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Hello,<br>
&gt;&gt;<br>
&gt;&gt; I am getting compilation issues while trying to print bit field va=
lues with<br>
&gt;&gt; LTTng.<br>
&gt;&gt;<br>
&gt;&gt; Error:<br>
&gt;&gt;<br>
&gt;&gt; hello.c: In function =E2=80=98main=E2=80=99:<br>
&gt;&gt; hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-fie=
ld<br>
&gt;&gt; hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-fie=
ld<br>
&gt;&gt; hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-fie=
ld<br>
&gt;&gt; hello.c:36:1: error: =E2=80=98sizeof=E2=80=99 applied to a bit-fie=
ld<br>
&gt;&gt;<br>
&gt;&gt; Snippet:<br>
&gt;&gt;<br>
&gt;&gt; struct abc{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int a:16;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int b:8;<br>
&gt;&gt; };<br>
&gt;&gt;<br>
&gt;&gt; Line 36: tracepoint(hello_world, my_third_tracepoint, aa.a, &quot;=
welcome&quot;);<br>
&gt;&gt; Line 37: printf(&quot;val =3D %x\n&quot;,aa.a);<br>
&gt;&gt;<br>
&gt;&gt; tracepoint line results in compilation error.<br>
&gt;&gt; printf succeeds.<br>
&gt;&gt;<br>
&gt;&gt; Tp definition looks like this.<br>
&gt;&gt;<br>
&gt;&gt; TRACEPOINT_EVENT(<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0hello_world,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0my_third_tracepoint,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0TP_ARGS(<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t, arg,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char * , my_string_arg<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0),<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0TP_FIELDS(<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_integer_hex(uint32_t, my_arg,=
 arg)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctf_string(field, my_string_arg)<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0)<br>
&gt;&gt; )<br>
&gt;&gt;<br>
&gt;&gt; How to print bit field values?<br>
&gt;&gt;<br>
&gt;&gt; Thanks<br>
&gt;&gt; Chid<br>
&gt;<br>
&gt; I have no idea what the right fix would be, but an easy workaround<br>
&gt; could be to add 0 to your value:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0tracepoint(hello_world, my_third_tracepoint, aa.a +=
 0, &quot;welcome&quot;);<br>
&gt;<br>
&gt; I just tried it and it works.<br>
&gt;<br>
&gt; Simon<br>
<br>
</div></div>Alright, after a bit more investigation (thanks to Philippe Pro=
ulx),<br>
we found that this is caused by the SystemTap integration. If the<br>
SystemTap integration is enabled, each LTTng tracepoint also defines a<br>
SystemTap tracepoint.<br>
<br>
SystemTap uses sizeof() on the tracepoint&#39;s input arguments to find<br>
their sizes and typeof() to find their signedness. It encodes this<br>
info into a special section that then allows tools like gdb to re-use<br>
the tracepoints and get the argument values. For more information,<br>
look at the definitions of _SDT_ARGSIZE and _SDT_ARGSIGNED in<br>
/usr/include/sys/sdt.h.<br>
<br>
Pragmatically, I think that the &quot;+ 0&quot; trick is good enough, since=
 it<br>
pleases SystemTap and is otherwise harmless. You could get the same<br>
result by casting your value to an integer type. However, you would<br>
need to carefully choose the size and signedness of the type you cast<br>
to, or it might alter your value. With + 0, it should work with any<br>
type.<br>
<br>
Thanks for raising this, I learned something new today.<br>
</blockquote></div><br></div>

--089e01419f6877e402051841ecb8--


--===============0131831931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0131831931==--
