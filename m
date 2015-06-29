From: Aravind HT <aravind.ht@gmail.com>
Subject: Valgrind Memory Error in lttng-relayd
Date: Mon, 29 Jun 2015 23:51:25 +0530
Message-ID: <CACd+_b7wB+RQNMBnFj6HZgHi4_a3-_giVfBJFBwkLeCbi8Hr9Q__34253.1556067572$1435603146$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1784248606=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f51.google.com ([209.85.215.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1Z9dgR-0008DK-Ds
 for lttng-dev@lists.lttng.org; Mon, 29 Jun 2015 14:21:39 -0400
Received: by lagc2 with SMTP id c2so20147580lag.3
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2015 11:21:25 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1784248606==
Content-Type: multipart/alternative; boundary=001a11347920551cd70519ac2810

--001a11347920551cd70519ac2810
Content-Type: text/plain; charset=UTF-8

Hi,

I ran valgrind on lttng-relayd for a soft hang issue that I had reported
earlier.
http://lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html

Below are the list of errors that I found.

==793== Thread 4:
==793== Invalid write of size 8
==793==    at 0x406038: cds_list_add (list.h:53)
==793==    by 0x409442: queue_stream (main.c:1175)
==793==    by 0x409AB7: relay_add_stream (main.c:1274)
==793==    by 0x40C47A: relay_process_control (main.c:2099)
==793==    by 0x40DBB1: relay_thread_worker (main.c:2574)
==793==    by 0x5BDAFE2: start_thread (pthread_create.c:312)
==793==    by 0x5ED8AFC: clone (clone.S:111)
==793==  Address 0x6e09040 is 64 bytes inside a block of size 312 free'd
==793==    at 0x4C2898C: free (in
/usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==793==    by 0x418EF8: rcu_destroy_stream (stream.c:33)
==793==    by 0x5079C94: ??? (in /usr/lib64/liburcu.so.2.0.0)
==793==    by 0x5BDAFE2: start_thread (pthread_create.c:312)
==793==    by 0x5ED8AFC: clone (clone.S:111)
==793==

Are there any known bugs/fixes for these ?


Regards,
Aravind.

--001a11347920551cd70519ac2810
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I ran valgrind on lttng-relayd for =
a soft hang issue that I had reported earlier.</div><div><a href=3D"http://=
lists.lttng.org/pipermail/lttng-dev/2015-May/024533.html">http://lists.lttn=
g.org/pipermail/lttng-dev/2015-May/024533.html</a><br></div><div><br></div>=
<div>Below are the list of errors that I found.</div><div><br></div><div><d=
iv>=3D=3D793=3D=3D Thread 4:</div><div>=3D=3D793=3D=3D Invalid write of siz=
e 8</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0at 0x406038: cds_list_add (list.=
h:53)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x409442: queue_stream (mai=
n.c:1175)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x409AB7: relay_add_str=
eam (main.c:1274)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x40C47A: relay=
_process_control (main.c:2099)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x=
40DBB1: relay_thread_worker (main.c:2574)</div><div>=3D=3D793=3D=3D =C2=A0 =
=C2=A0by 0x5BDAFE2: start_thread (pthread_create.c:312)</div><div>=3D=3D793=
=3D=3D =C2=A0 =C2=A0by 0x5ED8AFC: clone (clone.S:111)</div><div>=3D=3D793=
=3D=3D =C2=A0Address 0x6e09040 is 64 bytes inside a block of size 312 free&=
#39;d</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0at 0x4C2898C: free (in /usr/li=
b64/valgrind/vgpreload_memcheck-amd64-linux.so)</div><div>=3D=3D793=3D=3D =
=C2=A0 =C2=A0by 0x418EF8: rcu_destroy_stream (stream.c:33)</div><div>=3D=3D=
793=3D=3D =C2=A0 =C2=A0by 0x5079C94: ??? (in /usr/lib64/liburcu.so.2.0.0)</=
div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5BDAFE2: start_thread (pthread_c=
reate.c:312)</div><div>=3D=3D793=3D=3D =C2=A0 =C2=A0by 0x5ED8AFC: clone (cl=
one.S:111)</div><div>=3D=3D793=3D=3D</div></div><div><br></div><div>Are the=
re any known bugs/fixes for these ?</div><div><br></div><div><br></div><div=
>Regards,</div><div>Aravind.</div><div><br></div></div>

--001a11347920551cd70519ac2810--


--===============1784248606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1784248606==--
