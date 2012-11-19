From: wang wangwar <wangwangwar@gmail.com>
Subject: Re: lttng - ubuntu 11.10 - problem
Date: Mon, 19 Nov 2012 19:18:11 +0800
Message-ID: <CAMWix0vVatAueBTj6p+Qi52i+zc_LwQS8yVq1fhW0Ucvc_z9dw__47204.5569135391$1353323932$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2146001406=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <wangwangwar@gmail.com>) id 1TaPMn-0002wL-Fb
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 06:18:17 -0500
Received: by mail-ee0-f48.google.com with SMTP id b57so3124361eek.35
	for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2012 03:18:11 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2146001406==
Content-Type: multipart/alternative; boundary=e89a8f646fa9d3a03604ced745db

--e89a8f646fa9d3a03604ced745db
Content-Type: text/plain; charset=ISO-8859-1

This is my simple solution.
Enter the lttng module build dir (like /var/lib/dkms/lttng-modules/2.0.0/build/
as your log says),
open lttng-syscalls.c, comment the definition of is_compat_task(void) (line
32 to 35),
finally

> # make

# make modules_install

# depmod -a

I don't know why but it just work:) My system is LinuxMint 12 (with
Ubuntu 11.10 core), so I
think it works to you, too.





wang

--e89a8f646fa9d3a03604ced745db
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is my simple solution.<div>Enter the lttng module build dir (like=A0<s=
pan style=3D"white-space:pre-wrap">/var/lib/dkms/lttng-modules/2.0.0/build/=
 as your log says</span>)<span style=3D"white-space:pre-wrap">,</span></div=
><div>
<span style=3D"white-space:pre-wrap">open lttng-syscalls.c, comment the def=
inition of is_compat_task(void) (line 32 to 35),</span></div><div><span sty=
le=3D"white-space:pre-wrap">finally </span></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<span style=3D"white-space:pre-wrap"># make</span>=A0</blockquote><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-le=
ft:1ex">
<span style=3D"white-space:pre-wrap"># make modules_install</span></blockqu=
ote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:sol=
id;padding-left:1ex">
# depmod -a</blockquote><div>I don&#39;t know why but it just work:) My sys=
tem is LinuxMint 12 (with Ubuntu=A011.10 core), so I=A0</div><div>think it =
works to you, too.</div><div><br></div><div><br></div><div><br></div><div><=
br>
</div><div><br></div><div>wang</div>

--e89a8f646fa9d3a03604ced745db--


--===============2146001406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2146001406==--
