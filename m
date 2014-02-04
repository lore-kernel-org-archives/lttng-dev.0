From: kumar s <skumar.m226@gmail.com>
Subject: Re: lib_ring_buffer_align error bit-field '<anonymous>'
 width not an integer constant
Date: Tue, 4 Feb 2014 15:43:44 +0530
Message-ID: <CAO_ArvoEFQ_fCGnCK-imf69_1UhPdhmteGsT_jdrt2qw6QnY+A__29586.8279682056$1391508885$gmane$org@mail.gmail.com>
References: <CAO_Arvrp4GwhVr_c170hD3eQ8F77WSmsY4wsCOpg3Xdg23jjKw@mail.gmail.com>
	<2097060417.17951.1391442624499.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0426839071=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f48.google.com ([209.85.215.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1WAd0o-0004ib-TQ
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 05:13:52 -0500
Received: by mail-la0-f48.google.com with SMTP id mc6so6171337lab.7
	for <lttng-dev@lists.lttng.org>; Tue, 04 Feb 2014 02:13:44 -0800 (PST)
In-Reply-To: <2097060417.17951.1391442624499.JavaMail.zimbra@efficios.com>
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

--===============0426839071==
Content-Type: multipart/alternative; boundary=047d7b3a89462c372404f191e579

--047d7b3a89462c372404f191e579
Content-Type: text/plain; charset=ISO-8859-1

Hi,

The lttng module i use is the latest version, compiler toolchain cannot be
upgraded since it is provided by Cavium, kernel version is 2.6.32.27.

Is there any change i need to do on lttng modules to build it?

Thank you
SKumar


On Mon, Feb 3, 2014 at 9:20 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ------------------------------
>
> *From: *"kumar s" <skumar.m226@gmail.com>
> *To: *lttng-dev@lists.lttng.org
> *Sent: *Tuesday, December 3, 2013 3:20:02 AM
> *Subject: *[lttng-dev] lib_ring_buffer_align error bit-field
> '<anonymous>' width not an integer constant
>
>
> Hello,
>
> When trying to build lttng modules i am getting this error. Cross compiler
> for mips and Arch = mips is used in makefile.
>
> Linux kernel version 2.6.32.27
>
>
> make -C
> /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux
> M=/home/shkumar/lttng-tools/lttngmod/lttng-modules modules ARCH=mips
> CROSS_COMPILE=mips64-octeon-linux-gnu-
> make[1]: Entering directory
> `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
>   CC [M]
>  /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o
> In file included from
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/config.h:1,
>                  from
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer-core.h:35,
>                  from
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer.h:39,
>                  from
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.c:24:
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:
> In function 'lib_ring_buffer_align':
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:266:
> error: bit-field '<anonymous>' width not an integer constant
> make[2]: ***
> [/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o]
> Error 1
> make[1]: *** [_module_/home/shkumar/lttng-tools/lttngmod/lttng-modules]
> Error 2
> make[1]: Leaving directory
> `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
> make: *** [default] Error 2
>
> How do i fix this?
>
>
> This is caused by the use of offset_align(), passing incorrect parameters,
> detected by the compiler:
>
> see lttng-modules
>
> lib/align.h:
>
> #define offset_align(align_drift,
> alignment)                                   \
>
> ({                                                                     \
>                 BUILD_RUNTIME_BUG_ON((alignment) ==
> 0                          \
>                                    || ((alignment) & ((alignment) -
> 1)));      \
>                 (((alignment) - (align_drift)) & ((alignment) -
> 1));           \
>         })
>
> See also lttng-modules
> lib/bug.h
>
> So there are two things that are possible: either the compiler you use
> does not perform the
> optimisations that are expected, and therefore triggers the BUILD_BUG_ON()
> without needing to,
> or there really is an incorrect value passed to offset_align().
>
> Make sure lttng-modules, your compiler toolchain, and your kernel are up
> to date.
>
> Thanks,
>
> Mathieu
>
>
> Skumar.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b3a89462c372404f191e579
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br><br></div>The lttng module i us=
e is the latest version, compiler toolchain cannot be upgraded since it is =
provided by Cavium, kernel version is 2.6.32.27. <br><br></div>Is there any=
 change i need to do on lttng modules to build it?<br>
<br></div>Thank you<br></div>SKumar<br></div><div class=3D"gmail_extra"><br=
><br><div class=3D"gmail_quote">On Mon, Feb 3, 2014 at 9:20 PM, Mathieu Des=
noyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.c=
om" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<=
br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div style=3D"font-size:12pt;font-famil=
y:times new roman,new york,times,serif"><hr><blockquote style=3D"padding-le=
ft:5px;font-size:12pt;font-style:normal;margin-left:5px;font-family:Helveti=
ca,Arial,sans-serif;text-decoration:none;font-weight:normal;border-left:2px=
 solid #1010ff">
<b>From: </b>&quot;kumar s&quot; &lt;<a href=3D"mailto:skumar.m226@gmail.co=
m" target=3D"_blank">skumar.m226@gmail.com</a>&gt;<br><b>To: </b><a href=3D=
"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.=
org</a><br>
<b>Sent: </b>Tuesday, December 3, 2013 3:20:02 AM<br><b>Subject: </b>[lttng=
-dev] lib_ring_buffer_align error bit-field &#39;&lt;anonymous&gt;&#39; wid=
th not an integer constant<div><div class=3D"h5"><br><div><br></div><div di=
r=3D"ltr">
Hello,<div><br></div><div>When trying to build lttng modules i am getting t=
his error. Cross compiler for mips and Arch =3D mips is used in makefile.</=
div><div><br></div><div>Linux kernel version 2.6.32.27</div><div><br></div>
<div><br></div><div><div>make -C /home/shkumar/Development_Merge/NewOCT/OCT=
EON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux M=3D/home/shkumar/lttn=
g-tools/lttngmod/lttng-modules modules ARCH=3Dmips CROSS_COMPILE=3Dmips64-o=
cteon-linux-gnu-</div>
<div>make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/OC=
TEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux&#39;</div><div>=A0 CC=
 [M] =A0/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-=
client-discard.o</div>
<div>In file included from /home/shkumar/lttng-tools/lttngmod/lttng-modules=
/wrapper/ringbuffer/config.h:1,</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0from /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer-core.=
h:35,</div><div>

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from /home/shkumar/lttng-tools/lttngmod/=
lttng-modules/lttng-tracer.h:39,</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0from /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-=
client-discard.c:24:</div><div>
/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../l=
ib/ringbuffer/config.h: In function &#39;lib_ring_buffer_align&#39;:</div><=
div>/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../=
../lib/ringbuffer/config.h:266: error: bit-field &#39;&lt;anonymous&gt;&#39=
; width not an integer constant</div>
<div>make[2]: *** [/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-r=
ing-buffer-client-discard.o] Error 1</div><div>make[1]: *** [_module_/home/=
shkumar/lttng-tools/lttngmod/lttng-modules] Error 2</div><div>make[1]: Leav=
ing directory `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk=
/OCTEON-SDK/linux/kernel_2.6/linux&#39;</div>
<div>make: *** [default] Error 2</div></div><div><br></div><div>How do i fi=
x this?</div></div></div></div></blockquote><div><br></div><div>This is cau=
sed by the use of offset_align(), passing incorrect parameters, detected by=
 the compiler:<br>
</div><div><br></div><div>see lttng-modules<br></div><div><br></div><div>li=
b/align.h:<br></div><div><br></div><div>#define offset_align(align_drift, a=
lignment)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \<br>=A0=A0=A0=A0=A0=A0=A0 ({=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BUILD_RUNTIME_BUG_ON((alignme=
nt) =3D=3D 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 || ((alignment) &amp; ((align=
ment) - 1)));=A0=A0=A0=A0=A0 \<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 (((alignment) - (align_drift)) &amp; ((alignment) - 1));=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 \<br>
=A0=A0=A0=A0=A0=A0=A0 })<br><br></div><div>See also lttng-modules<br></div>=
<div>lib/bug.h<br></div><div><br></div><div>So there are two things that ar=
e possible: either the compiler you use does not perform the<br></div><div>=
optimisations that are expected, and therefore triggers the BUILD_BUG_ON() =
without needing to,</div>
<div>or there really is an incorrect value passed to offset_align().<br></d=
iv><div><br></div><div>Make sure lttng-modules, your compiler toolchain, an=
d your kernel are up to date.<br></div><div><br></div><div>Thanks,<br></div=
>
<div><br></div><div>Mathieu<br></div><div><br></div><blockquote style=3D"pa=
dding-left:5px;font-size:12pt;font-style:normal;margin-left:5px;font-family=
:Helvetica,Arial,sans-serif;text-decoration:none;font-weight:normal;border-=
left:2px solid #1010ff">
<div dir=3D"ltr"><div><br></div><div>Skumar.</div></div><br>_______________=
________________________________<br>lttng-dev mailing list<br><a href=3D"ma=
ilto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org=
</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquot=
e><span class=3D"HOEnZb"><font color=3D"#888888"><div>
<br><br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></span=
>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" =
target=3D"_blank">http://www.efficios.com</a><span name=3D"x"></span><br></=
div>
</font></span></div></div></blockquote></div><br></div>

--047d7b3a89462c372404f191e579--


--===============0426839071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0426839071==--
