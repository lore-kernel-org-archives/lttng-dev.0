From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracing directly into shared memory
Date: Tue, 5 Mar 2019 11:24:12 -0500 (EST)
Message-ID: <1217925359.1713.1551803052855.JavaMail.zimbra__9679.88232603005$1551803087$gmane$org@efficios.com>
References: <54c5b5d42fb8448298afc17af0513b6b@HIMDWSMB04.ad.harman.com>
 <2083651965.623.1551715249037.JavaMail.zimbra@efficios.com>
 <387583b7903a4b57bc56c89410fe3c0d@HIMDWSMB04.ad.harman.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5201394111716759863=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44DMfX6bMGzg0c
 for <lttng-dev@lists.lttng.org>; Tue,  5 Mar 2019 11:24:20 -0500 (EST)
In-Reply-To: <387583b7903a4b57bc56c89410fe3c0d@HIMDWSMB04.ad.harman.com>
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

--===============5201394111716759863==
Content-Type: multipart/alternative;
	boundary="=_adb47d24-e896-4c9b-96da-8acceaca1c59"

--=_adb47d24-e896-4c9b-96da-8acceaca1c59
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Mar 5, 2019, at 4:43 AM, Thomas Schickentanz <thomas.schickentanz@=
harman.com> wrote:=20

> Hi Mathieu,

> Thanks for clarifying the restrictions of =E2=80=98shm-path=E2=80=99 opti=
on!

> Our purpose is to use exclusively reserved memory for tracing. Our custom=
ers
> request a certain amount of free memory on the system for future developm=
ent.
> In development stage chunks of this =E2=80=9Cfree=E2=80=9D memory are gra=
bbed by the
> applications and tracing lacks memory. We want to allocate this =E2=80=9C=
free=E2=80=9D memory
> in an early boot stage to ensure that we get the amount of memory we need=
 for
> tracing. E.g. if we have reserved 512 Mbyte of memory, we know that we ca=
n
> start lttng at a later point of time with 16 buffers of 4 Mbyte on a 8 co=
re
> system. But this works only, if we can provide the previously reserved me=
mory
> to lttng for buffer allocation.

> Is there some general concern about using POSIX shared memory for buffers=
 in
> kernel tracing mode (apart from performance reasons)?

The kernel tracer does not use POSIX shared memory at all at the moment. On=
ly lttng-ust does. lttng-modules allocates memory for its buffers=20
directly from the kernel page allocator all by itself.=20

Switching to a design where an application process (kernel consumerd) would=
 map memory associated to files on a filesystem, and then=20
hand over that memory to the kernel so it can trace there would be a rather=
 large design change.=20

For the needs you have, I think a simpler option would be to implement a ne=
w setup argument to lttng-modules so it can reserve some memory=20
from the page allocator when the lttng modules are loaded (e.g. at system s=
tart), and then use that pre-reserved pool to allocate the buffers=20
when a tracing session is created. All this would need to be NUMA-aware, wi=
th e.g. one pool per NUMA node.=20

This would be a new feature request against lttng-modules.=20

In order to reserve memory for lttng-ust, you could ensure your /dev/shm mo=
untpoint is a tmpfs filesystem which contains enough memory=20
to hold the lttng-ust buffers. An alternative there would be to use pmem + =
dax to hold the buffers with the --shm-path option.=20

Thanks,=20

Mathieu=20

> I used lttng-crash only for testing, because I wanted to verify, if traci=
ng data
> is available from provided shared memory. If this is ensured, I agree wit=
h you,
> that =E2=80=98lttng snapshot=E2=80=99 can do the work.

> Regards,

> Thomas

> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Sent: Montag, 4. M=C3=A4rz 2019 17:01
> To: Schickentanz, Thomas <thomas.schickentanz@harman.com>
> Cc: lttng-dev <lttng-dev@lists.lttng.org>
> Subject: [EXTERNAL] Re: [lttng-dev] Tracing directly into shared memory

> ----- On Mar 4, 2019, at 4:28 AM, Thomas Schickentanz < [
> mailto:thomas.schickentanz@harman.com | thomas.schickentanz@harman.com ] =
>
> wrote:

>> Hi all,

