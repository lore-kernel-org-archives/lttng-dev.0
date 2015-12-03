From: Zvi Vered <veredz72@gmail.com>
Subject: Re: lttng-modules-2.7.0 : compilation error
Date: Thu, 3 Dec 2015 10:49:43 +0200
Message-ID: <CABRndgzjFhLhjTfOoc47z5NAb-mrK=9jXVMJzoTA5P2UdETgPw__23433.4167595536$1449132644$gmane$org@mail.gmail.com>
References: <CABRndgyBrVAaCP48tN_RWkqjm8z+i4H8oQKAsTHi=oY0m3LBzg@mail.gmail.com>
 <1581598001.190481.1449127274969.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2134670317=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f171.google.com ([209.85.223.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <veredz72@gmail.com>) id 1a4PaI-0001Gr-5K
 for lttng-dev@lists.lttng.org; Thu, 03 Dec 2015 03:49:52 -0500
Received: by ioir85 with SMTP id r85so74022780ioi.1
 for <lttng-dev@lists.lttng.org>; Thu, 03 Dec 2015 00:49:44 -0800 (PST)
In-Reply-To: <1581598001.190481.1449127274969.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2134670317==
Content-Type: multipart/alternative; boundary=001a113ee3ecd9265d0525fa7843

--001a113ee3ecd9265d0525fa7843
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you.
Z.V
On Dec 3, 2015 9:21 AM, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com=
>
wrote:

> ----- On Dec 3, 2015, at 4:20 AM, Zvi Vered veredz72@gmail.com wrote:
>
> > Hello,
> >
> > I'm tried to compile lttng-modules:
> >
> > more /proc/version:
> > Linux version 2.6.32-279.el6.x86_64
> > (mockbuild@c6b9.bsys.dev.centos.org) (gcc version 4.4.6 20120305 (Red
> > Hat 4.4.6-4) (GCC) )
> > #1 SMP Fri Jun 22 12:19:21 UTC 2012
>
> Hi,
>
> Kernel 2.6.32 is not supported by lttng-modules. You will need to
> upgrade your kernel. See README.md in lttng-modules.
>
> Thanks,
>
> Mathieu
>
> >
> > yum install kernel-headers
> > cd lttng-modules-2.7.0
> > make
> >
> > and got:
> >
> > LTTNG_KERNELDIR=3D/lib/modules/2.6.32-279.el6.x86_64/build make -C
> > /lib/modules/2.6.32-279.el6.x86_64/build
> > M=3D/home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0 modules
> > make[1]: Entering directory `/usr/src/kernels/2.6.32-279.el6.x86_64'
> >  CC [M]
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-buf=
fer-client-discard.o
> > In file included from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/frontend_api.h:1,
> >                 from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/api.h:35,
> >                 from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/api.h:1,
> >                 from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-buf=
fer-client.h:177,
> >                 from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-buf=
fer-client-discard.c:29:
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/fro=
ntend_api.h:77:1:
> > error: pasting "per_cpu__" and "*" does not give a valid preprocessing
> > token
> > In file included from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/frontend_api.h:1,
> >                 from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/api.h:35,
> >                 from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/api.h:1,
> >                 from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-buf=
fer-client.h:177,
> >                 from
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-buf=
fer-client-discard.c:29:
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/fro=
ntend_api.h:
> > In function =E2=80=98lib_ring_buffer_put_cpu=E2=80=99:
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/fro=
ntend_api.h:77:
> > error: =E2=80=98per_cpu__=E2=80=99 undeclared (first use in this functi=
on)
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/fro=
ntend_api.h:77:
> > error: (Each undeclared identifier is reported only once
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/fro=
ntend_api.h:77:
> > error: for each function it appears in.)
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/fro=
ntend_api.h:77:
> > error: =E2=80=98lib_ring_buffer_nesting=E2=80=99 undeclared (first use =
in this
> > function)
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/fro=
ntend_api.h:77:
> > warning: type defaults to =E2=80=98int=E2=80=99 in declaration of =E2=
=80=98type name=E2=80=99
> >
> /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/ringbu=
ffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/fro=
ntend_api.h:77:
> > error: invalid type argument of =E2=80=98unary *=E2=80=99 (have =E2=80=
=98int=E2=80=99)
> > make[2]: ***
> >
> [/home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-bu=
ffer-client-discard.o]
> > Error 1
> > make[1]: ***
> > [_module_/home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0]
> > Error 2
> > make[1]: Leaving directory `/usr/src/kernels/2.6.32-279.el6.x86_64'
> >
> > I did not add yet the required components to the kernel.
> >
> > Can you help ?
> >
> > Best regards,
> > Z.V
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a113ee3ecd9265d0525fa7843
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thank you.<br>
Z.V</p>
<div class=3D"gmail_quote">On Dec 3, 2015 9:21 AM, &quot;Mathieu Desnoyers&=
quot; &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoye=
rs@efficios.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">----- On Dec 3, 2015, at 4:20 AM, Zvi Vered <a href=3D"mailto:ve=
redz72@gmail.com">veredz72@gmail.com</a> wrote:<br>
<br>
&gt; Hello,<br>
&gt;<br>
&gt; I&#39;m tried to compile lttng-modules:<br>
&gt;<br>
&gt; more /proc/version:<br>
&gt; Linux version 2.6.32-279.el6.x86_64<br>
&gt; (<a href=3D"mailto:mockbuild@c6b9.bsys.dev.centos.org">mockbuild@c6b9.=
bsys.dev.centos.org</a>) (gcc version 4.4.6 20120305 (Red<br>
&gt; Hat 4.4.6-4) (GCC) )<br>
&gt; #1 SMP Fri Jun 22 12:19:21 UTC 2012<br>
<br>
Hi,<br>
<br>
Kernel 2.6.32 is not supported by lttng-modules. You will need to<br>
upgrade your kernel. See README.md in lttng-modules.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt;<br>
&gt; yum install kernel-headers<br>
&gt; cd lttng-modules-2.7.0<br>
&gt; make<br>
&gt;<br>
&gt; and got:<br>
&gt;<br>
&gt; LTTNG_KERNELDIR=3D/lib/modules/2.6.32-279.el6.x86_64/build make -C<br>
&gt; /lib/modules/2.6.32-279.el6.x86_64/build<br>
&gt; M=3D/home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0 modules=
<br>
&gt; make[1]: Entering directory `/usr/src/kernels/2.6.32-279.el6.x86_64&#3=
9;<br>
&gt;=C2=A0 CC [M]<br>
&gt;=C2=A0 /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng=
-ring-buffer-client-discard.o<br>
&gt; In file included from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/frontend_api.h:1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/api.h:35,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/api.h:1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-=
buffer-client.h:177,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-=
buffer-client-discard.c:29:<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/=
frontend_api.h:77:1:<br>
&gt; error: pasting &quot;per_cpu__&quot; and &quot;*&quot; does not give a=
 valid preprocessing<br>
&gt; token<br>
&gt; In file included from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/frontend_api.h:1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/api.h:35,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/api.h:1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-=
buffer-client.h:177,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring-=
buffer-client-discard.c:29:<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/=
frontend_api.h:<br>
&gt; In function =E2=80=98lib_ring_buffer_put_cpu=E2=80=99:<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/=
frontend_api.h:77:<br>
&gt; error: =E2=80=98per_cpu__=E2=80=99 undeclared (first use in this funct=
ion)<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/=
frontend_api.h:77:<br>
&gt; error: (Each undeclared identifier is reported only once<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/=
frontend_api.h:77:<br>
&gt; error: for each function it appears in.)<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/=
frontend_api.h:77:<br>
&gt; error: =E2=80=98lib_ring_buffer_nesting=E2=80=99 undeclared (first use=
 in this<br>
&gt; function)<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/=
frontend_api.h:77:<br>
&gt; warning: type defaults to =E2=80=98int=E2=80=99 in declaration of =E2=
=80=98type name=E2=80=99<br>
&gt; /home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/wrapper/rin=
gbuffer/../../lib/ringbuffer/../../wrapper/ringbuffer/../../lib/ringbuffer/=
frontend_api.h:77:<br>
&gt; error: invalid type argument of =E2=80=98unary *=E2=80=99 (have =E2=80=
=98int=E2=80=99)<br>
&gt; make[2]: ***<br>
&gt; [/home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0/lttng-ring=
-buffer-client-discard.o]<br>
&gt; Error 1<br>
&gt; make[1]: ***<br>
&gt; [_module_/home/zvivered/Downloads/lttng-modules/lttng-modules-2.7.0]<b=
r>
&gt; Error 2<br>
&gt; make[1]: Leaving directory `/usr/src/kernels/2.6.32-279.el6.x86_64&#39=
;<br>
&gt;<br>
&gt; I did not add yet the required components to the kernel.<br>
&gt;<br>
&gt; Can you help ?<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Z.V<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br>
<br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</blockquote></div>

--001a113ee3ecd9265d0525fa7843--


--===============2134670317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2134670317==--
