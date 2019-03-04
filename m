From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracing directly into shared memory
Date: Mon, 4 Mar 2019 11:00:49 -0500 (EST)
Message-ID: <2083651965.623.1551715249037.JavaMail.zimbra__11977.7878209547$1551715283$gmane$org@efficios.com>
References: <54c5b5d42fb8448298afc17af0513b6b@HIMDWSMB04.ad.harman.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8816761086392749005=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44ClB10ZK9z12Q5
 for <lttng-dev@lists.lttng.org>; Mon,  4 Mar 2019 11:00:56 -0500 (EST)
In-Reply-To: <54c5b5d42fb8448298afc17af0513b6b@HIMDWSMB04.ad.harman.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Thomas Schickentanz <thomas.schickentanz@harman.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8816761086392749005==
Content-Type: multipart/alternative;
	boundary="=_7281c42d-bcc7-4b94-b904-bc865ac381a4"

--=_7281c42d-bcc7-4b94-b904-bc865ac381a4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Mar 4, 2019, at 4:28 AM, Thomas Schickentanz <thomas.schickentanz@=
harman.com> wrote:=20

> Hi all,

> My idea is to pre-allocate memory on system startup which can later be us=
ed by
> lttng for tracing. It should work like flight recorder mode without extra=
cting
> data from ringbuffers to trace file while recording data. Data extraction=
 of
> shm ringbuffers should be done when recording has been finished.

> As per documention with option `--shm-path=E2=80=98 ringbuffer for tracin=
g can be
> created in shared memory. With lttng-crash data can be extracted from
> ringbuffer.

> Can this option be used with shared memory in volatile memory (default ra=
m),
> too? And is it possible to record kernel space traces with this option?

> I tried

> lttng create testshm --shm-path=3D/dev/shm --snapshot

> lttng enable-channel c0 -s testshm -k

> lttng enable-event -s testshm -c c0 -k -a

> lttng start

> lttng stop

> lttng-crash -extract=3D/home/test /dev/shm

> With lttng and lttng-crash everything seems to work fine (no error messag=
es).

> However the extract folder keeps empty.

> Has someone researched into this option and can help to clarify the point=
s?

Hi Thomas,=20

About "--shm-path" and lttng-crash, those are discussed here: [ https://ltt=
ng.org/docs/v2.10/#doc-persistent-memory-file-systems | https://lttng.org/d=
ocs/v2.10/#doc-persistent-memory-file-systems ]=20

I'm not sure I completely understand your use-case and whether your intent =
is to extract trace data after a=20
system crash or if the "snapshot" mode is enough for your needs.=20

Note that the "shm-path" option only applies to UST (user-space) traces at =
the moment. It has not been implemented=20
for kernel tracing yet.=20

The way we typically use it for extraction of trace data from user-space wh=
en a system crashes is to use the pmem driver to=20
create a block device out of a range of the system memory, and then use ext=
2 or ext4 with the DAX mount option to ensure=20
the filesystem bypasses the page cache.=20

Then we ensure that kexec is used to boot a new kernel on crash, or make su=
re the BIOS does not erase the=20
memory content on soft reboot, which gives access to the shm-path buffers a=
fter crash/reboot.=20

We don't usually use /dev/shm as an argument to --shm-path. This path is no=
rmally used to hold POSIX shared memory=20
files. I would expect a different mount point path as argument to --shm-pat=
h which points to a DAX-enabled filesystem=20
backed by a PMEM block device.=20

Thanks,=20

Mathieu=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_7281c42d-bcc7-4b94-b904-bc865ac381a4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:#0563C1;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:#954F72;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri",sans-serif;
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal;
=09text-decoration:none none;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
=09{page:WordSection1;}
--></style></div><div><br data-mce-bogus=3D"1"></div><div><span id=3D"zwchr=
" data-marker=3D"__DIVIDER__">----- On Mar 4, 2019, at 4:28 AM, Thomas Schi=
ckentanz &lt;thomas.schickentanz@harman.com&gt; wrote:<br></span></div><div=
 data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid=
 #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fon=
t-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;=
font-size:12pt;"><div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt">Hi all,</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt" lang=3D"EN-US">My i=
dea is to pre-allocate memory on system startup which can later be used by =
lttng for tracing. It should work like flight recorder mode without extract=
ing data from ringbuffers to trace file
 while recording data. Data extraction of shm ringbuffers should be done wh=
en recording has been finished.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt" lang=3D"EN-US">As p=
er documention with option
</span><span style=3D"font-size:12.0pt;font-family:&quot;Courier New&quot;"=
 lang=3D"EN-US">`--shm-path=E2=80=98</span><span style=3D"font-size:12.0pt"=
 lang=3D"EN-US"> ringbuffer for tracing can be created in shared memory. Wi=
