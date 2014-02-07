From: kumar s <skumar.m226@gmail.com>
Subject: Fwd: lib_ring_buffer_align error bit-field
 '<anonymous>' width not an integer constant
Date: Fri, 7 Feb 2014 10:08:51 +0530
Message-ID: <CAO_ArvpX1w23_fYzjo05g1_3TGci4GBqov7tSz+tD5u9+b5WFg__19610.6228781447$1391748002$gmane$org@mail.gmail.com>
References: <CAO_Arvrp4GwhVr_c170hD3eQ8F77WSmsY4wsCOpg3Xdg23jjKw@mail.gmail.com>
	<2097060417.17951.1391442624499.JavaMail.zimbra@efficios.com>
	<CAO_ArvoEFQ_fCGnCK-imf69_1UhPdhmteGsT_jdrt2qw6QnY+A@mail.gmail.com>
	<245022020.18739.1391525534666.JavaMail.zimbra@efficios.com>
	<CAO_ArvrPPJZ4H_cLx4uFd=wd7XPuq=PDEU_RqU2=3k4Bjx5Czw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1162580383=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1WBdDO-0002uQ-Et
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 23:39:01 -0500
Received: by mail-lb0-f174.google.com with SMTP id l4so2255089lbv.33
	for <lttng-dev@lists.lttng.org>; Thu, 06 Feb 2014 20:38:52 -0800 (PST)
In-Reply-To: <CAO_ArvrPPJZ4H_cLx4uFd=wd7XPuq=PDEU_RqU2=3k4Bjx5Czw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1162580383==
Content-Type: multipart/alternative; boundary=001a11c3ee8e17e47904f1c991cf

--001a11c3ee8e17e47904f1c991cf
Content-Type: text/plain; charset=ISO-8859-1

---------- Forwarded message ----------
From: kumar s <skumar.m226@gmail.com>
Date: Fri, Feb 7, 2014 at 10:08 AM
Subject: Re: [lttng-dev] lib_ring_buffer_align error bit-field
'<anonymous>' width not an integer constant
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


Hi,

In bug.h, i removed the underlined lines and left only BUG_ON(condition).
The modules got compiled without any errors, however are there any issues
on removing the underlined lines.

  */
 #define BUILD_RUNTIME_BUG_ON(condition)                                \
        do {                                                    \
*-     *

*          if (__builtin_constant_p(condition))            \
-                       BUILD_BUG_ON(condition);
\-               else          *                                  \
                        BUG_ON(condition);                      \
        } while (0)

thank you
Skumar


On Tue, Feb 4, 2014 at 8:22 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> You might want to request help from Cavium, since they are the one
> supporting
> their toolchain.
>
> It really seems to be a Cavium-specific issue.
>
> Thanks,
>
> Mathieu
>
>
> ------------------------------
>
> *From: *"kumar s" <skumar.m226@gmail.com>
> *To: *"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> *Cc: *lttng-dev@lists.lttng.org
> *Sent: *Tuesday, February 4, 2014 5:13:44 AM
> *Subject: *Re: [lttng-dev] lib_ring_buffer_align error bit-field
> '<anonymous>' width not an integer constant
>
>
> Hi,
>
> The lttng module i use is the latest version, compiler toolchain cannot be
> upgraded since it is provided by Cavium, kernel version is 2.6.32.27.
>
> Is there any change i need to do on lttng modules to build it?
>
> Thank you
> SKumar
>
>
> On Mon, Feb 3, 2014 at 9:20 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> ------------------------------
>>
>> *From: *"kumar s" <skumar.m226@gmail.com>
>> *To: *lttng-dev@lists.lttng.org
>> *Sent: *Tuesday, December 3, 2013 3:20:02 AM
>> *Subject: *[lttng-dev] lib_ring_buffer_align error bit-field
>> '<anonymous>' width not an integer constant
>>
>>
>> Hello,
>>
>> When trying to build lttng modules i am getting this error. Cross
>> compiler for mips and Arch = mips is used in makefile.
>>
>> Linux kernel version 2.6.32.27
>>
>>
>> make -C
>> /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux
>> M=/home/shkumar/lttng-tools/lttngmod/lttng-modules modules ARCH=mips
>> CROSS_COMPILE=mips64-octeon-linux-gnu-
>> make[1]: Entering directory
>> `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
>>   CC [M]
>>  /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o
>> In file included from
>> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/config.h:1,
>>                  from
>> /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer-core.h:35,
>>                  from
>> /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-tracer.h:39,
>>                  from
>> /home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.c:24:
>> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:
>> In function 'lib_ring_buffer_align':
>> /home/shkumar/lttng-tools/lttngmod/lttng-modules/wrapper/ringbuffer/../../lib/ringbuffer/config.h:266:
>> error: bit-field '<anonymous>' width not an integer constant
>> make[2]: ***
>> [/home/shkumar/lttng-tools/lttngmod/lttng-modules/lttng-ring-buffer-client-discard.o]
>> Error 1
>> make[1]: *** [_module_/home/shkumar/lttng-tools/lttngmod/lttng-modules]
>> Error 2
>> make[1]: Leaving directory
>> `/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/linux/kernel_2.6/linux'
>> make: *** [default] Error 2
>>
>> How do i fix this?
>>
>>
>> This is caused by the use of offset_align(), passing incorrect
>> parameters, detected by the compiler:
>>
>> see lttng-modules
>>
>> lib/align.h:
>>
>> #define offset_align(align_drift,
>> alignment)                                   \
>>
>> ({                                                                     \
>>                 BUILD_RUNTIME_BUG_ON((alignment) ==
>> 0                          \
>>                                    || ((alignment) & ((alignment) -
>> 1)));      \
>>                 (((alignment) - (align_drift)) & ((alignment) -
>> 1));           \
>>         })
>>
>> See also lttng-modules
>> lib/bug.h
>>
>> So there are two things that are possible: either the compiler you use
>> does not perform the
>> optimisations that are expected, and therefore triggers the
>> BUILD_BUG_ON() without needing to,
>> or there really is an incorrect value passed to offset_align().
>>
>> Make sure lttng-modules, your compiler toolchain, and your kernel are up
>> to date.
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>> Skumar.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c3ee8e17e47904f1c991cf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote">---------- Forwarded me=
ssage ----------<br>From: <b class=3D"gmail_sendername">kumar s</b> <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:skumar.m226@gmail.com">skumar.m226@gmail.c=
om</a>&gt;</span><br>
Date: Fri, Feb 7, 2014 at 10:08 AM<br>Subject: Re: [lttng-dev] lib_ring_buf=
fer_align error bit-field &#39;&lt;anonymous&gt;&#39; width not an integer =
constant<br>To: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@e=
fficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
<br><br><div dir=3D"ltr"><div><div><div>Hi,<br><br></div>In bug.h, i remove=
d the underlined lines and left only BUG_ON(condition). The modules got com=
piled without any errors, however are there any issues on removing the unde=
rlined lines.<br>

