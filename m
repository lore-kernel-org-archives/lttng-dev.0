From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lib_ring_buffer_align error bit-field '<anonymous>'
 width not an integer constant
Date: Tue, 4 Feb 2014 14:52:14 +0000 (UTC)
Message-ID: <245022020.18739.1391525534666.JavaMail.zimbra__10593.4902131141$1391525603$gmane$org@efficios.com>
References: <CAO_Arvrp4GwhVr_c170hD3eQ8F77WSmsY4wsCOpg3Xdg23jjKw@mail.gmail.com>
	<2097060417.17951.1391442624499.JavaMail.zimbra@efficios.com>
	<CAO_ArvoEFQ_fCGnCK-imf69_1UhPdhmteGsT_jdrt2qw6QnY+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0735619677=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WAhMK-00073y-65
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 09:52:26 -0500
In-Reply-To: <CAO_ArvoEFQ_fCGnCK-imf69_1UhPdhmteGsT_jdrt2qw6QnY+A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kumar s <skumar.m226@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0735619677==
Content-Type: multipart/alternative;
	boundary="----=_Part_18738_1639727653.1391525534664"

------=_Part_18738_1639727653.1391525534664
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

You might want to request help from Cavium, since they are the one supporting 
their toolchain. 

It really seems to be a Cavium-specific issue. 

Thanks, 

Mathieu 

----- Original Message -----

> From: "kumar s" <skumar.m226@gmail.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Tuesday, February 4, 2014 5:13:44 AM
> Subject: Re: [lttng-dev] lib_ring_buffer_align error bit-field '<anonymous>'
> width not an integer constant

> Hi,

> The lttng module i use is the latest version, compiler toolchain cannot be
> upgraded since it is provided by Cavium, kernel version is 2.6.32.27.

> Is there any change i need to do on lttng modules to build it?

> Thank you
> SKumar

> On Mon, Feb 3, 2014 at 9:20 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

> > > From: "kumar s" < skumar.m226@gmail.com >
> > 
> 
> > > To: lttng-dev@lists.lttng.org
> > 
> 
> > > Sent: Tuesday, December 3, 2013 3:20:02 AM
> > 
> 
> > > Subject: [lttng-dev] lib_ring_buffer_align error bit-field '<anonymous>'
> > > width not an integer constant
> > 
> 

> > > Hello,
> > 
> 

> > > When trying to build lttng modules i am getting this error. Cross
> > > compiler
> > > for mips and Arch = mips is used in makefile.
> > 
> 

> > > Linux kernel version 2.6.32.27
> > 
> 

> > > make -C
> > > /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux
> > > M=/home/shkumar/lttng-tools/lttngmod/lttng-modules modules ARCH=mips
> > > CROSS_COMPILE=mips64-octeon-linux-gnu-
> > 
> 
> > > make[1]: Entering directory
> > > `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
> > 
> 
> > > CC [M]
> > > /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o
> > 
> 
> > > In file included from
> > > /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/config.h:1,
> > 
> 
> > > from
> > > /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer-core.h:35,
> > 
> 
> > > from /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer.h:39,
> > 
> 
> > > from
> > > /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.c:24:
> > 
> 
> > > /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:
> > > In function 'lib_ring_buffer_align':
> > 
> 
> > > /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:266:
> > > error: bit-field '<anonymous>' width not an integer constant
> > 
> 
> > > make[2]: ***
> > > [/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o]
> > > Error 1
> > 
> 
> > > make[1]: *** [_module_/home/shkumar/lttng-tools/lttngmod/lttng-modules]
> > > Error
> > > 2
> > 
> 
> > > make[1]: Leaving directory
> > > `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
> > 
> 
> > > make: *** [default] Error 2
> > 
> 

> > > How do i fix this?
> > 
> 

> > This is caused by the use of offset_align(), passing incorrect parameters,
> > detected by the compiler:
> 

> > see lttng-modules
> 

> > lib/align.h:
> 

> > #define offset_align(align_drift, alignment) \
> 
> > ({ \
> 
> > BUILD_RUNTIME_BUG_ON((alignment) == 0 \
> 
> > || ((alignment) & ((alignment) - 1))); \
> 
> > (((alignment) - (align_drift)) & ((alignment) - 1)); \
> 
> > })
> 

> > See also lttng-modules
> 
> > lib/bug.h
> 

> > So there are two things that are possible: either the compiler you use does
> > not perform the
> 
> > optimisations that are expected, and therefore triggers the BUILD_BUG_ON()
> > without needing to,
> 
> > or there really is an incorrect value passed to offset_align().
> 

> > Make sure lttng-modules, your compiler toolchain, and your kernel are up to
> > date.
> 

> > Thanks,
> 

> > Mathieu
> 

> > > Skumar.
> > 
> 

> > > _______________________________________________
> > 
> 
> > > lttng-dev mailing list
> > 
> 
> > > lttng-dev@lists.lttng.org
> > 
> 
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 

