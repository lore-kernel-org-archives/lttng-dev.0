From: Francis Deslauriers <fdeslaur@gmail.com>
Subject: [RFC-PATCH] Adding trap tracepoints definitions
Date: Thu, 14 Mar 2013 20:25:32 -0400
Message-ID: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA__47674.8251975097$1363317126$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0812677088=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <fdeslaur@gmail.com>) id 1UGIT8-00030B-D9
	for lttng-dev@lists.lttng.org; Thu, 14 Mar 2013 20:25:58 -0400
Received: by mail-lb0-f177.google.com with SMTP id go11so2316892lbb.22
	for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2013 17:25:52 -0700 (PDT)
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

--===============0812677088==
Content-Type: multipart/alternative; boundary=f46d04426b6685047104d7ebaeb2

--f46d04426b6685047104d7ebaeb2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am currently working on adding trap tracepoints in the kernel. As of now,
i
have an implementation of the tracepoints trap_entry and trap_exit. I have
created a LTTng probe for those events as well.

It would really be appreciated that you, LTTng guys, can give me your
comments
about my work already done. It would also be great if some of you could
test it
during a "not so short" amount of time, so we could perhaps propose the
patches
to add these tracepoints in the mainline kernel after having tested them
properly.

I will first send a patch concerning the implementation of the tracepoints.
This will be followed by a lttng-modules patch adding the LTTng trap probe.
Finally, i will send a patch about the locations of the tracepoints in the
kernel
itself.

Feel free to give general comments and critics in reply of this email, and
specific
comments in reply to the patches they apply to.

Thanks,

Francis Deslauriers

--f46d04426b6685047104d7ebaeb2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Hi,</span><br style=3D"font-family:arial,sans-serif;font-size:13px"><br s=
tyle=3D"font-family:arial,sans-serif;font-size:13px"><span style=3D"font-fa=
mily:arial,sans-serif;font-size:13px">I am currently working on adding trap=
 tracepoints in the kernel. As of now, i</span><br style=3D"font-family:ari=
al,sans-serif;font-size:13px">

<span style=3D"font-family:arial,sans-serif;font-size:13px">have an impleme=
ntation of the tracepoints trap_entry and trap_exit. I have=A0</span><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px">created=A0a LTTng prob=
e for those events as well.<br>

<br>It would really be appreciated that you, LTTng guys, can give me your c=
omments<br>about my work already done. It would also be great if some of yo=
u could test it=A0<br>during a &quot;not so short&quot; amount of time, so =
we could perhaps propose the patches<br>

to add these tracepoints in the mainline kernel after having tested them pr=
operly.<br><br>I will first send a patch concerning the implementation of t=
he tracepoints.<br>This will be followed by a lttng-modules patch adding th=
e LTTng trap probe.<br>

Finally, i will send a patch about the locations of the tracepoints in the =
kernel<br>itself.<br><br>Feel free to give general comments and critics in =
reply of this email, and specific<br>comments in reply to the patches they =
apply to.<br>

<br>Thanks,<br><br>Francis Deslauriers</div></div>

--f46d04426b6685047104d7ebaeb2--


--===============0812677088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0812677088==--