<br>=A0 */<br>=A0#define BUILD_RUNTIME_BUG_ON(condition)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \<br>=A0=A0=A0=A0=A0=A0=A0 do {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \<br><u>-=A0=A0=A0=A0=A0</u><span styl=
e><u>=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (__builtin_constant_p(condition))=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 \<br>

-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BUILD_B=
UG_ON(condition);=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \<br>-=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0</u>=
=A0</span>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BUG_ON(condition);=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \<br>=A0=A0=A0=A0=A0=A0=A0 } whi=
le (0)<br>

<br></div>thank you<br></div>Skumar<br></div><div class=3D"HOEnZb"><div cla=
ss=3D"h5"><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On =
Tue, Feb 4, 2014 at 8:22 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desno=
yers@efficios.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div style=3D"font-size:12pt;font-famil=
y:times new roman,new york,times,serif"><div>You might want to request help=
 from Cavium, since they are the one supporting<br>

</div><div>their toolchain.<br></div><div><br></div><div>It really seems to=
 be a Cavium-specific issue.<br></div><div><br></div><div>Thanks,<br></div>=
<div><br></div><div>Mathieu<br></div><div><br></div><div><br></div><hr>

<blockquote style=3D"padding-left:5px;font-size:12pt;font-style:normal;marg=
in-left:5px;font-family:Helvetica,Arial,sans-serif;text-decoration:none;fon=
t-weight:normal;border-left:2px solid #1010ff"><b>From: </b>&quot;kumar s&q=
uot; &lt;<a href=3D"mailto:skumar.m226@gmail.com" target=3D"_blank">skumar.=
m226@gmail.com</a>&gt;<br>

<b>To: </b>&quot;Mathieu Desnoyers&quot; &lt;<a href=3D"mailto:mathieu.desn=
oyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt=
;<br><b>Cc: </b><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_bla=
nk">lttng-dev@lists.lttng.org</a><br>

<b>Sent: </b>Tuesday, February 4, 2014 5:13:44 AM<br><b>Subject: </b>Re: [l=
ttng-dev] lib_ring_buffer_align error bit-field &#39;&lt;anonymous&gt;&#39;=
 width not an integer constant<div><div><br><div><br></div><div dir=3D"ltr"=
>

<div><div><div><div>Hi,<br><div><br></div></div>The lttng module i use is t=
he latest version, compiler toolchain cannot be upgraded since it is provid=
ed by Cavium, kernel version is 2.6.32.27. <br><div><br></div></div>Is ther=
e any change i need to do on lttng modules to build it?<br>


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


<b>From: </b>&quot;kumar s&quot; &lt;<a href=3D"mailto:skumar.m226@gmail.co=
m" target=3D"_blank">skumar.m226@gmail.com</a>&gt;<br><b>To: </b><a href=3D=
"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.=
org</a><br>


<b>Sent: </b>Tuesday, December 3, 2013 3:20:02 AM<br><b>Subject: </b>[lttng=
-dev] lib_ring_buffer_align error bit-field &#39;&lt;anonymous&gt;&#39; wid=
th not an integer constant<div><div><br><div><br></div><div dir=3D"ltr">


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


=A0=A0=A0=A0=A0=A0=A0 })<br><div><br></div></div><div>See also lttng-module=
s<br></div><div>lib/bug.h<br></div><div><br></div><div>So there are two thi=
ngs that are possible: either the compiler you use does not perform the<br>=
</div><div>

optimisations that are expected, and therefore triggers the BUILD_BUG_ON() =
without needing to,</div>
<div>or there really is an incorrect value passed to offset_align().<br></d=
iv><div><br></div><div>Make sure lttng-modules, your compiler toolchain, an=
d your kernel are up to date.<br></div><div><br></div><div>Thanks,<br>

</div>
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
span><span style=3D"color:#888888" color=3D"#888888"><br></span></span></bl=
ockquote>

<span><span style=3D"color:#888888" color=3D"#888888"><div>
<br><div><br></div></div><div><br></div><div>-- <br></div><div><span></span=
>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" =
target=3D"_blank">http://www.efficios.com</a><span></span><br></div>
</span></span></div></div></blockquote></div><br></div>
</div></div></blockquote><div><div><div><br><br></div><div><br></div><div>-=
- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.=
<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effici=
os.com</a><span name=3D"x"></span><br>

</div></div></div></div></div></blockquote></div><br></div>
</div></div></div><br></div>

--001a11c3ee8e17e47904f1c991cf--


--===============1162580383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1162580383==--
