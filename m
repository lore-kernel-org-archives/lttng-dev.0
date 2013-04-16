From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@polymtl.ca>
Subject: Re: linux 3.4.3 and LTTNG patch files
Date: Tue, 16 Apr 2013 16:22:24 -0400
Message-ID: <CAE_Gge1h+pDe8_fstqdaGs2zZ99kSVriQgMt6k5F263_d5qRHw__9725.82106846875$1366143801$gmane$org@mail.gmail.com>
References: <05E83BDD0E1F054FA73F00F6970F05C6060B7D@CH1PRD0810MB394.namprd08.prod.outlook.com>
	<CAE_Gge2moUyd6vJxWM_7G+AGh4_yV2iyxVQX9naDjoOyX-aTxg@mail.gmail.com>
	<05E83BDD0E1F054FA73F00F6970F05C6060DA6@CH1PRD0810MB394.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0349692270=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1USCOw-00008f-Bp
	for lttng-dev@lists.lttng.org; Tue, 16 Apr 2013 16:22:50 -0400
Received: by mail-oa0-f54.google.com with SMTP id l20so919863oag.27
	for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2013 13:22:44 -0700 (PDT)
In-Reply-To: <05E83BDD0E1F054FA73F00F6970F05C6060DA6@CH1PRD0810MB394.namprd08.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0349692270==
Content-Type: multipart/alternative; boundary=089e0149c552cec81804da80213c

--089e0149c552cec81804da80213c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Hari,

2013/4/16 Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>

>  Could you please let me know if these installation can be done without
> patching the kernel  (unlike lttng 0.x)
>

With LTTng 2.x, you just have to build and install the kernel modules
(lttng-modules) for kernel tracing, you don't need to patch the kernel like
it was necessary for LTTng 0.x.

