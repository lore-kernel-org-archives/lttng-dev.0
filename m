From: Rui Han <r.han@umiami.edu>
Subject: Question about file descriptor of sockets and pipes
Date: Thu, 19 Jul 2012 17:55:34 -0400
Message-ID: <CABy43G9mrdgQ_rnoCpFzBtHSxP=W3umtUWyvKzQ4_VTb46Ppxw__43475.3229063519$1342734975$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0593638302=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1SryhA-0007ao-Vm
	for lttng-dev@lists.lttng.org; Thu, 19 Jul 2012 17:55:41 -0400
Received: by ggnk4 with SMTP id k4so3987705ggn.35
	for <lttng-dev@lists.lttng.org>; Thu, 19 Jul 2012 14:55:35 -0700 (PDT)
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

--===============0593638302==
Content-Type: multipart/alternative; boundary=e89a8fb2067ed1c8a204c535d601

--e89a8fb2067ed1c8a204c535d601
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

What does the number "6454" and "6455" in the following dump information
stand for? Are they pipe number and socket number? How did they generated,
I want to figure out what process is using it, where should I start? Thank
you very much.

lttng_statedump_file_descriptor: { cpu_id = 0 }, { pid = 1, fd = 3,
filename = "pipe:[6454]" }
lttng_statedump_file_descriptor: { cpu_id = 0 }, { pid = 1, fd = 7,
filename = "socket:[6455]" }

Regards,
Rui

--e89a8fb2067ed1c8a204c535d601
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,=A0
<div><br></div><div>What does the number &quot;6454&quot; and &quot;6455&qu=
ot; in the following dump information stand for? Are they pipe number and s=
ocket number? How did they generated, I want to figure out what process is =
using it, where should I start? Thank you very much.</div>
<div><br></div><div><div>lttng_statedump_file_descriptor: { cpu_id =3D 0 },=
 { pid =3D 1, fd =3D 3, filename =3D &quot;pipe:[6454]&quot; }</div><div>lt=
tng_statedump_file_descriptor: { cpu_id =3D 0 }, { pid =3D 1, fd =3D 7, fil=
ename =3D &quot;socket:[6455]&quot; }</div>
</div><div><br></div><div>Regards,</div><div>Rui</div>

--e89a8fb2067ed1c8a204c535d601--


--===============0593638302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0593638302==--
