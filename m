From: Rui Han <iurnah@gmail.com>
Subject: about sys_read, count argument,
Date: Thu, 4 Oct 2012 13:58:32 -0400
Message-ID: <CABy43G9uUmeLvkwUnhScMfAVyFsOy4eVsw0KfgRxMuNZ=mEZng__37128.8469796584$1349390815$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0994483093=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1TJph0-0002yX-9X
	for lttng-dev@lists.lttng.org; Thu, 04 Oct 2012 13:58:38 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so943512pab.35
	for <lttng-dev@lists.lttng.org>; Thu, 04 Oct 2012 10:58:32 -0700 (PDT)
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

--===============0994483093==
Content-Type: multipart/alternative; boundary=047d7b2ee47fe070d204cb3f8052

--047d7b2ee47fe070d204cb3f8052
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I did a trace about a pdf reader process in my virtual machine, I found
count argument in some of sys_read are extremely large, one of them have
the value of "7161056817779312906". This cannot be true. I need to know
exactly how many bytes have been read and write from the system calls.
Anyone who know what happens here?

Thank you very much.

Rui

--047d7b2ee47fe070d204cb3f8052
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<div><br></div><div>I did a trace about a pdf reader process in my v=
irtual machine, I found count argument in some of=A0sys_read are=A0extremel=
y large, one of them have the value of &quot;7161056817779312906&quot;.=A0T=
his cannot be true.=A0I need to know exactly how many bytes have been read =
and write from the system calls. Anyone who know what happens here?=A0</div=
>
<div><br></div><div>Thank you very much.</div><div><br></div><div>Rui</div>

--047d7b2ee47fe070d204cb3f8052--


--===============0994483093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0994483093==--