>> My idea is to pre-allocate memory on system startup which can later be u=
sed by
>> lttng for tracing. It should work like flight recorder mode without extr=
acting
>> data from ringbuffers to trace file while recording data. Data extractio=
n of
>> shm ringbuffers should be done when recording has been finished.

>> As per documention with option `--shm-path=E2=80=98 ringbuffer for traci=
ng can be
>> created in shared memory. With lttng-crash data can be extracted from
>> ringbuffer.

>> Can this option be used with shared memory in volatile memory (default r=
am),
>> too? And is it possible to record kernel space traces with this option?

>> I tried

>> lttng create testshm --shm-path=3D/dev/shm --snapshot

>> lttng enable-channel c0 -s testshm -k

>> lttng enable-event -s testshm -c c0 -k -a

>> lttng start

>> lttng stop

>> lttng-crash -extract=3D/home/test /dev/shm

>> With lttng and lttng-crash everything seems to work fine (no error messa=
ges).

>> However the extract folder keeps empty.

>> Has someone researched into this option and can help to clarify the poin=
ts?
> Hi Thomas,

> About "--shm-path" and lttng-crash, those are discussed here: [
> https://clicktime.symantec.com/3YZ15pbJVSD47yeXxhXiwqE7Vc?u=3Dhttps%3A%2F=
%2Flttng.org%2Fdocs%2Fv2.10%2F%23doc-persistent-memory-file-systems
> |
> https://lttng.org/docs/v2.10/#doc-persistent-memory-file-systems ]

> I'm not sure I completely understand your use-case and whether your inten=
t is to
> extract trace data after a

> system crash or if the "snapshot" mode is enough for your needs.

> Note that the "shm-path" option only applies to UST (user-space) traces a=
t the
> moment. It has not been implemented

> for kernel tracing yet.

> The way we typically use it for extraction of trace data from user-space =
when a
> system crashes is to use the pmem driver to

> create a block device out of a range of the system memory, and then use e=
xt2 or
> ext4 with the DAX mount option to ensure

> the filesystem bypasses the page cache.

> Then we ensure that kexec is used to boot a new kernel on crash, or make =
sure
> the BIOS does not erase the

> memory content on soft reboot, which gives access to the shm-path buffers=
 after
> crash/reboot.

> We don't usually use /dev/shm as an argument to --shm-path. This path is
> normally used to hold POSIX shared memory

> files. I would expect a different mount point path as argument to --shm-p=
ath
> which points to a DAX-enabled filesystem

> backed by a PMEM block device.

> Thanks,

> Mathieu

> --

> Mathieu Desnoyers
> EfficiOS Inc.
> [
> https://clicktime.symantec.com/32vnSPUsVCfHCkkwoyPymVx7Vc?u=3Dhttp%3A%2F%=
2Fwww.efficios.com
> |
> https://clicktime.symantec.com/32vnSPUsVCfHCkkwoyPymVx7Vc?u=3Dhttp%3A%2F%=
2Fwww.efficios.com
> ]

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_adb47d24-e896-4c9b-96da-8acceaca1c59
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
p.msonormal0, li.msonormal0, div.msonormal0
=09{mso-style-name:msonormal;
=09mso-margin-top-alt:auto;
=09margin-right:0cm;
=09mso-margin-bottom-alt:auto;
=09margin-left:0cm;
=09font-size:12.0pt;
=09font-family:"Times New Roman",serif;}
span.EmailStyle18
=09{mso-style-type:personal;
=09font-family:"Calibri",sans-serif;
=09color:windowtext;
=09font-weight:normal;
=09font-style:normal;
=09text-decoration:none none;}
span.EmailStyle19
=09{mso-style-type:personal-reply;
=09font-family:"Calibri",sans-serif;
=09color:#1F497D;
=09font-weight:normal;
=09font-style:normal;
=09text-decoration:none none;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
=09{page:WordSection1;}
--></style></div><div><br></div><div><br></div><div><span id=3D"zwchr" data=
-marker=3D"__DIVIDER__">----- On Mar 5, 2019, at 4:43 AM, Thomas Schickenta=
nz &lt;thomas.schickentanz@harman.com&gt; wrote:<br></span></div><div data-=
marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010=
FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt;">






<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:#1F497D">Hi Ma=
thieu,</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:#1F497D" lang=
=3D"EN-US">Thanks for clarifying the restrictions of =E2=80=98shm-path=E2=
=80=99 option!</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:#1F497D" lang=
=3D"EN-US">Our purpose is to use exclusively reserved memory for tracing. O=
ur customers request a certain amount of free memory on the system for futu=
re development. In development stage chunks
 of this =E2=80=9Cfree=E2=80=9D memory are grabbed by the applications and =
tracing lacks memory. We want to allocate this =E2=80=9Cfree=E2=80=9D memor=
y in an early boot stage to ensure that we get the amount of memory we need=
 for tracing. E.g. if we have reserved 512 Mbyte of memory, we know
 that we can start lttng at a later point of time with 16 buffers of 4 Mbyt=
e on a 8 core system. But this works only, if we can provide the previously=
 reserved memory to lttng for buffer allocation.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:#1F497D" lang=
=3D"EN-US">Is there some general concern about using POSIX shared memory fo=
r buffers in kernel tracing mode (apart from performance reasons)?
</span></p></div></blockquote><div>The kernel tracer does not use POSIX sha=
red memory at all at the moment. Only lttng-ust does. lttng-modules allocat=
es memory for its buffers</div><div>directly from the kernel page allocator=
 all by itself.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><div>Switching to a design where an application process (kernel cons=
umerd) would map memory associated to files on a filesystem, and then<br da=
ta-mce-bogus=3D"1"></div><div>hand over that memory to the kernel so it can=
 trace there would be a rather large design change.<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>For the needs you have, I t=
hink a simpler option would be to implement a new setup argument to lttng-m=
odules so it can reserve some memory<br data-mce-bogus=3D"1"></div><div>fro=
m the page allocator when the lttng modules are loaded (e.g. at system star=
t), and then use that pre-reserved pool to allocate the buffers<br data-mce=
-bogus=3D"1"></div><div>when a tracing session is created. All this would n=
eed to be NUMA-aware, with e.g. one pool per NUMA node.<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>This would be a new f=
eature request against lttng-modules.<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>In order to reserve memory for lttng-ust,=
 you could ensure your /dev/shm mountpoint is a tmpfs filesystem which cont=
ains enough memory<br data-mce-bogus=3D"1"></div><div>to hold the lttng-ust=
 buffers. An alternative there would be to use pmem + dax to hold the buffe=
rs with the --shm-path option.</div><div><br data-mce-bogus=3D"1"></div><di=
v>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div>Mathieu</div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSection1">

<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:#1F497D" lang=
=3D"EN-US">I used lttng-crash only for testing, because I wanted to verify,=
 if tracing data is available from provided shared memory. If this is ensur=
ed, I agree with you, that =E2=80=98lttng snapshot=E2=80=99
 can do the work.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:#1F497D" lang=
=3D"EN-US">Regards,</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:#1F497D" lang=
=3D"EN-US">Thomas
</span></p>

<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span style=3D"mso-fareast-language:DE" lang=3D"E=
N-US">From:</span></b><span style=3D"mso-fareast-language:DE" lang=3D"EN-US=
"> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;
<br><b>Sent:</b> Montag, 4. M=C3=A4rz 2019 17:01<br><b>To:</b> Schickentanz=
, Thomas &lt;thomas.schickentanz@harman.com&gt;<br><b>Cc:</b> lttng-dev &lt=
;lttng-dev@lists.lttng.org&gt;<br><b>Subject:</b> [EXTERNAL] Re: [lttng-dev=
] Tracing directly into shared memory</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">----- On Mar 4, 2=
019, at 4:28 AM, Thomas Schickentanz &lt;<a href=3D"mailto:thomas.schickent=
anz@harman.com" target=3D"_blank">thomas.schickentanz@harman.com</a>&gt;
 wrote:<br><br></span></p>
</div>
<div>
<blockquote style=3D"border:none;border-left:solid #1010FF 1.5pt;padding:0c=
m 0cm 0cm 4.0pt;margin-left:3.75pt;margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi all,=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black" lang=3D=
"EN-US">My idea is to pre-allocate memory on system startup which can later=
 be used by lttng for tracing. It should work like flight recorder mode wit=
hout extracting data from ringbuffers
 to trace file while recording data. Data extraction of shm ringbuffers sho=
uld be done when recording has been finished.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black" lang=3D=
"EN-US">As per documention with option
</span><span style=3D"font-size:12.0pt;font-family:&quot;Courier New&quot;;=
color:black" lang=3D"EN-US">`--shm-path=E2=80=98</span><span style=3D"font-=
size:12.0pt;color:black" lang=3D"EN-US"> ringbuffer for tracing can be crea=
ted in shared memory. With
</span><span style=3D"font-size:12.0pt;font-family:&quot;Courier New&quot;;=
color:black" lang=3D"EN-US">lttng-crash</span><span style=3D"font-size:12.0=
pt;color:black" lang=3D"EN-US"> data can be extracted from ringbuffer.</spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black" lang=3D=
"EN-US">Can this option be used with shared memory in volatile memory (defa=
ult ram), too? And is it possible to record kernel space traces with this o=
ption?</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black" lang=3D=
"EN-US">I tried
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;;color:black" lang=3D"EN-US">lttng create testshm --shm-path=
=3D/dev/shm --snapshot</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;;color:black" lang=3D"EN-US">lttng enable-channel c0 -s test=
shm -k</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;;color:black" lang=3D"EN-US">lttng enable-event -s testshm -=
c c0 -k -a</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;;color:black" lang=3D"EN-US">lttng start</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;;color:black" lang=3D"EN-US">lttng stop</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Co=
urier New&quot;;color:black" lang=3D"EN-US">lttng-crash -extract=3D/home/te=
st /dev/shm</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black" lang=3D=
"EN-US">With lttng and lttng-crash everything seems to work fine (no error =
messages).</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black" lang=3D=
"EN-US">However the extract folder keeps empty.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black" lang=3D=
"EN-US">Has someone researched into this option and can help to clarify the=
 points?</span></p>
