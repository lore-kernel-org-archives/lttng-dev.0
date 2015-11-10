From: Rocky Dunlap <rsdunlapiv@gmail.com>
Subject: Re: Python Babeltrace - Write multiple streams
Date: Tue, 10 Nov 2015 09:37:40 -0700
Message-ID: <CAK-w0DcPucjp6Fjnf04gtDDEFJGwGKKSmCbhny2EaQsv=0VT2w__14999.8588291512$1447179472$gmane$org@mail.gmail.com>
References: <CAK-w0Ddnf5TXJfmv=scZ0j6DJ0+PNbPOynKpahN8t1qVDqy=ug@mail.gmail.com>
 <CA+jJMxvv3OV76yzAs2JZrFaop4ZRSwYpgn8n_YqKeJDsrM8opw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2077479176=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f169.google.com ([209.85.223.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <rsdunlapiv@gmail.com>) id 1ZwBvp-0006TI-KX
 for lttng-dev@lists.lttng.org; Tue, 10 Nov 2015 11:38:09 -0500
Received: by iodd200 with SMTP id d200so6638794iod.0
 for <lttng-dev@lists.lttng.org>; Tue, 10 Nov 2015 08:38:00 -0800 (PST)
In-Reply-To: <CA+jJMxvv3OV76yzAs2JZrFaop4ZRSwYpgn8n_YqKeJDsrM8opw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2077479176==
Content-Type: multipart/alternative; boundary=001a1140972e36112405243255e5

--001a1140972e36112405243255e5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

J=C3=A9r=C3=A9mie,

Fantastic - it works using the master branch. Will there be a new tag
anytime soon?

Thanks,
Rocky

On Tue, Nov 10, 2015 at 8:12 AM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Hi Rocky,
>
> The code looks good at first glance. Can you try with master and see
> if that might be problem that has been fixed since then?
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
> On Fri, Nov 6, 2015 at 9:40 PM, Rocky Dunlap <rsdunlapiv@gmail.com> wrote=
:
> > Using the Babletrace Python binding version 1.3, I adapted a simple
> example
> > to try to write a trace with two streams.  It appears to write okay (no
> > errors), but when I attempt to read it back (again using Babeltrace) I
> get
> > an error:
> >
> > [error] Stream 1 is not declared in metadata.
> > [error] Stream index creation error.
> > [error] Open file stream error.
> > [warning] [Context] Cannot open_trace of format ctf at path ./trace.
> >
> > Here is my code to write the streams:
> >
> > ################################
> >
> > from babeltrace import *
> >
> > trace_path =3D "./trace"
> >
> > print('trace path: {}'.format(trace_path))
> >
> > writer =3D CTFWriter.Writer(trace_path)
> >
> > clock =3D CTFWriter.Clock('my_clock')
> > clock.description =3D 'this is my clock'
> > writer.add_clock(clock)
> >
> > stream_class =3D CTFWriter.StreamClass('my_stream')
> > stream_class.clock =3D clock
> >
> > event_class =3D CTFWriter.EventClass('my_event')
> >
> > int32_field_decl =3D CTFWriter.IntegerFieldDeclaration(32)
> > int32_field_decl.signed =3D True
> >
> > event_class.add_field(int32_field_decl, 'my_field')
> >
> > stream_class.add_event_class(event_class)
> >
> > stream =3D writer.create_stream(stream_class)
> > stream2 =3D writer.create_stream(stream_class)
> >
> > event =3D CTFWriter.Event(event_class)
> > event.payload('my_field').value =3D -23
> > stream.append_event(event)
> >
> > event =3D CTFWriter.Event(event_class)
> > event.payload('my_field').value =3D -89
> > stream.append_event(event)
> >
> > event =3D CTFWriter.Event(event_class)
> > event.payload('my_field').value =3D -849
> > stream2.append_event(event)
> >
> > event =3D CTFWriter.Event(event_class)
> > event.payload('my_field').value =3D 42
> > stream2.append_event(event)
> >
> > stream.flush()
> > stream2.flush()
> >
> > ######################
> >
> > I am sure I am just not quite using the API correctly.  If you can spot
> the
> > error, please let me know.  Also, if anyone can point me to an example =
of
> > using the python bindings to write out multiple streams, I would
> appreciate
> > it.
> >
> > Thanks!
> > Rocky
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--001a1140972e36112405243255e5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">J=C3=A9r=C3=A9mie,</span>=
<br><div><span style=3D"font-size:12.8px"><br></span></div><div><span style=
=3D"font-size:12.8px">Fantastic - it works using the master branch. Will th=
ere be a new tag anytime soon?</span></div><div><span style=3D"font-size:12=
.8px"><br></span></div><div><span style=3D"font-size:12.8px">Thanks,</span>=
</div><div><span style=3D"font-size:12.8px">Rocky</span></div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Nov 10, 2015 at 8:12 A=
M, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jere=
mie.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Rocky,<br>
<br>
The code looks good at first glance. Can you try with master and see<br>
if that might be problem that has been fixed since then?<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<div><div><br>
On Fri, Nov 6, 2015 at 9:40 PM, Rocky Dunlap &lt;<a href=3D"mailto:rsdunlap=
iv@gmail.com" target=3D"_blank">rsdunlapiv@gmail.com</a>&gt; wrote:<br>
&gt; Using the Babletrace Python binding version 1.3, I adapted a simple ex=
ample<br>
&gt; to try to write a trace with two streams.=C2=A0 It appears to write ok=
ay (no<br>
&gt; errors), but when I attempt to read it back (again using Babeltrace) I=
 get<br>
&gt; an error:<br>
&gt;<br>
&gt; [error] Stream 1 is not declared in metadata.<br>
&gt; [error] Stream index creation error.<br>
&gt; [error] Open file stream error.<br>
&gt; [warning] [Context] Cannot open_trace of format ctf at path ./trace.<b=
r>
&gt;<br>
&gt; Here is my code to write the streams:<br>
&gt;<br>
&gt; ################################<br>
&gt;<br>
&gt; from babeltrace import *<br>
&gt;<br>
&gt; trace_path =3D &quot;./trace&quot;<br>
&gt;<br>
&gt; print(&#39;trace path: {}&#39;.format(trace_path))<br>
&gt;<br>
&gt; writer =3D CTFWriter.Writer(trace_path)<br>
&gt;<br>
&gt; clock =3D CTFWriter.Clock(&#39;my_clock&#39;)<br>
&gt; clock.description =3D &#39;this is my clock&#39;<br>
&gt; writer.add_clock(clock)<br>
&gt;<br>
&gt; stream_class =3D CTFWriter.StreamClass(&#39;my_stream&#39;)<br>
&gt; stream_class.clock =3D clock<br>
&gt;<br>
&gt; event_class =3D CTFWriter.EventClass(&#39;my_event&#39;)<br>
&gt;<br>
&gt; int32_field_decl =3D CTFWriter.IntegerFieldDeclaration(32)<br>
&gt; int32_field_decl.signed =3D True<br>
&gt;<br>
&gt; event_class.add_field(int32_field_decl, &#39;my_field&#39;)<br>
&gt;<br>
&gt; stream_class.add_event_class(event_class)<br>
&gt;<br>
&gt; stream =3D writer.create_stream(stream_class)<br>
&gt; stream2 =3D writer.create_stream(stream_class)<br>
&gt;<br>
&gt; event =3D CTFWriter.Event(event_class)<br>
&gt; event.payload(&#39;my_field&#39;).value =3D -23<br>
&gt; stream.append_event(event)<br>
&gt;<br>
&gt; event =3D CTFWriter.Event(event_class)<br>
&gt; event.payload(&#39;my_field&#39;).value =3D -89<br>
&gt; stream.append_event(event)<br>
&gt;<br>
&gt; event =3D CTFWriter.Event(event_class)<br>
&gt; event.payload(&#39;my_field&#39;).value =3D -849<br>
&gt; stream2.append_event(event)<br>
&gt;<br>
&gt; event =3D CTFWriter.Event(event_class)<br>
&gt; event.payload(&#39;my_field&#39;).value =3D 42<br>
&gt; stream2.append_event(event)<br>
&gt;<br>
&gt; stream.flush()<br>
&gt; stream2.flush()<br>
&gt;<br>
&gt; ######################<br>
&gt;<br>
&gt; I am sure I am just not quite using the API correctly.=C2=A0 If you ca=
n spot the<br>
&gt; error, please let me know.=C2=A0 Also, if anyone can point me to an ex=
ample of<br>
&gt; using the python bindings to write out multiple streams, I would appre=
ciate<br>
&gt; it.<br>
&gt;<br>
&gt; Thanks!<br>
&gt; Rocky<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br>
&gt;<br>
<span><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</font></span></blockquote></div><br></div></div>

--001a1140972e36112405243255e5--


--===============2077479176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2077479176==--
