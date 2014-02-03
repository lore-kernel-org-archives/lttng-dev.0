From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lib_ring_buffer_align error bit-field '<anonymous>'
 width not an integer constant
Date: Mon, 3 Feb 2014 15:50:24 +0000 (UTC)
Message-ID: <2097060417.17951.1391442624499.JavaMail.zimbra__5706.42311727187$1391442691$gmane$org@efficios.com>
References: <CAO_Arvrp4GwhVr_c170hD3eQ8F77WSmsY4wsCOpg3Xdg23jjKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0112568377=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WALn2-0004Vw-4v
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 10:50:35 -0500
In-Reply-To: <CAO_Arvrp4GwhVr_c170hD3eQ8F77WSmsY4wsCOpg3Xdg23jjKw@mail.gmail.com>
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

--===============0112568377==
Content-Type: multipart/alternative;
	boundary="----=_Part_17950_501378914.1391442624497"

------=_Part_17950_501378914.1391442624497
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "kumar s" <skumar.m226@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, December 3, 2013 3:20:02 AM
> Subject: [lttng-dev] lib_ring_buffer_align error bit-field '<anonymous>'
> width not an integer constant

> Hello,

> When trying to build lttng modules i am getting this error. Cross compiler
> for mips and Arch = mips is used in makefile.

> Linux kernel version 2.6.32.27

> make -C
> /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux
> M=/home/shkumar/lttng-tools/lttngmod/lttng-modules modules ARCH=mips
> CROSS_COMPILE=mips64-octeon-linux-gnu-
> make[1]: Entering directory
> `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
> CC [M]
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o
> In file included from
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/config.h:1,
> from /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer-core.h:35,
> from /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer.h:39,
> from
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.c:24:
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:
> In function 'lib_ring_buffer_align':
> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:266:
> error: bit-field '<anonymous>' width not an integer constant
> make[2]: ***
> [/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o]
> Error 1
> make[1]: *** [_module_/home/shkumar/lttng-tools/lttngmod/lttng-modules] Error
> 2
> make[1]: Leaving directory
> `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
> make: *** [default] Error 2

> How do i fix this?

This is caused by the use of offset_align(), passing incorrect parameters, detected by the compiler: 

see lttng-modules 

lib/align.h: 

#define offset_align(align_drift, alignment) \ 
({ \ 
BUILD_RUNTIME_BUG_ON((alignment) == 0 \ 
|| ((alignment) & ((alignment) - 1))); \ 
(((alignment) - (align_drift)) & ((alignment) - 1)); \ 
}) 

See also lttng-modules 
lib/bug.h 

So there are two things that are possible: either the compiler you use does not perform the 
optimisations that are expected, and therefore triggers the BUILD_BUG_ON() without needing to, 
or there really is an incorrect value passed to offset_align(). 

Make sure lttng-modules, your compiler toolchain, and your kernel are up to date. 

Thanks, 

Mathieu 

> Skumar.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_17950_501378914.1391442624497
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"kumar s" &lt;skumar.m2=
26@gmail.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Tu=
esday, December 3, 2013 3:20:02 AM<br><b>Subject: </b>[lttng-dev] lib_ring_=
buffer_align error bit-field '&lt;anonymous&gt;' width not an integer const=
ant<br><div><br></div><div dir=3D"ltr">Hello,<div><br></div><div>When tryin=
g to build lttng modules i am getting this error. Cross compiler for mips a=
nd Arch =3D mips is used in makefile.</div><div><br></div><div>Linux kernel=
 version 2.6.32.27</div><div><br></div><div><br></div><div><div>make -C /ho=
me/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/=
kernel_2.6/linux M=3D/home/shkumar/lttng-tools/lttngmod/lttng-modules modul=
es ARCH=3Dmips CROSS_COMPILE=3Dmips64-octeon-linux-gnu-</div><div>make[1]: =
Entering directory `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeo=
n_sdk/OCTEON-SDK/linux/kernel_2.6/linux'</div><div>&nbsp; CC [M] &nbsp;/hom=
e/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-disca=
rd.o</div><div>In file included from /home/shkumar/lttng-tools/lttngmod/ltt=
ng-modules/wrapper/ringbuffer/config.h:1,</div><div>&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from /home/shkumar/lttng-tools/lttng=
mod/lttng-modules/lttng-tracer-core.h:35,</div><div>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from /home/sh=
kumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer.h:39,</div><div>&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;from /home/shkumar=
/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.c:24:<=
/div><div>/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuff=
er/../../lib/ringbuffer/config.h: In function 'lib_ring_buffer_align':</div=
><div>/home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/.=
./../lib/ringbuffer/config.h:266: error: bit-field '&lt;anonymous&gt;' widt=
h not an integer constant</div><div>make[2]: *** [/home/shkumar/lttng-tools=
/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o] Error 1</div><d=
iv>make[1]: *** [_module_/home/shkumar/lttng-tools/lttngmod/lttng-modules] =
Error 2</div><div>make[1]: Leaving directory `/home/shkumar/Development_Mer=
ge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'</div><di=
v>make: *** [default] Error 2</div></div><div><br></div><div>How do i fix t=
his?</div></div></blockquote><div><br></div><div>This is caused by the use =
of offset_align(), passing incorrect parameters, detected by the compiler:<=
br></div><div><br></div><div>see lttng-modules<br></div><div><br></div><div=
>lib/align.h:<br></div><div><br></div><div>#define offset_align(align_drift=
, alignment)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ({&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BUILD_RUNTIME_BUG_ON((alignment) =3D=3D 0&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ((alignment) &amp; ((al=
ignment) - 1)));&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((alig=
nment) - (align_drift)) &amp; ((alignment) - 1));&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; })<br><br></div><div>See also lttng-modules<br></div><div>lib/bug.h=
<br></div><div><br></div><div>So there are two things that are possible: ei=
ther the compiler you use does not perform the<br></div><div>optimisations =
that are expected, and therefore triggers the BUILD_BUG_ON() without needin=
g to,</div><div>or there really is an incorrect value passed to offset_alig=
n().<br></div><div><br></div><div>Make sure lttng-modules, your compiler to=
olchain, and your kernel are up to date.<br></div><div><br></div><div>Thank=
s,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><br><=
/div><div>Skumar.</div></div><br>__________________________________________=
_____<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://list=
s.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br=
></div><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathie=
u Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></s=
pan><br></div></div></body></html>
------=_Part_17950_501378914.1391442624497--


--===============0112568377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0112568377==--