</blockquote>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">Hi Thomas,</span>=
</p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">About "--shm-path=
" and lttng-crash, those are discussed here:
<a href=3D"https://clicktime.symantec.com/3YZ15pbJVSD47yeXxhXiwqE7Vc?u=3Dht=
tps%3A%2F%2Flttng.org%2Fdocs%2Fv2.10%2F%23doc-persistent-memory-file-system=
s" target=3D"_blank">
https://lttng.org/docs/v2.10/#doc-persistent-memory-file-systems</a></span>=
<br data-mce-bogus=3D"1"></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">I'm not sure I co=
mpletely understand your use-case and whether your intent is to extract tra=
ce data after a</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">system crash or i=
f the "snapshot" mode is enough for your needs.</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">Note that the "sh=
m-path" option only applies to UST (user-space) traces at the moment. It ha=
s not been implemented</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">for kernel tracin=
g yet.</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">The way we typica=
lly use it for extraction of trace data from user-space when a system crash=
es is to use the pmem driver to</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">create a block de=
vice out of a range of the system memory, and then use ext2 or ext4 with th=
e DAX mount option to ensure</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">the filesystem by=
passes the page cache.</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">Then we ensure th=
at kexec is used to boot a new kernel on crash, or make sure the BIOS does =
not erase the</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">memory content on=
 soft reboot, which gives access to the shm-path buffers after crash/reboot=
.</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">We don't usually =
use /dev/shm as an argument to --shm-path. This path is normally used to ho=
ld POSIX shared memory</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">files. I would ex=
pect a different mount point path as argument to --shm-path which points to=
 a DAX-enabled filesystem</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">backed by a PMEM =
block device.</span></p>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">Thanks,</span></p=
>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">Mathieu</span></p=
>
</div>
<div>

</div>
</div>
<div>

</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">--
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black;mso-fareast-language:DE">Mathieu Desnoyers=
<br>
EfficiOS Inc.<br><a href=3D"https://clicktime.symantec.com/32vnSPUsVCfHCkkw=
oyPymVx7Vc?u=3Dhttp%3A%2F%2Fwww.efficios.com" target=3D"_blank">https://cli=
cktime.symantec.com/32vnSPUsVCfHCkkwoyPymVx7Vc?u=3Dhttp%3A%2F%2Fwww.efficio=
s.com</a></span><br data-mce-bogus=3D"1"></p>
</div>
</div>
</div><br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST_=
_">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effic=
ios.com</div></div></body></html>
--=_adb47d24-e896-4c9b-96da-8acceaca1c59--

--===============5201394111716759863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5201394111716759863==--
