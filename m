From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Need help on LTTNG
Date: Wed, 16 Apr 2014 13:00:34 +0000 (UTC)
Message-ID: <861834225.2317.1397653234031.JavaMail.zimbra__8457.09568025104$1397653311$gmane$org@efficios.com>
References: <4506BB291C8828478C1C5CA492972AB01C129FB5@G6W2500.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1033301747=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WaPSD-0000ta-AQ
 for lttng-dev@lists.lttng.org; Wed, 16 Apr 2014 09:00:47 -0400
In-Reply-To: <4506BB291C8828478C1C5CA492972AB01C129FB5@G6W2500.americas.hpqcorp.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Shilpa Kumari (HPSD/VDU/Avatar)" <shilpakumari.pv@hp.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1033301747==
Content-Type: multipart/alternative;
	boundary="----=_Part_2316_403431172.1397653234029"

------=_Part_2316_403431172.1397653234029
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Shilpa Kumari (HPSD/VDU/Avatar)" <shilpakumari.pv@hp.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Shilpa Kumari (HPSD/VDU/Avatar)" <shilpakumari.pv@hp.com>
> Sent: Tuesday, April 15, 2014 1:27:47 AM
> Subject: [lttng-dev] Need help on LTTNG

> Hello,

> I am trying to use LTTNG on centos (2.6.32). I have applied the given pat=
ch
> and rebuilt a kernel.

> Still I am unable to build the lltng-modules.

> [root@million lttng-modules-2.4.0]# uname -r

> 2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64

> Below is the compiler error I am getting,

> [root@million lttng-modules-2.4.0]# make

> make -C /lib/modules/2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64/bu=
ild
> M=3D/root/LTTNG/lttng-modules-2.4.0 modules

> make[1]: Entering directory
> `/usr/src/kernels/2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64'

> CC [M] /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-discard.o

> CC [M] /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-overwrite=
.o

> CC [M] /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-metadata-client.=
o

> CC [M]
> /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-mmap-discard.o

> CC [M]
> /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-mmap-overwrite.o

> CC [M]
> /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-metadata-mmap-client.o

> CC [M] /root/LTTNG/lttng-modules-2.4.0/lttng-statedump-impl.o

> In file included from
> /root/LTTNG/lttng-modules-2.4.0/lttng-statedump-impl.c:55:

> /root/LTTNG/lttng-modules-2.4.0/wrapper/tracepoint.h: In function
> =C3=A2wrapper_lttng_fixup_sig=C3=A2:

> /root/LTTNG/lttng-modules-2.4.0/wrapper/tracepoint.h:76: error: =C3=A2str=
uct
> module=C3=A2 has no member named =C3=A2sig_ok=C3=A2

> make[2]: *** [/root/LTTNG/lttng-modules-2.4.0/lttng-statedump-impl.o] Err=
or 1

> make[1]: *** [_module_/root/LTTNG/lttng-modules-2.4.0] Error 2

> make[1]: Leaving directory
> `/usr/src/kernels/2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64'

> make: *** [default] Error 2

That's weird. The sig_ok field of struct module should only be used when=20
CONFIG_MODULE_SIG is defined. This looks like a kernel config mismatch.=20
You might want to ensure you use KERNELDIR=3Dpath_to_kernel_source make=20
to build lttng-modules.=20

> [root@million lttng-modules-2.4.0]#

> Patches provided In lttng-modules/linux-patches/

> backport-kallsym-sym-2.6.32.patch =C3=9F got easily applied with patch co=
mmand

> backport-splice-sym-2.6.32-34.patch =C3=9F got easily applied with patch =
command

> backport-tracepoint-data-2.6.32-33.patch =C3=9F Conflicts were found, and=
 I
> manually edited tracepoint.h file.

> Kernel was built by disabling =E2=80=9CCONFIG_MODULE_SIG=E2=80=9D.

Hrm, is this a kind of Frankeinstein kernel ? Arguably, the RHEL6-based ker=
nels has a set=20
of features taken from kernels between 2.6.32 and 2.6.35, but even at 2.6.3=
5, the kernel=20
does not appear to implement CONFIG_MODULE_SIG. This makes me wonder why=20
CONFIG_MODULE_SIG appears in the .config file at all.=20

Thanks,=20

Mathieu=20

> Could you please kindly guide me on this issue. Appreciate your help very
> much.

> Please do let me know, if I need to provide any more info on this.

> Thanks and regards,

> Shilpa Kumari.P.V

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_2316_403431172.1397653234029
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Shilpa Kumari (HPSD/VD=
U/Avatar)" &lt;shilpakumari.pv@hp.com&gt;<br><b>To: </b>lttng-dev@lists.ltt=
ng.org<br><b>Cc: </b>"Shilpa Kumari (HPSD/VDU/Avatar)" &lt;shilpakumari.pv@=
hp.com&gt;<br><b>Sent: </b>Tuesday, April 15, 2014 1:27:47 AM<br><b>Subject=
: </b>[lttng-dev] Need help on LTTNG<br><div><br></div><style><!--

