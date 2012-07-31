From: Rui Han <r.han@umiami.edu>
Subject: how to get the sockaddr struct from its pointer in
	kernel tracing
Date: Mon, 30 Jul 2012 23:22:24 -0400
Message-ID: <CABy43G-atS7UTMYnjTBv_dnZa6jE7fb2TTF2VZ6X66JLoaASww__6394.14911061085$1343704978$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0518549037=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1Sw32V-0000rC-5m
	for lttng-dev@lists.lttng.org; Mon, 30 Jul 2012 23:22:31 -0400
Received: by obbtb18 with SMTP id tb18so12722563obb.35
	for <lttng-dev@lists.lttng.org>; Mon, 30 Jul 2012 20:22:24 -0700 (PDT)
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

--===============0518549037==
Content-Type: multipart/alternative; boundary=bcaec54c527cdf259f04c617af41

--bcaec54c527cdf259f04c617af41
Content-Type: text/plain; charset=ISO-8859-1

Hi,

In the sys_connect and sys_bind kernel tracing, a pointer to the socdaddr
struct has been dumped. (i.e. the second argument in sys_bind: { cpu_id = 0
}, { fd = 39, umyaddr = 0x7FE18E3D0B80, addrlen = 0xC }). What if I want to
access the struct for the IP and port number related to the socket? Is
there an easy way to do this? Please give me some hints. Thank you very
much.

Regards,
Rui

--bcaec54c527cdf259f04c617af41
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>In the sys_connect and sys_bind kernel tracing, a po=
inter to the socdaddr struct has been dumped. (i.e. the second argument in =
sys_bind: { cpu_id =3D 0 }, { fd =3D 39, umyaddr =3D 0x7FE18E3D0B80, addrle=
n =3D 0xC }). What if I want to access the struct for the IP and port numbe=
r related to the socket? Is there an easy way to do this? Please give me so=
me hints. Thank you very much.</div>
<div><br></div><div>Regards,</div><div>Rui=A0</div>

--bcaec54c527cdf259f04c617af41--


--===============0518549037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0518549037==--