Sorry again for taking your time. I am just getting started :(
>

No problem, just don't forget to add the lttng-dev list in copy when you
answer !

Rapha=EBl


2013/4/16 Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>

>  Hi Rapha=EBl****
>
> ** **
>
> I have referred incorrectly to 0.x while looking at LTTNG Quick Start
> Guide. ****
>
> ** **
>
> I have now looked at download page http://lttng.org/download****
>
> ** **
>
> Below section and links appears to be relevant for me. ****
> LTTng 2.1 "Basse Messe" <http://lttng.org/version-naming> - Tracer
> toolchain****
>
> *LTTng-tools 2.1.1<http://lttng.org/files/lttng-tools/lttng-tools-2.1.1.t=
ar.bz2>
> *(Changelog)<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob_plain;f=
=3DChangeLog;hb=3Drefs/heads/stable-2.1>
> ****
>
> the trace control client****
>
> *LTTng-modules 2.1.1<http://lttng.org/files/lttng-modules/lttng-modules-2=
.1.1.tar.bz2>
> *(Changelog)<http://git.lttng.org/?p=3Dlttng-modules.git;a=3Dblob_plain;f=
=3DChangeLog;hb=3Drefs/heads/stable-2.1>
> ****
>
> the kernel modules (requires at least Linux 2.6.38)****
>
> *LTTng-UST 2.1.2<http://lttng.org/files/lttng-ust/lttng-ust-2.1.2.tar.bz2=
>
> *(Changelog)<http://git.lttng.org/?p=3Dlttng-ust.git;a=3Dblob_plain;f=3DC=
hangeLog;hb=3Drefs/heads/stable-2.1>
> ****
>
> the userspace tracing library****
>
> ** **
>
> Could you please let me know if these installation can be done without
> patching the kernel  (unlike lttng 0.x)****
>
> ** **
>
> Sorry again for taking your time. I am just getting started :(****
>
> ** **
>
> Regards,****
>
> Hari****
>
> ** **
>
> *From:* nashii@gmail.com [mailto:nashii@gmail.com] *On Behalf Of *Rapha=
=EBl
> Beamonte
> *Sent:* Wednesday, April 17, 2013 1:15 AM
> *To:* Hari Prasad Kalavakunta
> *Cc:* lttng-dev@lists.lttng.org
> *Subject:* Re: [lttng-dev] linux 3.4.3 and LTTNG patch files****
>
> ** **
>
> Hello Hari,
>
> You should look at lttng 2.x instead of lttng 0.x :
> http://lttng.org/download
>
> Rapha=EBl****
>
> 2013/4/16 Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>****
>
> Hello and greetings,****
>
>  ****
>
> Good morning and very quick query.****
>
>  ****
>
> Can I use LTTNG for linux kernel 3.4.3? Could you please let me know if
> LTTNG patch files are available for linux 3.4.3.****
>
>  ****
>
> URL: http://lttng.org/files/lttng/ appears to have patch files for linux
>  2.6.xx. Are there patch files available for linux 3.4.3?****
>
>  ****
>
> Sorry for this trouble :(****
>
>  ****
>
> Regards,****
>
> Hari****
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev****
>
> ** **
>

--089e0149c552cec81804da80213c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Hari,<br><br><div class=3D"gmail_quote">2013/4/16 Hari Prasad Kalavak=
unta <span dir=3D"ltr">&lt;<a href=3D"mailto:Hari.Prasad@radisys.com" targe=
t=3D"_blank">Hari.Prasad@radisys.com</a>&gt;</span><br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">


<div lang=3D"EN-US"><div>






<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#1f497d"></span>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Could you please let me k=
now if these installation can be done without patching the kernel =A0(unlik=
e lttng 0.x)</span></p>


</div></div></blockquote><div><br>
With LTTng 2.x, you just have to build and install the kernel modules=20
(lttng-modules) for kernel tracing, you don&#39;t need to patch the kernel=
=20
like it was necessary for LTTng 0.x.<br>
<br><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;;color:#1f497d"></span>
<blockquote style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote"><p class=3D"MsoNormal"><s=
pan style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-se=
rif&quot;;color:#1f497d">Sorry again for taking your time. I am just gettin=
g started :(</span></p>

</blockquote><br>No problem, just don&#39;t forget to add the lttng-dev lis=
t in copy when you answer !<br><br>
Rapha=EBl<br>
</div></div><br><br><div class=3D"gmail_quote">2013/4/16 Hari Prasad Kalava=
kunta <span dir=3D"ltr">&lt;<a href=3D"mailto:Hari.Prasad@radisys.com" targ=
et=3D"_blank">Hari.Prasad@radisys.com</a>&gt;</span><br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">








<div link=3D"blue" vlink=3D"purple" lang=3D"EN-US">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Hi Rapha=EBl<u></u><u></u=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">I have referred incorrect=
ly to 0.x while looking at LTTNG Quick Start Guide.
<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">I have now looked at down=
load page
</span><a href=3D"http://lttng.org/download" target=3D"_blank">http://lttng=
.org/download</a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&=
quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Below section and links a=
ppears to be relevant for me.
<u></u><u></u></span></p>
<h3 style=3D"margin-bottom:0in;margin-bottom:.0001pt;background:#f4f7e7"><s=
pan style=3D"font-size:11.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-ser=
if&quot;;color:#666666" lang=3D"EN">LTTng 2.1
<a href=3D"http://lttng.org/version-naming" target=3D"_blank">&quot;Basse M=
esse&quot;</a> - Tracer toolchain<u></u><u></u></span></h3>
<p class=3D"MsoNormal" style=3D"line-height:160%;background:#f4f7e7"><b><sp=
an style=3D"font-size:9.0pt;line-height:160%;font-family:&quot;Tahoma&quot;=
,&quot;sans-serif&quot;;color:#666666" lang=3D"EN">LTTng-tools
<a href=3D"http://lttng.org/files/lttng-tools/lttng-tools-2.1.1.tar.bz2" ta=
rget=3D"_blank">2.1.1</a> </span>
</b><span style=3D"font-size:9.0pt;line-height:160%;font-family:&quot;Tahom=
a&quot;,&quot;sans-serif&quot;;color:#666666" lang=3D"EN"><a href=3D"http:/=
/git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob_plain;f=3DChangeLog;hb=3Drefs/=
heads/stable-2.1" target=3D"_blank">(Changelog)</a><u></u><u></u></span></p=
>



<p class=3D"MsoNormal" style=3D"margin-left:.5in;line-height:160%;backgroun=
d:#f4f7e7">
<span style=3D"font-size:9.0pt;line-height:160%;font-family:&quot;Tahoma&qu=
ot;,&quot;sans-serif&quot;;color:#666666" lang=3D"EN">the trace control cli=
ent<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"line-height:160%;background:#f4f7e7"><b><sp=
an style=3D"font-size:9.0pt;line-height:160%;font-family:&quot;Tahoma&quot;=
,&quot;sans-serif&quot;;color:#666666" lang=3D"EN">LTTng-modules
<a href=3D"http://lttng.org/files/lttng-modules/lttng-modules-2.1.1.tar.bz2=
" target=3D"_blank">2.1.1</a>
</span></b><span style=3D"font-size:9.0pt;line-height:160%;font-family:&quo=
t;Tahoma&quot;,&quot;sans-serif&quot;;color:#666666" lang=3D"EN"><a href=3D=
"http://git.lttng.org/?p=3Dlttng-modules.git;a=3Dblob_plain;f=3DChangeLog;h=
b=3Drefs/heads/stable-2.1" target=3D"_blank">(Changelog)</a><u></u><u></u><=
/span></p>



<p class=3D"MsoNormal" style=3D"margin-left:.5in;line-height:160%;backgroun=
d:#f4f7e7">
<span style=3D"font-size:9.0pt;line-height:160%;font-family:&quot;Tahoma&qu=
ot;,&quot;sans-serif&quot;;color:#666666" lang=3D"EN">the kernel modules (r=
equires at least Linux 2.6.38)<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"line-height:160%;background:#f4f7e7"><b><sp=
an style=3D"font-size:9.0pt;line-height:160%;font-family:&quot;Tahoma&quot;=
,&quot;sans-serif&quot;;color:#666666" lang=3D"EN">LTTng-UST
<a href=3D"http://lttng.org/files/lttng-ust/lttng-ust-2.1.2.tar.bz2" target=
=3D"_blank">2.1.2</a> </span>
</b><span style=3D"font-size:9.0pt;line-height:160%;font-family:&quot;Tahom=
a&quot;,&quot;sans-serif&quot;;color:#666666" lang=3D"EN"><a href=3D"http:/=
/git.lttng.org/?p=3Dlttng-ust.git;a=3Dblob_plain;f=3DChangeLog;hb=3Drefs/he=
ads/stable-2.1" target=3D"_blank">(Changelog)</a><u></u><u></u></span></p>



<p class=3D"MsoNormal" style=3D"margin-left:.5in;line-height:160%;backgroun=
d:#f4f7e7">
<span style=3D"font-size:9.0pt;line-height:160%;font-family:&quot;Tahoma&qu=
ot;,&quot;sans-serif&quot;;color:#666666" lang=3D"EN">the userspace tracing=
 library<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Could you please let me k=
now if these installation can be done without patching the kernel =A0(unlik=
e lttng 0.x)<u></u><u></u></span></p>



<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Sorry again for taking yo=
ur time. I am just getting started :(<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Regards,<u></u><u></u></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Hari<u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> <a href=
=3D"mailto:nashii@gmail.com" target=3D"_blank">nashii@gmail.com</a> [mailto=
:<a href=3D"mailto:nashii@gmail.com" target=3D"_blank">nashii@gmail.com</a>=
]
<b>On Behalf Of </b>Rapha=EBl Beamonte<br>
<b>Sent:</b> Wednesday, April 17, 2013 1:15 AM<br>
<b>To:</b> Hari Prasad Kalavakunta<br>
<b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br>
<b>Subject:</b> Re: [lttng-dev] linux 3.4.3 and LTTNG patch files<u></u><u>=
</u></span></p><div><div>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Hello Hari,<br>
<br>
You should look at lttng 2.x instead of lttng 0.x : <a href=3D"http://lttng=
.org/download" target=3D"_blank">
http://lttng.org/download</a><br>
<br>
Rapha=EBl<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">2013/4/16 Hari Prasad Kalavakunta &lt;<a href=3D"mai=
lto:Hari.Prasad@radisys.com" target=3D"_blank">Hari.Prasad@radisys.com</a>&=
gt;<u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Hello and greetings,<u></u><u></u></p>
<p class=3D"MsoNormal">=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Good morning and very quick query.<u></u><u></u></p>
<p class=3D"MsoNormal">=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Can I use LTTNG for linux kernel 3.4.3? Could you pl=
ease let me know if LTTNG patch files are available for linux 3.4.3.<u></u>=
<u></u></p>
<p class=3D"MsoNormal">=A0<u></u><u></u></p>
<p class=3D"MsoNormal">URL:
<a href=3D"http://lttng.org/files/lttng/" target=3D"_blank">http://lttng.or=
g/files/lttng/</a> appears to have patch files for linux =A02.6.xx. Are the=
re patch files available for linux 3.4.3?<u></u><u></u></p>
<p class=3D"MsoNormal">=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Sorry for this trouble :(<u></u><u></u></p>
<p class=3D"MsoNormal">=A0<u></u><u></u></p>
<p class=3D"MsoNormal">Regards,<u></u><u></u></p>
<p class=3D"MsoNormal">Hari<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
u></u><u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
</div></div></div>
</div>

</blockquote></div><br>

--089e0149c552cec81804da80213c--


--===============0349692270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0349692270==--
