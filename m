From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Re: Patches to enable building on CentOS 5.x (glibc 2.5)
Date: Thu, 16 May 2013 11:14:14 -0400
Message-ID: <CAEzWAeKCwo_OB=3LcDwrRw-NU3UTGbjtd+Hb82hMrj9fA5935w__42256.1453459368$1368717298$gmane$org@mail.gmail.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB23FDCE2B@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1176080999=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Uczsp-00010s-NO
	for lttng-dev@lists.lttng.org; Thu, 16 May 2013 11:14:19 -0400
Received: by mail-vb0-f45.google.com with SMTP id 12so619507vbf.18
	for <lttng-dev@lists.lttng.org>; Thu, 16 May 2013 08:14:14 -0700 (PDT)
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB23FDCE2B@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1176080999==
Content-Type: multipart/alternative; boundary=20cf307d0284ba178004dcd751a0

--20cf307d0284ba178004dcd751a0
Content-Type: text/plain; charset=ISO-8859-1

Hi,

So you made it work with CentOS 5?
I don't know if we want it upstream, but I could maybe use them to build a
package for EPEL5.

Yannick


On Wed, May 15, 2013 at 7:38 AM, David OShea <David.OShea@quantum.com>wrote:

> Hi,
>
> Would contributions of patches to enable lttng-tools and lttng-ust to
> build with glibc 2.5 (as is shipped with CentOS 5.x) and to enable
> lttng-gen-tp to run with Python 2.4 (as shipped on CentOS 5.x) be accepted?
>
> What is missing from glibc 2.5 is:
>
> - a system call wrapper for sched_getcpu()
> - a system call wrapper for sync_file_range()
> - htobe32() and other similar endian conversion functions
>
> babeltrace and userspace-rcu did not require patching.
>
> Thanks in advance,
> David
>
> P.S. If you see this, thanks for all your recent replies, Mathieu, I will
> try to get back to you soon!
>
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any
> disclosure, copying, or further distribution of confidential information is
> not permitted unless such privilege is explicitly granted in writing by
> Quantum. Quantum reserves the right to have electronic communications,
> including email and attachments, sent across its networks filtered through
> anti virus and spam software programs and retain such messages in order to
> comply with applicable data security and retention requirements. Quantum is
> not responsible for the proper and complete transmission of the substance
> of this communication or for any delay in its receipt.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- 
Yannick Brosseau
yannickbrosseau.com

--20cf307d0284ba178004dcd751a0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br>So you made it work with CentOS 5?<br=
></div>I don&#39;t know if we want it upstream, but I could maybe use them =
to build a package for EPEL5.<br><br></div>Yannick<br></div><div class=3D"g=
mail_extra">
<br><br><div class=3D"gmail_quote">On Wed, May 15, 2013 at 7:38 AM, David O=
Shea <span dir=3D"ltr">&lt;<a href=3D"mailto:David.OShea@quantum.com" targe=
t=3D"_blank">David.OShea@quantum.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
Hi,<br>
<br>
Would contributions of patches to enable lttng-tools and lttng-ust to build=
 with glibc 2.5 (as is shipped with CentOS 5.x) and to enable lttng-gen-tp =
to run with Python 2.4 (as shipped on CentOS 5.x) be accepted?<br>
<br>
What is missing from glibc 2.5 is:<br>
<br>
- a system call wrapper for sched_getcpu()<br>
- a system call wrapper for sync_file_range()<br>
- htobe32() and other similar endian conversion functions<br>
<br>
babeltrace and userspace-rcu did not require patching.<br>
<br>
Thanks in advance,<br>
David<br>
<br>
P.S. If you see this, thanks for all your recent replies, Mathieu, I will t=
ry to get back to you soon!<br>
<br>
----------------------------------------------------------------------<br>
The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through anti viru=
s and spam software programs and retain such messages in order to comply wi=
th applicable data security and retention requirements. Quantum is not resp=
onsible for the proper and complete transmission of the substance of this c=
ommunication or for any delay in its receipt.<br>

<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Yannick Brosseau<br><a =
href=3D"http://yannickbrosseau.com" target=3D"_blank">yannickbrosseau.com</=
a>
</div>

--20cf307d0284ba178004dcd751a0--


--===============1176080999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1176080999==--