@font-face
=09{font-family:Wingdings;
=09panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal">Hello,</p><p =
class=3D"MsoNormal">I am trying to use LTTNG on centos (2.6.32). I have app=
lied the given patch and rebuilt a kernel.</p><p class=3D"MsoNormal">Still =
I am unable to build the lltng-modules.</p><p class=3D"MsoNormal">[root@mil=
lion lttng-modules-2.4.0]# uname -r</p><p class=3D"MsoNormal"><b>2.6.32-431=
.5.1.el6.hpsp.centos.LTTNG.18852.x86_64</b></p><p class=3D"MsoNormal">Below=
 is the compiler error I am getting,</p><p class=3D"MsoNormal">[root@millio=
n lttng-modules-2.4.0]# make</p><p class=3D"MsoNormal">make -C /lib/modules=
/2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64/build M=3D/root/LTTNG/lt=
tng-modules-2.4.0 modules</p><p class=3D"MsoNormal">make[1]: Entering direc=
tory `/usr/src/kernels/2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18852.x86_64'</=
p><p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.=
0/lttng-ring-buffer-client-discard.o</p><p class=3D"MsoNormal">&nbsp; CC [M=
]&nbsp; /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-overwrite.=
o</p><p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2=
.4.0/lttng-ring-buffer-metadata-client.o</p><p class=3D"MsoNormal">&nbsp; C=
C [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-client-mmap-d=
iscard.o</p><p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-mo=
dules-2.4.0/lttng-ring-buffer-client-mmap-overwrite.o</p><p class=3D"MsoNor=
mal">&nbsp; CC [M]&nbsp; /root/LTTNG/lttng-modules-2.4.0/lttng-ring-buffer-=
metadata-mmap-client.o</p><p class=3D"MsoNormal">&nbsp; CC [M]&nbsp; /root/=
LTTNG/lttng-modules-2.4.0/lttng-statedump-impl.o</p><p class=3D"MsoNormal">=
In file included from /root/LTTNG/lttng-modules-2.4.0/lttng-statedump-impl.=
c:55:</p><p class=3D"MsoNormal">/root/LTTNG/lttng-modules-2.4.0/wrapper/tra=
cepoint.h: In function =C3=A2wrapper_lttng_fixup_sig=C3=A2:</p><p class=3D"=
MsoNormal">/root/LTTNG/lttng-modules-2.4.0/wrapper/tracepoint.h:76: error:
<b>=C3=A2struct module=C3=A2 has no member named =C3=A2sig_ok=C3=A2</b></p>=
<p class=3D"MsoNormal">make[2]: *** [/root/LTTNG/lttng-modules-2.4.0/lttng-=
statedump-impl.o] Error 1</p><p class=3D"MsoNormal">make[1]: *** [_module_/=
root/LTTNG/lttng-modules-2.4.0] Error 2</p><p class=3D"MsoNormal">make[1]: =
Leaving directory `/usr/src/kernels/2.6.32-431.5.1.el6.hpsp.centos.LTTNG.18=
852.x86_64'</p><p class=3D"MsoNormal">make: *** [default] Error 2</p></div>=
</blockquote><div><br></div><div>That's weird. The sig_ok field of struct m=
odule should only be used when<br></div><div>CONFIG_MODULE_SIG is defined. =
This looks like a kernel config mismatch.<br></div><div>You might want to e=
nsure you use KERNELDIR=3Dpath_to_kernel_source make<br></div><div>to build=
 lttng-modules.<br></div><div><br></div><blockquote style=3D"border-left:2p=
x solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt;"><div class=3D"WordSection1"><p class=3D"MsoNormal">=
[root@million lttng-modules-2.4.0]#</p><p class=3D"MsoNormal">Patches provi=
ded In lttng-modules/linux-patches/</p><p class=3D"MsoNormal">backport-kall=
sym-sym-2.6.32.patch &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"font-family:Wingdings">=C3=9F<=
/span> got easily applied with patch command</p><p class=3D"MsoNormal">back=
port-splice-sym-2.6.32-34.patch &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"font-family:Wingdings">=C3=9F</=
span> got easily applied with patch command</p><p class=3D"MsoNormal">backp=
ort-tracepoint-data-2.6.32-33.patch&nbsp;&nbsp;&nbsp; &nbsp;<span style=3D"=
font-family:Wingdings">=C3=9F</span> &nbsp;Conflicts were found, and I manu=
ally edited tracepoint.h file.</p><p class=3D"MsoNormal">Kernel was built b=
y disabling =E2=80=9CCONFIG_MODULE_SIG=E2=80=9D. &nbsp;</p></div></blockquo=
te><div>Hrm, is this a kind of Frankeinstein kernel ? Arguably, the RHEL6-b=
ased kernels has a set<br></div><div>of features taken from kernels between=
 2.6.32 and 2.6.35, but even at 2.6.35, the kernel<br></div><div>does not a=
ppear to implement CONFIG_MODULE_SIG. This makes me wonder why<br></div><di=
v>CONFIG_MODULE_SIG appears in the .config file at all.<br></div><div><br><=
/div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></=
div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padd=
ing-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoratio=
n:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=
=3D"WordSection1"><p class=3D"MsoNormal">Could you please kindly guide me o=
n this issue. Appreciate your help very much.</p><p class=3D"MsoNormal">Ple=
ase do let me know, if I need to provide any more info on this.
</p><p class=3D"MsoNormal">Thanks and regards,</p><p class=3D"MsoNormal">Sh=
ilpa Kumari.P.V</p></div><br>______________________________________________=
_<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></d=
iv><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu De=
snoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span>=
<br></div></div></body></html>
------=_Part_2316_403431172.1397653234029--


--===============1033301747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1033301747==--
