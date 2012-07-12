From: Rui Han <r.han@umiami.edu>
Subject: Could I enable a particular system call tracing in
	LTTng 2.0
Date: Thu, 12 Jul 2012 11:43:54 -0400
Message-ID: <CABy43G-toVGrA4s5AkMWk8f_F-q_V+3A+VQYxqTTV+hfYf-RmQ__14196.2102534764$1342107977$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1906286031=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1SpLYe-00063V-Re
	for lttng-dev@lists.lttng.org; Thu, 12 Jul 2012 11:44:00 -0400
Received: by qcsc21 with SMTP id c21so1836060qcs.35
	for <lttng-dev@lists.lttng.org>; Thu, 12 Jul 2012 08:43:54 -0700 (PDT)
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

--===============1906286031==
Content-Type: multipart/alternative; boundary=e89a8fb1f674bb7f0a04c4a3d4e4

--e89a8fb1f674bb7f0a04c4a3d4e4
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I just start using LTTng for my project. I found the system call tracing is
verbose. What if I only want have one or several particular syscalls
logged, how could I do that? Is there an easy way to do this like for
kernel events by "lttng enable-event sched_switch -k."?

Thank you very much.

Regards,
Rui

--e89a8fb1f674bb7f0a04c4a3d4e4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I just start using LTTng for my project. I found the=
 system call tracing is verbose. What if I only want have one or several pa=
rticular syscalls logged, how could I do that? Is there an easy way to do t=
his like for kernel events by &quot;lttng enable-event sched_switch -k.&quo=
t;?</div>
<div><br></div><div>Thank you very much.</div><div><br></div><div>Regards,<=
/div><div>Rui</div>

--e89a8fb1f674bb7f0a04c4a3d4e4--


--===============1906286031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1906286031==--
