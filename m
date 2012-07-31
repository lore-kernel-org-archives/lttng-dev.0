From: Rui Han <r.han@umiami.edu>
Subject: Re: how to get the sockaddr struct from its pointer in
 kernel tracing
Date: Tue, 31 Jul 2012 13:33:44 -0400
Message-ID: <CABy43G-PhZN7etAPxD3b17a0mr2067TxF0eGU4aprjLBs0NfhA__1361.58197788081$1343756173$gmane$org@mail.gmail.com>
References: <CABy43G-atS7UTMYnjTBv_dnZa6jE7fb2TTF2VZ6X66JLoaASww@mail.gmail.com>
	<e14757be8ad5488d966e7873a6a27d9c@UMEX005.cgcent.miami.edu>
	<CABy43G865Vc_i8d=W5hW2qP=ixgjv6cgOq6ErP40mA5jEh+4Uw@mail.gmail.com>
	<3d151a9bb8af4f308b099a482117a498@UMEX001.cgcent.miami.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1973875332=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f48.google.com ([209.85.213.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1SwGKM-0007O0-LY
	for lttng-dev@lists.lttng.org; Tue, 31 Jul 2012 13:33:51 -0400
Received: by yhfq46 with SMTP id q46so7244618yhf.35
	for <lttng-dev@lists.lttng.org>; Tue, 31 Jul 2012 10:33:45 -0700 (PDT)
In-Reply-To: <3d151a9bb8af4f308b099a482117a498@UMEX001.cgcent.miami.edu>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1973875332==
Content-Type: multipart/alternative; boundary=f46d042f96ea7ea66c04c62394fa

--f46d042f96ea7ea66c04c62394fa
Content-Type: text/plain; charset=ISO-8859-1

Great! Got it. Thank you.

Rui

On Tue, Jul 31, 2012 at 1:26 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> By close integration, I mean that we would have to change the in-kernel
> structure declarations and wrap them into macros, so we can re-use those
> headers within the TRACE_EVENT code to serialize the events and express
> the event metadata.
>
> Mathieu
>
> * Rui Han (r.han@umiami.edu) wrote:
> > Hi Mathieu,
> >
> > Thank you very much for your reply. I'll look into that solution. By
> "close
> > integration", do you mean minimum overhead? Could you be more
> > specific about the issue that prevent it from being implemented in
> current
> > version. So that I can tell whether I am be able to do it or not within
> > time constrain.
> >
> > Regards,
> > Rui
> >
> > On Tue, Jul 31, 2012 at 12:29 PM, Mathieu Desnoyers <
> > mathieu.desnoyers@efficios.com> wrote:
> >
> > > * Rui Han (r.han@umiami.edu) wrote:
> > > > Hi,
> > > >
> > > > In the sys_connect and sys_bind kernel tracing, a pointer to the
> socdaddr
> > > > struct has been dumped. (i.e. the second argument in sys_bind: {
> cpu_id
> > > = 0
> > > > }, { fd = 39, umyaddr = 0x7FE18E3D0B80, addrlen = 0xC }). What if I
> want
> > > to
> > > > access the struct for the IP and port number related to the socket?
> Is
> > > > there an easy way to do this? Please give me some hints. Thank you
> very
> > > > much.
> > >
> > > current, none.
> > >
> > > A "quick" way to do this might be to add a tracepoint into these system
> > > calls.
> > >
> > > Eventually, we might look into supporting writing complex data
> > > structures into lttng-modules, but this would require close integration
> > > with the Linux kernel sources.
> > >
> > > Thanks,
> > >
> > > Mathieu
> > >
> > > >
> > > > Regards,
> > > > Rui
> > >
> > > > _______________________________________________
> > > > lttng-dev mailing list
> > > > lttng-dev@lists.lttng.org
> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> > >
> > > --
> > > Mathieu Desnoyers
> > > Operating System Efficiency R&D Consultant
> > > EfficiOS Inc.
> > > http://www.efficios.com
> > >
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>

--f46d042f96ea7ea66c04c62394fa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Great! Got it. Thank you.<div><br></div><div>Rui<br><br><div class=3D"gmail=
_quote">On Tue, Jul 31, 2012 at 1:26 PM, Mathieu Desnoyers <span dir=3D"ltr=
">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">m=
athieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">By close integration, I mean that we would h=
ave to change the in-kernel<br>
structure declarations and wrap them into macros, so we can re-use those<br=
>
headers within the TRACE_EVENT code to serialize the events and express<br>
the event metadata.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Mathieu<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
* Rui Han (<a href=3D"mailto:r.han@umiami.edu">r.han@umiami.edu</a>) wrote:=
<br>
&gt; Hi Mathieu,<br>
&gt;<br>
&gt; Thank you very much for your reply. I&#39;ll look into that solution. =
By &quot;close<br>
&gt; integration&quot;, do you mean minimum overhead? Could you be more<br>
&gt; specific about the issue that prevent it from being implemented in cur=
rent<br>
&gt; version. So that I can tell whether I am be able to do it or not withi=
n<br>
&gt; time constrain.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Rui<br>
&gt;<br>
&gt; On Tue, Jul 31, 2012 at 12:29 PM, Mathieu Desnoyers &lt;<br>
&gt; <a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@ef=
ficios.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; * Rui Han (<a href=3D"mailto:r.han@umiami.edu">r.han@umiami.edu</=
a>) wrote:<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In the sys_connect and sys_bind kernel tracing, a pointer to=
 the socdaddr<br>
&gt; &gt; &gt; struct has been dumped. (i.e. the second argument in sys_bin=
d: { cpu_id<br>
&gt; &gt; =3D 0<br>
&gt; &gt; &gt; }, { fd =3D 39, umyaddr =3D 0x7FE18E3D0B80, addrlen =3D 0xC =
}). What if I want<br>
&gt; &gt; to<br>
&gt; &gt; &gt; access the struct for the IP and port number related to the =
socket? Is<br>
&gt; &gt; &gt; there an easy way to do this? Please give me some hints. Tha=
nk you very<br>
&gt; &gt; &gt; much.<br>
&gt; &gt;<br>
&gt; &gt; current, none.<br>
&gt; &gt;<br>
&gt; &gt; A &quot;quick&quot; way to do this might be to add a tracepoint i=
nto these system<br>
&gt; &gt; calls.<br>
&gt; &gt;<br>
&gt; &gt; Eventually, we might look into supporting writing complex data<br=
>
&gt; &gt; structures into lttng-modules, but this would require close integ=
ration<br>
&gt; &gt; with the Linux kernel sources.<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Mathieu<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; Rui<br>
&gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; lttng-dev mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists=
.lttng.org</a><br>
&gt; &gt; &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Mathieu Desnoyers<br>
&gt; &gt; Operating System Efficiency R&amp;D Consultant<br>
&gt; &gt; EfficiOS Inc.<br>
&gt; &gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.=
efficios.com</a><br>
&gt; &gt;<br>
<br>
--<br>
Mathieu Desnoyers<br>
Operating System Efficiency R&amp;D Consultant<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</div></div></blockquote></div><br></div>

--f46d042f96ea7ea66c04c62394fa--


--===============1973875332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1973875332==--
