From: Anand Neeli <anand.neeli@gmail.com>
Subject: Separate trace file per app
Date: Thu, 28 Nov 2013 15:46:31 +0530
Message-ID: <CAM5kDqxQgXi+o4tfb6pZ+Po0qsMTm3aM2_tfLi3TAJNucUtHbQ__6547.22302356294$1386054911$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1298878458=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <anand.neeli@gmail.com>) id 1VlyeD-0006QK-4W
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 05:16:37 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so12246643pbc.25
	for <lttng-dev@lists.lttng.org>; Thu, 28 Nov 2013 02:16:31 -0800 (PST)
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

--===============1298878458==
Content-Type: multipart/alternative; boundary=e89a8ff1cb42e8e95d04ec3a019f

--e89a8ff1cb42e8e95d04ec3a019f
Content-Type: text/plain; charset=ISO-8859-1

Hi All,
How can i create separate trace-file per app?

As shown below, i have created two trace sessions and filtered based on
procname.
Is this the correct way? or is there any other efficient way to do it?


./lttng create app_1_trace
./lttng enable-event -s app_1_trace -u -a --filter '$ctx.procname ==
"app_1"'
./lttng start app_1_trace
now run app_1    ./app_1


./lttng create app_2_trace
./lttng enable-event -s app_2_trace -u -a --filter '$ctx.procname ==
"app_2"'
./lttng start app_2_trace
now run app_2     ./app_2



Thanks,
Anand Neeli

--e89a8ff1cb42e8e95d04ec3a019f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>How can i create separate trace-file per app?<=
/div><div><br></div><div>As shown below, i have created two trace sessions =
and filtered based on procname.</div><div>Is this the correct way? or is th=
ere any other efficient way to do it?</div>
<div><br></div><div><br></div><div><div>./lttng create app_1_trace</div><di=
v>./lttng enable-event -s=A0app_1_trace=A0-u -a --filter &#39;$ctx.procname=
 =3D=3D &quot;app_1&quot;&#39;</div><div>./lttng start app_1_trace</div><di=
v>now run app_1 =A0 =A0./app_1</div>
<div><br></div><div><br></div><div>./lttng create app_2_trace</div><div>./l=
ttng enable-event -s=A0app_2_trace=A0-u -a --filter &#39;$ctx.procname =3D=
=3D &quot;app_2&quot;&#39;</div><div>./lttng start app_2_trace</div><div>no=
w run app_2 =A0 =A0 ./app_2</div>
<div><br></div></div><div><br></div><div><br></div><div>Thanks,</div><div>A=
nand Neeli</div></div>

--e89a8ff1cb42e8e95d04ec3a019f--


--===============1298878458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1298878458==--