> > --
> 
> > Mathieu Desnoyers
> 
> > EfficiOS Inc.
> 
> > http://www.efficios.com
> 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_18738_1639727653.1391525534664
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>You might want to request help f=
rom Cavium, since they are the one supporting<br></div><div>their toolchain=
.<br></div><div><br></div><div>It really seems to be a Cavium-specific issu=
e.<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathie=
u<br></div><div><br></div><div><br></div><hr id=3D"zwchr"><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"kumar s" &lt;skumar=
.m226@gmail.com&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;mathieu.desnoyers=
@efficios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>T=
uesday, February 4, 2014 5:13:44 AM<br><b>Subject: </b>Re: [lttng-dev] lib_=
ring_buffer_align error bit-field '&lt;anonymous&gt;' width not an integer =
constant<br><div><br></div><div dir=3D"ltr"><div><div><div><div>Hi,<br><div=
><br></div></div>The lttng module i use is the latest version, compiler too=
lchain cannot be upgraded since it is provided by Cavium, kernel version is=
 2.6.32.27. <br><div><br></div></div>Is there any change i need to do on lt=
tng modules to build it?<br>
<br></div>Thank you<br></div>SKumar<br></div><div class=3D"gmail_extra"><br=
><div><br></div><div class=3D"gmail_quote">On Mon, Feb 3, 2014 at 9:20 PM, =
Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers=
@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div style=3D"font-size:12pt;font-famil=
y:times new roman,new york,times,serif"><hr><blockquote style=3D"padding-le=
ft:5px;font-size:12pt;font-style:normal;margin-left:5px;font-family:Helveti=
ca,Arial,sans-serif;text-decoration:none;font-weight:normal;border-left:2px=
 solid #1010ff">
<b>From: </b>"kumar s" &lt;<a href=3D"mailto:skumar.m226@gmail.com" target=
=3D"_blank">skumar.m226@gmail.com</a>&gt;<br><b>To: </b><a href=3D"mailto:l=
ttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><b=
r>
<b>Sent: </b>Tuesday, December 3, 2013 3:20:02 AM<br><b>Subject: </b>[lttng=
-dev] lib_ring_buffer_align error bit-field '&lt;anonymous&gt;' width not a=
n integer constant<div><div class=3D"h5"><br><div><br></div><div dir=3D"ltr=
">
Hello,<div><br></div><div>When trying to build lttng modules i am getting t=
his error. Cross compiler for mips and Arch =3D mips is used in makefile.</=
div><div><br></div><div>Linux kernel version 2.6.32.27</div><div><br></div>
<div><br></div><div><div>make -C /home/shkumar/Development_Merge/NewOCT/OCT=
EON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux M=3D/home/shkumar/lttn=
g-tools/lttngmod/lttng-modules modules ARCH=3Dmips CROSS_COMPILE=3Dmips64-o=
cteon-linux-gnu-</div>
<div>make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/OC=
TEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'</div><div>&nbsp; CC =
[M] &nbsp;/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffe=
r-client-discard.o</div>
<div>In file included from /home/shkumar/lttng-tools/lttngmod/lttng-modules=
/wrapper/ringbuffer/config.h:1,</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp;from /home/shkumar/lttng-tools/lttngmod/lttng-=
modules/lttng-tracer-core.h:35,</div><div>

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from /home/sh=
kumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer.h:39,</div><div>&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from /home/shkumar=
/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.c:24:<=
/div><div>
/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../l=
ib/ringbuffer/config.h: In function 'lib_ring_buffer_align':</div><div>/hom=
e/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/r=
ingbuffer/config.h:266: error: bit-field '&lt;anonymous&gt;' width not an i=
nteger constant</div>
<div>make[2]: *** [/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-r=
ing-buffer-client-discard.o] Error 1</div><div>make[1]: *** [_module_/home/=
shkumar/lttng-tools/lttngmod/lttng-modules] Error 2</div><div>make[1]: Leav=
ing directory `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk=
/OCTEON-SDK/linux/kernel_2.6/linux'</div>
<div>make: *** [default] Error 2</div></div><div><br></div><div>How do i fi=
x this?</div></div></div></div></blockquote><div><br></div><div>This is cau=
sed by the use of offset_align(), passing incorrect parameters, detected by=
 the compiler:<br>
</div><div><br></div><div>see lttng-modules<br></div><div><br></div><div>li=
b/align.h:<br></div><div><br></div><div>#define offset_align(align_drift, a=
lignment)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ({&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; BUILD_RUNTIME_BUG_ON((alignment) =3D=3D 0&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ((alignment) &amp; ((alignmen=
t) - 1)));&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((alignment)=
 - (align_drift)) &amp; ((alignment) - 1));&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; })<br><div><br></div></div><div>=
See also lttng-modules<br></div><div>lib/bug.h<br></div><div><br></div><div=
>So there are two things that are possible: either the compiler you use doe=
s not perform the<br></div><div>optimisations that are expected, and theref=
ore triggers the BUILD_BUG_ON() without needing to,</div>
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
span class=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"col=
or: #888888;" color=3D"#888888"><br></span></span></blockquote><span class=
=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"color: #88888=
8;" color=3D"#888888"><div>
<br><div><br></div></div><div><br></div><div>-- <br></div><div><span></span=
>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" =
target=3D"_blank">http://www.efficios.com</a><span></span><br></div>
</span></span></div></div></blockquote></div><br></div>
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_18738_1639727653.1391525534664--


--===============0735619677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0735619677==--