th
</span><span style=3D"font-size:12.0pt;font-family:&quot;Courier New&quot;"=
 lang=3D"EN-US">lttng-crash</span><span style=3D"font-size:12.0pt" lang=3D"=
EN-US"> data can be extracted from ringbuffer.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt" lang=3D"EN-US">Can =
this option be used with shared memory in volatile memory (default ram), to=
o? And is it possible to record kernel space traces with this option?</span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt" lang=3D"EN-US">I tr=
ied </span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;" lang=3D"EN-US">lttng create testshm --shm-path=3D/dev/shm =
--snapshot</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;" lang=3D"EN-US">lttng enable-channel c0 -s testshm -k</span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;" lang=3D"EN-US">lttng enable-event -s testshm -c c0 -k -a</=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;" lang=3D"EN-US">lttng start</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;" lang=3D"EN-US">lttng stop</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;" lang=3D"EN-US">lttng-crash -extract=3D/home/test /dev/shm<=
/span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt" lang=3D"EN-US">With=
 lttng and lttng-crash everything seems to work fine (no error messages).</=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt" lang=3D"EN-US">Howe=
ver the extract folder keeps empty.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt" lang=3D"EN-US">Has =
someone researched into this option and can help to clarify the points?</sp=
an></p></div></blockquote><div>Hi Thomas,<br></div><div><br data-mce-bogus=
=3D"1"></div><div>About "--shm-path" and lttng-crash, those are discussed h=
ere: <a href=3D"https://lttng.org/docs/v2.10/#doc-persistent-memory-file-sy=
stems">https://lttng.org/docs/v2.10/#doc-persistent-memory-file-systems</a>=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I'm=
 not sure I completely understand your use-case and whether your intent is =
to extract trace data after a<br data-mce-bogus=3D"1"></div><div>system cra=
sh or if the "snapshot" mode is enough for your needs.<br data-mce-bogus=3D=
"1"></div><div><br data-mce-bogus=3D"1"></div><div>Note that the "shm-path"=
 option only applies to UST (user-space) traces at the moment. It has not b=
een implemented<br data-mce-bogus=3D"1"></div><div>for kernel tracing yet.<=
br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>The =
way we typically use it for extraction of trace data from user-space when a=
 system crashes is to use the pmem driver to</div><div>create a block devic=
e out of a range of the system memory, and then use ext2 or ext4 with the D=
AX mount option to ensure</div><div>the filesystem bypasses the page cache.=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>The=
n we ensure that kexec is used to boot a new kernel on crash, or make sure =
the BIOS does not erase the<br data-mce-bogus=3D"1"></div><div>memory conte=
nt on soft reboot, which gives access to the shm-path buffers after crash/r=
eboot.</div><div><br data-mce-bogus=3D"1"></div><div>We don't usually use /=
dev/shm as an argument to --shm-path. This path is normally used to hold PO=
SIX shared memory</div><div>files. I would expect a different mount point p=
ath as argument to --shm-path which points to a DAX-enabled filesystem</div=
><div>backed by a PMEM block device.<br data-mce-bogus=3D"1"></div><div><br=
 data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div></div><div><br data-mce-bogus=3D"1"></d=
iv><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br=
>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_7281c42d-bcc7-4b94-b904-bc865ac381a4--

--===============8816761086392749005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8816761086392749005==--
