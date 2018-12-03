From: =?UTF-8?B?U3p5bW9uIFLEhXBhxYJh?= <rompacz00@gmail.com>
Subject: Re: Error: Unable to list kernel events: Kernel tracer
 not available
Date: Mon, 3 Dec 2018 17:26:02 +0100
Message-ID: <CAN=_VamhBm1Bnz=tsnF5R8LdqQ6vb9AzLTFUwkzviNRmEUjdkA__24371.9026250348$1543854261$gmane$org@mail.gmail.com>
References: <CAN=_VanV7dh13y8Y787W-zgAisUiEejhKD+4EO2qwWCPXWk79g@mail.gmail.com>
 <20181201000518.GA28340@joraj-alpa>
 <CAN=_Va=ibpRorwzkryNdjfJ5-L4U4V1kgddA6sXeqQ6ye0DYYA@mail.gmail.com>
 <20181203143626.GB28340@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4764188221293999786=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x135.google.com (mail-it1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by lists.lttng.org (Postfix) with ESMTPS id 437r3F1kvYzxgs
 for <lttng-dev@lists.lttng.org>; Mon,  3 Dec 2018 11:26:16 -0500 (EST)
Received: by mail-it1-x135.google.com with SMTP id b5so9447939iti.2
 for <lttng-dev@lists.lttng.org>; Mon, 03 Dec 2018 08:26:16 -0800 (PST)
In-Reply-To: <20181203143626.GB28340@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jonathan.rajotte-julien@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============4764188221293999786==
Content-Type: multipart/alternative; boundary="000000000000a61f9c057c209b43"

--000000000000a61f9c057c209b43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Regarding memory:
~$ free -m
total        used        free      shared  buff/cache   available
Mem:           3518        1601        1063         105         853
1524
Swap:          3655          20        3635

I reinstaled dkms, but still there is no kernel tracer.
Full logs: https://paste.debian.net/1054193/
This part looks strange:

DKMS: uninstall completed.
------------------------------
Deleting module version: 2.10.8
completely from the DKMS tree.
------------------------------
Done.
Unpacking lttng-modules-dkms (2.10.8-1~ubuntu16.04.1) over
(2.10.8-1~ubuntu16.04.1) ...
Setting up lttng-modules-dkms (2.10.8-1~ubuntu16.04.1) ...
Loading new lttng-modules-2.10.8 DKMS files...
Building for 4.4.0-98-generic and 4.4.0-139-generic
Module build for the currently running kernel was skipped since the
kernel source for this kernel does not seem to be installed.
Building initial module for 4.4.0-139-generic
Done.

Regards,



pon., 3 gru 2018 o 15:36 Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> napisa=C5=82(a):

> Hi Szymon,
>
> Based on the sessiond logs and the content of "/lib/modules/`uname
> -r`/extra" there was clearly a problem on lttng-modules-dkms installation=
.
>
> Most of the time, the culprit is the lack of memory at compile time. How
> much memory
> is installed on your system?
>
> Please reinstall the package:
>     sudo apt-get install --reinstall lttng-modules-dkms
>
> Make sure to take a good look at the logs.
>
> Cheers
>
> On Mon, Dec 03, 2018 at 12:30:18PM +0100, Szymon R=C4=85pa=C5=82a wrote:
> > Thanks for response.
> > Please check console logs here: https://paste.debian.net/1054148
> >
> > Thanks in advance for further support.
> > Szymon
> >
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000a61f9c057c209b43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi=
 Jonathan, <br></div><div><br></div><div>Regarding memory:</div><div>~$ fre=
e -m<br>total=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 free=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shared=C2=A0=
 buff/cache=C2=A0=C2=A0 available<br>Mem:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 3518=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
1601=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1063=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 105=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 853=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1524<br>Swap:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3655=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 20=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 36=
35<br></div><div><br></div><div>I reinstaled dkms, but still there is no ke=
rnel tracer.</div><div>Full logs: <a href=3D"https://paste.debian.net/10541=
93/">https://paste.debian.net/1054193/</a></div><div>This part looks strang=
e:<br></div><div><br></div><div>DKMS: uninstall completed.
<br>------------------------------
<br>Deleting module version: 2.10.8
<br>completely from the DKMS tree.
<br>------------------------------
<br>Done.
<br>Unpacking lttng-modules-dkms (2.10.8-1~ubuntu16.04.1) over (2.10.8-1~ub=
untu16.04.1) ...
<br>Setting up lttng-modules-dkms (2.10.8-1~ubuntu16.04.1) ...
<br>Loading new lttng-modules-2.10.8 DKMS files...
<br>Building for 4.4.0-98-generic and 4.4.0-139-generic
<br>Module build for the currently running kernel was skipped since the
<br>kernel source for this kernel does not seem to be installed.
<br>Building initial module for 4.4.0-139-generic
<br>Done.<br></div><div> <br></div><div>Regards, <br></div><div><br></div><=
div><br></div></div></div></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">pon., 3 gru 2018 o 15:36=C2=A0Jonathan Rajotte-Julien &lt;<a hre=
f=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@e=
fficios.com</a>&gt; napisa=C5=82(a):<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">Hi Szymon,<br>
<br>
Based on the sessiond logs and the content of &quot;/lib/modules/`uname<br>
-r`/extra&quot; there was clearly a problem on lttng-modules-dkms installat=
ion.<br>
<br>
Most of the time, the culprit is the lack of memory at compile time. How mu=
ch memory<br>
is installed on your system?<br>
<br>
Please reinstall the package:<br>
=C2=A0 =C2=A0 sudo apt-get install --reinstall lttng-modules-dkms<br>
<br>
Make sure to take a good look at the logs.<br>
<br>
Cheers<br>
<br>
On Mon, Dec 03, 2018 at 12:30:18PM +0100, Szymon R=C4=85pa=C5=82a wrote:<br=
>
&gt; Thanks for response.<br>
&gt; Please check console logs here: <a href=3D"https://paste.debian.net/10=
54148" rel=3D"noreferrer" target=3D"_blank">https://paste.debian.net/105414=
8</a><br>
&gt; <br>
&gt; Thanks in advance for further support.<br>
&gt; Szymon<br>
&gt; <br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--000000000000a61f9c057c209b43--

--===============4764188221293999786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4764188221293999786==--
